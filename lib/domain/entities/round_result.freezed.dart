// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'round_result.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$RoundResult {
  Move get playerMove => throw _privateConstructorUsedError;
  Move get cpuMove => throw _privateConstructorUsedError;
  GameOutcome get outcome => throw _privateConstructorUsedError;
  DateTime get playedAt => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $RoundResultCopyWith<RoundResult> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RoundResultCopyWith<$Res> {
  factory $RoundResultCopyWith(
          RoundResult value, $Res Function(RoundResult) then) =
      _$RoundResultCopyWithImpl<$Res, RoundResult>;
  @useResult
  $Res call(
      {Move playerMove, Move cpuMove, GameOutcome outcome, DateTime playedAt});
}

/// @nodoc
class _$RoundResultCopyWithImpl<$Res, $Val extends RoundResult>
    implements $RoundResultCopyWith<$Res> {
  _$RoundResultCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? playerMove = null,
    Object? cpuMove = null,
    Object? outcome = null,
    Object? playedAt = null,
  }) {
    return _then(_value.copyWith(
      playerMove: null == playerMove
          ? _value.playerMove
          : playerMove // ignore: cast_nullable_to_non_nullable
              as Move,
      cpuMove: null == cpuMove
          ? _value.cpuMove
          : cpuMove // ignore: cast_nullable_to_non_nullable
              as Move,
      outcome: null == outcome
          ? _value.outcome
          : outcome // ignore: cast_nullable_to_non_nullable
              as GameOutcome,
      playedAt: null == playedAt
          ? _value.playedAt
          : playedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$RoundResultImplCopyWith<$Res>
    implements $RoundResultCopyWith<$Res> {
  factory _$$RoundResultImplCopyWith(
          _$RoundResultImpl value, $Res Function(_$RoundResultImpl) then) =
      __$$RoundResultImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {Move playerMove, Move cpuMove, GameOutcome outcome, DateTime playedAt});
}

/// @nodoc
class __$$RoundResultImplCopyWithImpl<$Res>
    extends _$RoundResultCopyWithImpl<$Res, _$RoundResultImpl>
    implements _$$RoundResultImplCopyWith<$Res> {
  __$$RoundResultImplCopyWithImpl(
      _$RoundResultImpl _value, $Res Function(_$RoundResultImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? playerMove = null,
    Object? cpuMove = null,
    Object? outcome = null,
    Object? playedAt = null,
  }) {
    return _then(_$RoundResultImpl(
      playerMove: null == playerMove
          ? _value.playerMove
          : playerMove // ignore: cast_nullable_to_non_nullable
              as Move,
      cpuMove: null == cpuMove
          ? _value.cpuMove
          : cpuMove // ignore: cast_nullable_to_non_nullable
              as Move,
      outcome: null == outcome
          ? _value.outcome
          : outcome // ignore: cast_nullable_to_non_nullable
              as GameOutcome,
      playedAt: null == playedAt
          ? _value.playedAt
          : playedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc

class _$RoundResultImpl implements _RoundResult {
  const _$RoundResultImpl(
      {required this.playerMove,
      required this.cpuMove,
      required this.outcome,
      required this.playedAt});

  @override
  final Move playerMove;
  @override
  final Move cpuMove;
  @override
  final GameOutcome outcome;
  @override
  final DateTime playedAt;

  @override
  String toString() {
    return 'RoundResult(playerMove: $playerMove, cpuMove: $cpuMove, outcome: $outcome, playedAt: $playedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RoundResultImpl &&
            (identical(other.playerMove, playerMove) ||
                other.playerMove == playerMove) &&
            (identical(other.cpuMove, cpuMove) || other.cpuMove == cpuMove) &&
            (identical(other.outcome, outcome) || other.outcome == outcome) &&
            (identical(other.playedAt, playedAt) ||
                other.playedAt == playedAt));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, playerMove, cpuMove, outcome, playedAt);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$RoundResultImplCopyWith<_$RoundResultImpl> get copyWith =>
      __$$RoundResultImplCopyWithImpl<_$RoundResultImpl>(this, _$identity);
}

abstract class _RoundResult implements RoundResult {
  const factory _RoundResult(
      {required final Move playerMove,
      required final Move cpuMove,
      required final GameOutcome outcome,
      required final DateTime playedAt}) = _$RoundResultImpl;

  @override
  Move get playerMove;
  @override
  Move get cpuMove;
  @override
  GameOutcome get outcome;
  @override
  DateTime get playedAt;
  @override
  @JsonKey(ignore: true)
  _$$RoundResultImplCopyWith<_$RoundResultImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
