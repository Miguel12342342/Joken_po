import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/di/injection.dart';
import '../../../core/theme/app_theme.dart';
import '../../../domain/entities/move.dart';
import '../../../domain/failures/failure.dart';
import '../cubit/game_cubit.dart';
import '../cubit/game_state.dart';
import '../widgets/battle_area.dart';
import '../widgets/move_button.dart';
import '../widgets/result_message.dart';
import '../widgets/score_board.dart';

const _assetPaths = {
  Move.rock:     'images/pedra.png',
  Move.paper:    'images/papel.png',
  Move.scissors: 'images/tesoura.png',
};

class GamePage extends StatelessWidget {
  const GamePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<GameCubit>(),
      child: const _GameView(),
    );
  }
}

class _GameView extends StatelessWidget {
  const _GameView();

  @override
  Widget build(BuildContext context) {
    // Scaffold e AppBar fora do BlocConsumer — não são reconstruídos
    // a cada tick do slot machine.
    return Scaffold(
      appBar: _buildAppBar(context),
      body: SafeArea(
        child: BlocConsumer<GameCubit, GameState>(
          listenWhen: (_, curr) => curr is GameError,
          listener: _onError,
          builder: (context, state) => _GameLayout(state: state),
        ),
      ),
    );
  }

  void _onError(BuildContext context, GameState state) {
    if (state case GameError(:final failure)) {
      final icon = switch (failure) {
        PersistenceFailure() => '💾',
        CpuMoveFailure()     => '🎲',
        UnexpectedFailure()  => '⚠️',
      };
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(SnackBar(
          content: Text('$icon  ${failure.message}'),
          backgroundColor: AppColors.loss.withValues(alpha: 0.9),
        ));
    }
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      title: const Text('JOKENPÔ'),
      actions: [
        IconButton(
          icon: const Icon(Icons.refresh_rounded),
          tooltip: 'Resetar placar',
          // Confirmação antes de ação destrutiva — clique acidental
          // não apaga o placar do usuário
          onPressed: () => _confirmReset(context),
        ),
        const SizedBox(width: 8),
      ],
    );
  }

  void _confirmReset(BuildContext context) {
    // Captura o cubit antes de entrar no dialog (novo contexto)
    final cubit = context.read<GameCubit>();
    showDialog<void>(
      context: context,
      builder: (dialogCtx) => AlertDialog(
        backgroundColor: AppColors.surface,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Text(
          'Resetar placar?',
          style: TextStyle(color: AppColors.textPrimary, fontSize: 18),
        ),
        content: const Text(
          'O placar desta sessão será zerado.',
          style: TextStyle(color: AppColors.textSecondary),
        ),
        actions: [
          TextButton(
            onPressed: Navigator.of(dialogCtx).pop,
            child: const Text('Cancelar'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(dialogCtx).pop();
              cubit.resetScore();
            },
            child: Text(
              'Resetar',
              style: TextStyle(color: AppColors.loss),
            ),
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Layout principal — sem SingleChildScrollView
//
// Padrão de jogo mobile: zona de feedback no centro (Expanded),
// zona de ação no fundo (altura fixa, zona do polegar).
// SingleChildScrollView seria padrão de formulário — errado aqui.
// ---------------------------------------------------------------------------

class _GameLayout extends StatelessWidget {
  final GameState state;
  const _GameLayout({required this.state});

  @override
  Widget build(BuildContext context) {
    final isThinking = state is GameThinking;

    final selectedMove = switch (state) {
      GameThinking(:final playerMove) => playerMove,
      GameResult(:final roundResult)  => roundResult.playerMove,
      _                               => null,
    };

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          const SizedBox(height: 16),

          // ── Placar ─────────────────────────────────────────────────
          // BlocSelector: reconstrói apenas quando o placar muda,
          // isolado dos 10 rebuilds/segundo do slot machine.
          BlocSelector<GameCubit, GameState, (int, int)>(
            selector: (s) => (s.playerScore, s.cpuScore),
            builder: (_, scores) => ScoreBoard(
              playerScore: scores.$1,
              cpuScore: scores.$2,
            ),
          ),

          const SizedBox(height: 12),

          // ── Área de batalha: CPU vs Jogador ────────────────────────
          // Expanded: ocupa todo o espaço vertical disponível.
          // O confronto visual é o coração do jogo — merece o maior espaço.
          Expanded(
            child: BattleArea(state: state, assetPaths: _assetPaths),
          ),

          // ── Mensagem de resultado ───────────────────────────────────
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: ResultMessage(state: state),
          ),

          // ── Botões de jogada ────────────────────────────────────────
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: Move.values
                .map((move) => MoveButton(
                      move: move,
                      assetPath: _assetPaths[move]!,
                      isEnabled: !isThinking,
                      isSelected: selectedMove == move,
                      onTap: () => context.read<GameCubit>().playerChose(move),
                    ))
                .toList(),
          ),

          const SizedBox(height: 24),
        ],
      ),
    );
  }
}
