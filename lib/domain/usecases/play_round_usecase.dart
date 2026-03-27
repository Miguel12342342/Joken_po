import 'dart:math';
import '../core/result.dart';
import '../entities/move.dart';
import '../entities/round_result.dart';
import '../failures/failure.dart';
import '../repositories/game_history_repository.dart';

class PlayRoundUseCase {
  final GameHistoryRepository _repository;
  final Random _random;

  const PlayRoundUseCase(this._repository, this._random);

  /// Executa uma rodada e retorna [Result<RoundResult>].
  ///
  /// **Nunca lança exceção** — toda falha é capturada e mapeada
  /// para um subtipo de [Failure], mantendo o contrato explícito
  /// com o chamador (GameCubit).
  ///
  /// Fluxo:
  ///   1. Gera jogada da CPU (pode falhar: [CpuMoveFailure]).
  ///   2. Resolve o resultado via [Move.resolveAgainst] (puro, infalível).
  ///   3. Persiste no repositório (pode falhar: [PersistenceFailure]).
  ///   4. Retorna [Ok<RoundResult>] em caso de sucesso.
  AsyncResult<RoundResult> execute(Move playerMove) async {
    // --- 1. Geração da jogada da CPU ---
    final Move cpuMove;
    try {
      cpuMove = Move.values[_random.nextInt(Move.values.length)];
    } catch (e) {
      // Improvável, mas explícito: captura erro no gerador aleatório.
      return Err(const CpuMoveFailure());
    }

    // --- 2. Lógica de negócio pura — não pode falhar ---
    final outcome = playerMove.resolveAgainst(cpuMove);

    final roundResult = RoundResult(
      playerMove: playerMove,
      cpuMove: cpuMove,
      outcome: outcome,
      playedAt: DateTime.now(),
    );

    // --- 3. Persistência ---
    try {
      await _repository.save(roundResult);
    } on Exception catch (e) {
      // Captura exceções concretas do Hive/Isar e devolve uma Failure
      // tipada — a UI nunca vê a exceção bruta.
      return Err(PersistenceFailure('Erro ao salvar rodada: $e'));
    } catch (e) {
      return Err(UnexpectedFailure('Erro inesperado ao persistir: $e'));
    }

    // --- 4. Sucesso ---
    return Ok(roundResult);
  }
}
