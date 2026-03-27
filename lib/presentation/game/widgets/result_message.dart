import 'package:flutter/material.dart';
import '../../../core/theme/app_theme.dart';
import '../../../domain/entities/move.dart';
import '../cubit/game_state.dart';

/// Mensagem de resultado com AnimatedSwitcher e escala de entrada.
///
/// Separado em widget próprio para que o [AnimatedSwitcher] funcione
/// corretamente: ele precisa que seu `child` tenha uma [Key] diferente
/// a cada troca de conteúdo para disparar a animação.
class ResultMessage extends StatelessWidget {
  final GameState state;

  const ResultMessage({super.key, required this.state});

  @override
  Widget build(BuildContext context) {
    final (text, color, key) = _resolve(state);

    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 400),
      transitionBuilder: (child, animation) => ScaleTransition(
        scale: CurvedAnimation(parent: animation, curve: Curves.elasticOut),
        child: FadeTransition(opacity: animation, child: child),
      ),
      child: _MessageText(key: key, text: text, color: color),
    );
  }

  /// Retorna (mensagem, cor, key) — switch exaustivo sobre GameState.
  (String, Color, ValueKey<String>) _resolve(GameState state) =>
      switch (state) {
        GameInitial() => (
            'Escolha sua jogada abaixo',
            AppColors.textSecondary,
            const ValueKey('initial'),
          ),
        GameThinking() => (
            'App está escolhendo...',
            AppColors.accent,
            const ValueKey('thinking'),
          ),
        GameResult(:final roundResult) => switch (roundResult.outcome) {
            GameOutcome.win => (
                '🎉  Você GANHOU!',
                AppColors.win,
                // Key inclui timestamp: garante re-animação mesmo em vitórias
                // consecutivas. Sem isso, key seria sempre 'win' e o
                // AnimatedSwitcher não dispararia na 2ª, 3ª vitória seguidas.
                ValueKey('win_${roundResult.playedAt.millisecondsSinceEpoch}'),
              ),
            GameOutcome.loss => (
                'Você perdeu...',
                AppColors.loss,
                ValueKey('loss_${roundResult.playedAt.millisecondsSinceEpoch}'),
              ),
            GameOutcome.draw => (
                'Empate! Tente novamente',
                AppColors.draw,
                ValueKey('draw_${roundResult.playedAt.millisecondsSinceEpoch}'),
              ),
          },
        GameError() => (
            'Ocorreu um erro. Jogue novamente.',
            AppColors.loss,
            const ValueKey('error'),
          ),
      };
}

class _MessageText extends StatelessWidget {
  final String text;
  final Color color;

  const _MessageText({super.key, required this.text, required this.color});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: TextAlign.center,
      style: TextStyle(
        fontSize: 22,
        fontWeight: FontWeight.w800,
        color: color,
        letterSpacing: 0.5,
        shadows: [
          Shadow(
            blurRadius: 14,
            color: color.withValues(alpha: 0.5),
            offset: Offset.zero,
          ),
        ],
      ),
    );
  }
}
