import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/core/result.dart';
import '../../../domain/entities/move.dart';
import '../../../domain/failures/failure.dart';
import '../../../domain/usecases/play_round_usecase.dart';
import 'game_state.dart';

class GameCubit extends Cubit<GameState> {
  final PlayRoundUseCase _playRound;

  int _playerScore = 0;
  int _cpuScore = 0;

  GameCubit(this._playRound) : super(const GameState.initial());

  Future<void> playerChose(Move move) async {
    if (state is GameThinking || isClosed) return;

    // Emite UMA ÚNICA vez — sem Timer.periodic aqui.
    // A animação de slot machine é concern da View (SlotMachineDisplay),
    // não do domínio. Cubit só precisa saber "estamos pensando" e
    // qual foi a jogada do jogador.
    emit(GameState.thinking(
      playerScore: _playerScore,
      cpuScore: _cpuScore,
      playerMove: move,
      currentDisplayMove: move, // valor inicial; widget ignora e gerencia o próprio
    ));

    // Aguarda o tempo da animação de slot machine (controlado pelo widget).
    // Duração ligeiramente maior que a animação do widget (1100ms > 1000ms)
    // para garantir que o resultado só apareça depois do slot parar.
    await Future.delayed(const Duration(milliseconds: 1100));
    if (isClosed) return;

    final result = await _playRound.execute(move);

    switch (result) {
      case Ok(:final data):
        switch (data.outcome) {
          case GameOutcome.win:  _playerScore++;
          case GameOutcome.loss: _cpuScore++;
          case GameOutcome.draw: break;
        }
        emit(GameState.result(
          playerScore: _playerScore,
          cpuScore: _cpuScore,
          roundResult: data,
        ));

      case Err(:final failure):
        _handleFailure(failure);
    }
  }

  void resetScore() {
    _playerScore = 0;
    _cpuScore = 0;
    emit(const GameState.initial());
  }

  void _handleFailure(Failure failure) {
    switch (failure) {
      case PersistenceFailure():
        break;
      case CpuMoveFailure():
        break;
      case UnexpectedFailure():
        break;
    }
    emit(GameState.error(
      playerScore: _playerScore,
      cpuScore: _cpuScore,
      failure: failure,
    ));
  }

  // Sem Timer para cancelar — o widget gerencia o próprio ciclo.
}
