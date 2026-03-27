import '../../domain/entities/round_result.dart';
import '../../domain/repositories/game_history_repository.dart';

/// Implementação em memória — não persiste entre sessões.
///
/// Usada para o app funcionar imediatamente sem configurar Hive.
/// Troca para [HiveGameHistoryRepository] mudando uma linha no injection.dart:
///   - getIt.registerLazySingleton<GameHistoryRepository>(
///       () => InMemoryGameHistoryRepository(),  // <-- remover
///       () => HiveGameHistoryRepository(),      // <-- adicionar
///     );
class InMemoryGameHistoryRepository implements GameHistoryRepository {
  final _rounds = <RoundResult>[];

  @override
  Future<List<RoundResult>> getAll() async =>
      List.unmodifiable(_rounds.reversed.toList());

  @override
  Future<void> save(RoundResult result) async => _rounds.add(result);

  @override
  Future<void> clearAll() async => _rounds.clear();
}
