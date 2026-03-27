/// Hierarquia de falhas do domínio.
///
/// Usar [sealed class] garante que qualquer [switch] sobre [Failure]
/// seja verificado **em tempo de compilação** — o compilador rejeita
/// código que não trate todos os subtipos, eliminando bugs de
/// "caso esquecido" (missing case).
///
/// Regra de ouro: a camada Domain define os *tipos* de falha.
/// A camada Data os *instancia* ao capturar exceções concretas.
/// A camada Presentation os *consome* para exibir mensagens.
sealed class Failure {
  final String message;
  const Failure(this.message);
}

/// Erro ao ler ou gravar no banco local (Hive/Isar).
final class PersistenceFailure extends Failure {
  const PersistenceFailure([
    super.message = 'Não foi possível acessar o armazenamento local.',
  ]);
}

/// Erro ao gerar a jogada aleatória da CPU (ex: RNG indisponível).
final class CpuMoveFailure extends Failure {
  const CpuMoveFailure([
    super.message = 'Erro ao gerar a jogada da CPU.',
  ]);
}

/// Qualquer erro não previsto nos casos acima.
final class UnexpectedFailure extends Failure {
  const UnexpectedFailure([
    super.message = 'Ocorreu um erro inesperado. Tente novamente.',
  ]);
}
