import 'package:freezed_annotation/freezed_annotation.dart';
import '../../../domain/entities/move.dart';
import '../../../domain/entities/round_result.dart';
import '../../../domain/failures/failure.dart';

part 'game_state.freezed.dart';

/// Extension com switch exaustivo para acessar campos compartilhados
/// de uma sealed class Freezed sem pattern matching no call site.
///
/// Por que extension e não campo na base?
/// Freezed sealed não permite campos na factory base — cada subtipo
/// declara os seus. A extension centraliza o acesso e mantém o switch
/// exaustivo: adicionar [GameState.newState] sem atualizar aqui = erro
/// de compilação. É o mesmo contrato de segurança, só que do lado do leitor.
extension GameStateScore on GameState {
  int get playerScore => switch (this) {
    GameInitial(:final playerScore)  => playerScore,
    GameThinking(:final playerScore) => playerScore,
    GameResult(:final playerScore)   => playerScore,
    GameError(:final playerScore)    => playerScore,
  };

  int get cpuScore => switch (this) {
    GameInitial(:final cpuScore)  => cpuScore,
    GameThinking(:final cpuScore) => cpuScore,
    GameResult(:final cpuScore)   => cpuScore,
    GameError(:final cpuScore)    => cpuScore,
  };
}

/// Estados do jogo modelados como uma [sealed class] via Freezed.
///
/// Por ser sealed, qualquer [switch] sobre [GameState] na UI é verificado
/// em tempo de compilação. Adicionar um novo estado (ex: [GameMultiplayer])
/// forçará a atualização de cada switch existente — sem exceção silenciosa.
///
/// Fluxo de estados:
///   [GameInitial] → (tap) → [GameThinking] → [GameResult]
///                                          ↘ [GameError]  (falha no usecase)
///   Qualquer estado → (reset) → [GameInitial]
@freezed
sealed class GameState with _$GameState {
  /// Estado inicial antes de qualquer jogada ou após reset.
  const factory GameState.initial({
    @Default(0) int playerScore,
    @Default(0) int cpuScore,
  }) = GameInitial;

  /// Animação "slot machine" em andamento enquanto a CPU "pensa".
  /// [currentDisplayMove] muda a cada tick — a UI usa este campo
  /// para animar a imagem sem reconstruir a árvore inteira.
  const factory GameState.thinking({
    required int playerScore,
    required int cpuScore,
    required Move playerMove,
    required Move currentDisplayMove,
  }) = GameThinking;

  /// Resultado da rodada revelado com sucesso.
  const factory GameState.result({
    required int playerScore,
    required int cpuScore,
    required RoundResult roundResult,
  }) = GameResult;

  /// Falha capturada e mapeada para um [Failure] do domínio.
  ///
  /// A UI pode inspecionar [failure] para exibir mensagens específicas:
  ///   - [PersistenceFailure] → "Não foi possível salvar a partida."
  ///   - [UnexpectedFailure]  → mensagem genérica + botão "Tentar novamente"
  ///
  /// O placar é preservado para que o jogador não perca o progresso.
  const factory GameState.error({
    required int playerScore,
    required int cpuScore,
    required Failure failure,
  }) = GameError;
}
