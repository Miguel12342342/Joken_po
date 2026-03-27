import 'package:flutter/material.dart';
import '../../../core/theme/app_theme.dart';
import '../../../domain/entities/move.dart';
import '../cubit/game_state.dart';

/// Efeito de glow radial que muda de cor conforme o estado do Cubit.
///
/// Arquitetura da animação:
///   1. [didUpdateWidget] detecta transição de estado
///   2. [AnimationController] anima [intensity] de 0→1 (entrada) ou 1→0 (saída)
///   3. [CustomPainter] redesenha apenas quando [intensity] muda
///   4. [RepaintBoundary] isola o repaint do resto da árvore
class ResultGlow extends StatefulWidget {
  final GameState state;
  final Widget child;

  const ResultGlow({super.key, required this.state, required this.child});

  @override
  State<ResultGlow> createState() => _ResultGlowState();
}

class _ResultGlowState extends State<ResultGlow>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late Animation<double> _intensity;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );
    _intensity = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOut,
      reverseCurve: Curves.easeIn,
    );
  }

  @override
  void didUpdateWidget(ResultGlow old) {
    super.didUpdateWidget(old);

    if (widget.state is GameResult && old.state is! GameResult) {
      _controller.forward(from: 0);      // Glow entra no resultado
    } else if (widget.state is GameError && old.state is! GameError) {
      // Flash de erro: anima até 0.6 e reverte — pulso rápido
      _controller.animateTo(0.6).then((_) => _controller.reverse());
    } else if (widget.state is GameInitial) {
      _controller.reverse();             // Glow sai ao resetar
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  /// Cor mapeada do resultado — switch exaustivo garante cobertura total.
  Color get _glowColor => switch (widget.state) {
        GameResult(:final roundResult) => switch (roundResult.outcome) {
            GameOutcome.win  => AppColors.win,
            GameOutcome.loss => AppColors.loss,
            GameOutcome.draw => AppColors.draw,
          },
        _ => AppColors.accent,
      };

  @override
  Widget build(BuildContext context) {
    // RepaintBoundary FORA do AnimatedBuilder:
    // Se estivesse dentro do builder, seria recriado a cada frame (60x/s).
    // Aqui é criado uma única vez — apenas o CustomPaint inválida o layer.
    return RepaintBoundary(
      child: AnimatedBuilder(
        animation: _intensity,
        builder: (context, child) => CustomPaint(
          painter: _GlowPainter(
            glowColor: _glowColor,
            intensity: _intensity.value,
          ),
          child: child,
        ),
        // child estável: não é reconstruído pela animação, só pelo estado
        child: widget.child,
      ),
    );
  }
}

/// Painter puro — apenas desenha, sem lógica de estado.
class _GlowPainter extends CustomPainter {
  final Color glowColor;
  final double intensity;

  const _GlowPainter({required this.glowColor, required this.intensity});

  @override
  void paint(Canvas canvas, Size size) {
    if (intensity <= 0.01) return;

    final center = size.center(Offset.zero);

    // Camada 1: glow difuso externo (RadialGradient — sem blur, performático)
    final outerRadius = size.shortestSide * 0.72;
    final outerPaint = Paint()
      ..shader = RadialGradient(
        colors: [
          glowColor.withValues(alpha: 0.45 * intensity),
          glowColor.withValues(alpha: 0.12 * intensity),
          Colors.transparent,
        ],
        stops: const [0.0, 0.55, 1.0],
      ).createShader(
        Rect.fromCircle(center: center, radius: outerRadius),
      );
    canvas.drawCircle(center, outerRadius, outerPaint);

    // Camada 2: núcleo brilhante (MaskFilter.blur — mais caro, usado só no centro)
    final innerPaint = Paint()
      ..color = glowColor.withValues(alpha: 0.30 * intensity)
      ..maskFilter = MaskFilter.blur(BlurStyle.normal, 22 * intensity);
    canvas.drawCircle(center, size.shortestSide * 0.28, innerPaint);
  }

  @override
  bool shouldRepaint(_GlowPainter old) =>
      old.intensity != intensity || old.glowColor != glowColor;
}
