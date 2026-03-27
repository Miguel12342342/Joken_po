import '../failures/failure.dart';

/// Tipo resultado inspirado em Rust/Haskell — sem dependência de pacotes externos.
///
/// Substitui o padrão try/catch por um contrato explícito:
/// - [Ok] → operação bem-sucedida, carrega o valor [T].
/// - [Err] → operação falhou, carrega um [Failure] tipado.
///
/// O uso de [sealed class] + [switch expression] exaustivo
/// força o chamador a tratar ambos os casos no momento da compilação.
///
/// Exemplo de uso:
/// ```dart
/// final result = await playRound.execute(move);
/// final message = switch (result) {
///   Ok(:final data) => 'Você jogou ${data.playerMove.name}',
///   Err(:final failure) => failure.message, // compilador garante cobertura
/// };
/// ```
sealed class Result<T> {
  const Result();
}

/// Representa uma operação bem-sucedida com o valor resultante.
final class Ok<T> extends Result<T> {
  final T data;
  const Ok(this.data);
}

/// Representa uma operação que falhou com uma [Failure] tipada.
final class Err<T> extends Result<T> {
  final Failure failure;
  const Err(this.failure);
}

/// Alias de conveniência para use cases assíncronos.
typedef AsyncResult<T> = Future<Result<T>>;
