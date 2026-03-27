import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../core/theme/app_theme.dart';
import '../../../domain/entities/move.dart';

/// Label legível por humanos para cada jogada.
extension MoveLabel on Move {
  String get label => switch (this) {
        Move.rock     => 'Pedra',
        Move.paper    => 'Papel',
        Move.scissors => 'Tesoura',
      };
}

/// Botão de jogada com visual Neumorphic + feedback tátil + micro-interação.
///
/// Estados visuais:
///   Normal   → superfície elevada com sombras externas
///   Pressed  → efeito inset (sombras invertidas + gradiente escuro)
///   Selected → glow colorido + borda accent (última jogada)
///   Disabled → opacidade 35% sem interação (durante slot machine)
class MoveButton extends StatefulWidget {
  final Move move;
  final String assetPath;
  final bool isEnabled;
  final bool isSelected;
  final VoidCallback onTap;

  const MoveButton({
    super.key,
    required this.move,
    required this.assetPath,
    required this.isEnabled,
    required this.isSelected,
    required this.onTap,
  });

  @override
  State<MoveButton> createState() => _MoveButtonState();
}

class _MoveButtonState extends State<MoveButton> {
  bool _isPressed = false;

  void _handleTapDown(TapDownDetails _) {
    if (!widget.isEnabled) return;
    setState(() => _isPressed = true);
    // Feedback tátil leve — confirma o toque sem ser intrusivo
    HapticFeedback.lightImpact();
  }

  void _handleTapUp(TapUpDetails _) => setState(() => _isPressed = false);
  void _handleTapCancel() => setState(() => _isPressed = false);

  @override
  Widget build(BuildContext context) {
    // Responsivo: botão cresce/encolhe com a tela
    final size = MediaQuery.sizeOf(context);
    final buttonSize = (size.width * 0.24).clamp(76.0, 100.0);
    final iconSize  = buttonSize * 0.56;

    // Semantics: TalkBack/VoiceOver anuncia "Pedra, botão" etc.
    return Semantics(
      label: widget.move.label,
      button: true,
      enabled: widget.isEnabled,
      child: GestureDetector(
        onTapDown: _handleTapDown,
        onTapUp: _handleTapUp,
        onTapCancel: _handleTapCancel,
        onTap: widget.isEnabled ? widget.onTap : null,
        child: AnimatedOpacity(
          opacity: widget.isEnabled ? 1.0 : 0.35,
          duration: const Duration(milliseconds: 200),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // AnimatedScale no container INTEIRO: sombras neumorphic escalam
              // junto com o conteúdo — o efeito pressionado fica coerente.
              AnimatedScale(
                scale: _isPressed ? 0.88 : 1.0,
                duration: const Duration(milliseconds: 110),
                curve: Curves.easeOut,
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 140),
                  curve: Curves.easeInOut,
                  width: buttonSize,
                  height: buttonSize,
                  decoration: _buildDecoration(),
                  child: Padding(
                    padding: EdgeInsets.all(buttonSize * 0.15),
                    child: Image.asset(widget.assetPath, height: iconSize),
                  ),
                ),
              ),
              const SizedBox(height: 8),
              // Label textual — resolve ambiguidade visual para novos usuários
              AnimatedDefaultTextStyle(
                duration: const Duration(milliseconds: 200),
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: widget.isSelected ? FontWeight.w700 : FontWeight.w400,
                  letterSpacing: 0.5,
                  color: widget.isSelected
                      ? AppColors.accent
                      : AppColors.textSecondary,
                ),
                child: Text(widget.move.label),
              ),
            ],
          ),
        ),
      ),
    );
  }

  BoxDecoration _buildDecoration() {
    if (_isPressed) return Neumorphic.pressed(radius: 22);

    return Neumorphic.elevated(
      radius: 22,
      // Glow accent quando este botão é o selecionado
      accentGlow: widget.isSelected ? AppColors.accent : null,
    ).copyWith(
      // Borda dourada sutil no estado selecionado
      border: widget.isSelected
          ? Border.all(color: AppColors.accent.withValues(alpha: 0.6), width: 1.5)
          : null,
    );
  }
}
