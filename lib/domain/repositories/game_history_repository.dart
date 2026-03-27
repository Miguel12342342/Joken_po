import '../entities/round_result.dart';

/// Contrato da camada Domain para persistência de histórico.
///
/// Usa `abstract interface class` (Dart 3) em vez de `abstract class`:
/// - Semântica mais precisa: é um contrato puro, não uma classe parcial.
/// - Força a implementação de todos os membros sem herança implícita.
/// - A camada Domain define o contrato; a camada Data o implementa.
abstract interface class GameHistoryRepository {
  /// Retorna todas as rodadas salvas, da mais recente para a mais antiga.
  Future<List<RoundResult>> getAll();

  /// Persiste uma rodada. Lança [Exception] em caso de falha de I/O —
  /// o [PlayRoundUseCase] captura e converte para [PersistenceFailure].
  Future<void> save(RoundResult result);

  /// Remove todo o histórico (usado no reset de sessão).
  Future<void> clearAll();
}
