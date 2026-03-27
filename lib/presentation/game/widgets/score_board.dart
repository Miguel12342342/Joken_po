import 'package:flutter/material.dart';
import '../../../core/theme/app_theme.dart';

/// Placar neumorphic com contadores animados.
///
/// Usa [AnimatedSwitcher] por coluna para que cada número "vire" quando
/// muda, em vez de apenas trocar o texto — micro-interação que dá
/// sensação de pontuação real sendo adicionada.
class ScoreBoard extends StatelessWidget {
  final int playerScore;
  final int cpuScore;

  const ScoreBoard({
    super.key,
    required this.playerScore,
    required this.cpuScore,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
      decoration: Neumorphic.elevated(radius: 16).copyWith(
        border: Border.all(
          color: AppColors.accent.withValues(alpha: 0.25),
          width: 1,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _ScoreColumn(label: 'VOCÊ', score: playerScore, color: AppColors.win),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              '×',
              style: TextStyle(
                fontSize: 22,
                color: AppColors.textSecondary,
                fontWeight: FontWeight.w300,
              ),
            ),
          ),
          _ScoreColumn(label: 'APP', score: cpuScore, color: AppColors.loss),
        ],
      ),
    );
  }
}

class _ScoreColumn extends StatelessWidget {
  final String label;
  final int score;
  final Color color;

  const _ScoreColumn({
    required this.label,
    required this.score,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.w600,
            letterSpacing: 2,
            color: AppColors.textSecondary,
          ),
        ),
        const SizedBox(height: 6),
        // AnimatedSwitcher: número "vira" verticalmente ao mudar
        AnimatedSwitcher(
          duration: const Duration(milliseconds: 300),
          transitionBuilder: (child, animation) => SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(0, 0.5),
              end: Offset.zero,
            ).animate(CurvedAnimation(
              parent: animation,
              curve: Curves.easeOutBack,
            )),
            child: FadeTransition(opacity: animation, child: child),
          ),
          child: Text(
            '$score',
            key: ValueKey(score),
            style: TextStyle(
              fontSize: 36,
              fontWeight: FontWeight.w900,
              color: color,
              height: 1,
            ),
          ),
        ),
      ],
    );
  }
}
