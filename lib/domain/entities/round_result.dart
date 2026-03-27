import 'package:freezed_annotation/freezed_annotation.dart';
import 'move.dart';

part 'round_result.freezed.dart';

/// Value object imutável que representa o resultado de uma rodada.
///
/// Gerado pelo Freezed: `dart run build_runner build`
/// Fornece == e hashCode baseados em valor, copyWith e toString automáticos.
@freezed
class RoundResult with _$RoundResult {
  const factory RoundResult({
    required Move playerMove,
    required Move cpuMove,
    required GameOutcome outcome,
    required DateTime playedAt,
  }) = _RoundResult;
}
