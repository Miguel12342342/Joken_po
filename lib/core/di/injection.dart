import 'dart:math';
import 'package:get_it/get_it.dart';
import '../../domain/repositories/game_history_repository.dart';
import '../../domain/usecases/play_round_usecase.dart';
import '../../data/repositories/game_history_repository_impl.dart';
import '../../presentation/game/cubit/game_cubit.dart';

final getIt = GetIt.instance;

/// Registro manual do GetIt — sem geração de código.
///
/// Vantagem: roda imediatamente, zero dependência do build_runner para DI.
/// Migração para @injectable é possível a qualquer momento: basta anotar
/// as classes e rodar `dart run build_runner build` para gerar o config.
Future<void> configureDependencies() async {
  // Infrastructure
  getIt.registerLazySingleton<Random>(() => Random());

  // Repositories — LazySingleton: mesma instância em toda a app
  getIt.registerLazySingleton<GameHistoryRepository>(
    () => InMemoryGameHistoryRepository(),
  );

  // Use Cases — Factory: nova instância a cada resolução (stateless)
  getIt.registerFactory<PlayRoundUseCase>(
    () => PlayRoundUseCase(
      getIt<GameHistoryRepository>(),
      getIt<Random>(),
    ),
  );

  // Cubits — Factory: cada página recebe sua própria instância
  getIt.registerFactory<GameCubit>(
    () => GameCubit(getIt<PlayRoundUseCase>()),
  );
}
