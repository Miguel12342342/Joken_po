import 'package:flutter/material.dart';
import '../../../core/theme/app_theme.dart';
import '../../../domain/entities/move.dart';
import '../cubit/game_state.dart';
import 'result_glow.dart';
import 'slot_machine_display.dart';

/// Área central de confronto: CPU (esquerda) vs Jogador (direita).
///
/// Este widget resolve o maior gap de UX do layout anterior:
/// a jogada do jogador nunca era mostrada como imagem — apenas o botão
/// ficava destacado. Aqui ambas as jogadas ficam visíveis lado a lado,
/// criando o confronto visual que o jogo exige.
///
/// Layout:
///   [CPU label + slot machine]  ──VS──  [Você label + imagem da jogada]
class BattleArea extends StatelessWidget {
  final GameState state;
  final Map<Move, String> assetPaths;

  const BattleArea({
    super.key,
    required this.state,
    required this.assetPaths,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // ── Lado da CPU ──────────────────────────────────────────────
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _ParticipantLabel(label: 'CPU', icon: Icons.smart_toy_rounded),
                const SizedBox(height: 12),
                ResultGlow(
                  state: state,
                  child: SlotMachineDisplay(
                    state: state,
                    assetPaths: assetPaths,
                  ),
                ),
              ],
            ),
          ),

          // ── Divisor VS ────────────────────────────────────────────────
          const _VsDivider(),

          // ── Lado do Jogador ──────────────────────────────────────────
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _ParticipantLabel(label: 'VOCÊ', icon: Icons.person_rounded),
                const SizedBox(height: 12),
                _PlayerMoveDisplay(state: state, assetPaths: assetPaths),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Label de participante
// ---------------------------------------------------------------------------

class _ParticipantLabel extends StatelessWidget {
  final String label;
  final IconData icon;

  const _ParticipantLabel({required this.label, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 14, color: AppColors.textSecondary),
        const SizedBox(width: 5),
        Text(
          label,
          style: const TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.w700,
            letterSpacing: 2.5,
            color: AppColors.textSecondary,
          ),
        ),
      ],
    );
  }
}

// ---------------------------------------------------------------------------
// Imagem da jogada do jogador
// ---------------------------------------------------------------------------

/// Exibe a jogada do jogador com animação de entrada sincronizada
/// com o ritmo do slot machine da CPU.
///
/// Com o Cubit emitindo apenas UMA transição por fase (thinking/result/initial),
/// este widget rebuilda apenas 3 vezes por rodada — não 10x/segundo como antes.
class _PlayerMoveDisplay extends StatelessWidget {
  final GameState state;
  final Map<Move, String> assetPaths;
  static const _defaultAsset = 'images/padrao.png';

  const _PlayerMoveDisplay({required this.state, required this.assetPaths});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final imageSize = (size.width * 0.30).clamp(100.0, 150.0);

    final (assetPath, isActive, key) = switch (state) {
      GameThinking(:final playerMove) => (
          assetPaths[playerMove]!,
          true,
          ValueKey('player_${playerMove.name}'),
        ),
      GameResult(:final roundResult) => (
          assetPaths[roundResult.playerMove]!,
          true,
          ValueKey('player_result_${roundResult.playedAt.millisecondsSinceEpoch}'),
        ),
      _ => (_defaultAsset, false, const ValueKey('player_default')),
    };

    return AnimatedSwitcher(
      // Mesma duração e curva do reveal da CPU — as duas imagens
      // chegam ao estado final juntas, criando coerência visual.
      duration: const Duration(milliseconds: 480),
      // switchInCurve/switchOutCurve: apenas curvas bounded [0, 1].
      // elasticOut overshoot aplicado manualmente no transitionBuilder.
      switchInCurve:  Curves.linear,
      switchOutCurve: Curves.linear,
      transitionBuilder: (child, animation) => ScaleTransition(
        scale: Tween<double>(begin: 0.6, end: 1.0).animate(
          CurvedAnimation(parent: animation, curve: Curves.elasticOut),
        ),
        child: FadeTransition(
          opacity: CurvedAnimation(parent: animation, curve: Curves.easeOut),
          child: child,
        ),
      ),
      child: AnimatedOpacity(
        key: key,
        opacity: isActive ? 1.0 : 0.22,
        duration: const Duration(milliseconds: 300),
        child: Image.asset(
          assetPath,
          height: imageSize,
          width: imageSize,
          fit: BoxFit.contain,
          cacheWidth: imageSize.toInt() * 2,
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Divisor "VS"
// ---------------------------------------------------------------------------

class _VsDivider extends StatelessWidget {
  const _VsDivider();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 1,
            height: 28,
            color: AppColors.textSecondary.withValues(alpha: 0.2),
          ),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
            decoration: BoxDecoration(
              color: AppColors.surfaceHigh,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: AppColors.textSecondary.withValues(alpha: 0.15),
              ),
            ),
            child: const Text(
              'VS',
              style: TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.w900,
                color: AppColors.textSecondary,
                letterSpacing: 1.5,
              ),
            ),
          ),
          const SizedBox(height: 8),
          Container(
            width: 1,
            height: 28,
            color: AppColors.textSecondary.withValues(alpha: 0.2),
          ),
        ],
      ),
    );
  }
}
