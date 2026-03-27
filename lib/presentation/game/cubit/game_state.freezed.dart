// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'game_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$GameState {
  int get playerScore => throw _privateConstructorUsedError;
  int get cpuScore => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(int playerScore, int cpuScore) initial,
    required TResult Function(int playerScore, int cpuScore, Move playerMove,
            Move currentDisplayMove)
        thinking,
    required TResult Function(
            int playerScore, int cpuScore, RoundResult roundResult)
        result,
    required TResult Function(int playerScore, int cpuScore, Failure failure)
        error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(int playerScore, int cpuScore)? initial,
    TResult? Function(int playerScore, int cpuScore, Move playerMove,
            Move currentDisplayMove)?
        thinking,
    TResult? Function(int playerScore, int cpuScore, RoundResult roundResult)?
        result,
    TResult? Function(int playerScore, int cpuScore, Failure failure)? error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(int playerScore, int cpuScore)? initial,
    TResult Function(int playerScore, int cpuScore, Move playerMove,
            Move currentDisplayMove)?
        thinking,
    TResult Function(int playerScore, int cpuScore, RoundResult roundResult)?
        result,
    TResult Function(int playerScore, int cpuScore, Failure failure)? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(GameInitial value) initial,
    required TResult Function(GameThinking value) thinking,
    required TResult Function(GameResult value) result,
    required TResult Function(GameError value) error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(GameInitial value)? initial,
    TResult? Function(GameThinking value)? thinking,
    TResult? Function(GameResult value)? result,
    TResult? Function(GameError value)? error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(GameInitial value)? initial,
    TResult Function(GameThinking value)? thinking,
    TResult Function(GameResult value)? result,
    TResult Function(GameError value)? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $GameStateCopyWith<GameState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GameStateCopyWith<$Res> {
  factory $GameStateCopyWith(GameState value, $Res Function(GameState) then) =
      _$GameStateCopyWithImpl<$Res, GameState>;
  @useResult
  $Res call({int playerScore, int cpuScore});
}

/// @nodoc
class _$GameStateCopyWithImpl<$Res, $Val extends GameState>
    implements $GameStateCopyWith<$Res> {
  _$GameStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? playerScore = null,
    Object? cpuScore = null,
  }) {
    return _then(_value.copyWith(
      playerScore: null == playerScore
          ? _value.playerScore
          : playerScore // ignore: cast_nullable_to_non_nullable
              as int,
      cpuScore: null == cpuScore
          ? _value.cpuScore
          : cpuScore // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$GameInitialImplCopyWith<$Res>
    implements $GameStateCopyWith<$Res> {
  factory _$$GameInitialImplCopyWith(
          _$GameInitialImpl value, $Res Function(_$GameInitialImpl) then) =
      __$$GameInitialImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int playerScore, int cpuScore});
}

/// @nodoc
class __$$GameInitialImplCopyWithImpl<$Res>
    extends _$GameStateCopyWithImpl<$Res, _$GameInitialImpl>
    implements _$$GameInitialImplCopyWith<$Res> {
  __$$GameInitialImplCopyWithImpl(
      _$GameInitialImpl _value, $Res Function(_$GameInitialImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? playerScore = null,
    Object? cpuScore = null,
  }) {
    return _then(_$GameInitialImpl(
      playerScore: null == playerScore
          ? _value.playerScore
          : playerScore // ignore: cast_nullable_to_non_nullable
              as int,
      cpuScore: null == cpuScore
          ? _value.cpuScore
          : cpuScore // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

class _$GameInitialImpl implements GameInitial {
  const _$GameInitialImpl({this.playerScore = 0, this.cpuScore = 0});

  @override
  @JsonKey()
  final int playerScore;
  @override
  @JsonKey()
  final int cpuScore;

  @override
  String toString() {
    return 'GameState.initial(playerScore: $playerScore, cpuScore: $cpuScore)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GameInitialImpl &&
            (identical(other.playerScore, playerScore) ||
                other.playerScore == playerScore) &&
            (identical(other.cpuScore, cpuScore) ||
                other.cpuScore == cpuScore));
  }

  @override
  int get hashCode => Object.hash(runtimeType, playerScore, cpuScore);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$GameInitialImplCopyWith<_$GameInitialImpl> get copyWith =>
      __$$GameInitialImplCopyWithImpl<_$GameInitialImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(int playerScore, int cpuScore) initial,
    required TResult Function(int playerScore, int cpuScore, Move playerMove,
            Move currentDisplayMove)
        thinking,
    required TResult Function(
            int playerScore, int cpuScore, RoundResult roundResult)
        result,
    required TResult Function(int playerScore, int cpuScore, Failure failure)
        error,
  }) {
    return initial(playerScore, cpuScore);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(int playerScore, int cpuScore)? initial,
    TResult? Function(int playerScore, int cpuScore, Move playerMove,
            Move currentDisplayMove)?
        thinking,
    TResult? Function(int playerScore, int cpuScore, RoundResult roundResult)?
        result,
    TResult? Function(int playerScore, int cpuScore, Failure failure)? error,
  }) {
    return initial?.call(playerScore, cpuScore);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(int playerScore, int cpuScore)? initial,
    TResult Function(int playerScore, int cpuScore, Move playerMove,
            Move currentDisplayMove)?
        thinking,
    TResult Function(int playerScore, int cpuScore, RoundResult roundResult)?
        result,
    TResult Function(int playerScore, int cpuScore, Failure failure)? error,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial(playerScore, cpuScore);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(GameInitial value) initial,
    required TResult Function(GameThinking value) thinking,
    required TResult Function(GameResult value) result,
    required TResult Function(GameError value) error,
  }) {
    return initial(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(GameInitial value)? initial,
    TResult? Function(GameThinking value)? thinking,
    TResult? Function(GameResult value)? result,
    TResult? Function(GameError value)? error,
  }) {
    return initial?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(GameInitial value)? initial,
    TResult Function(GameThinking value)? thinking,
    TResult Function(GameResult value)? result,
    TResult Function(GameError value)? error,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial(this);
    }
    return orElse();
  }
}

abstract class GameInitial implements GameState {
  const factory GameInitial({final int playerScore, final int cpuScore}) =
      _$GameInitialImpl;

  @override
  int get playerScore;
  @override
  int get cpuScore;
  @override
  @JsonKey(ignore: true)
  _$$GameInitialImplCopyWith<_$GameInitialImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$GameThinkingImplCopyWith<$Res>
    implements $GameStateCopyWith<$Res> {
  factory _$$GameThinkingImplCopyWith(
          _$GameThinkingImpl value, $Res Function(_$GameThinkingImpl) then) =
      __$$GameThinkingImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int playerScore,
      int cpuScore,
      Move playerMove,
      Move currentDisplayMove});
}

/// @nodoc
class __$$GameThinkingImplCopyWithImpl<$Res>
    extends _$GameStateCopyWithImpl<$Res, _$GameThinkingImpl>
    implements _$$GameThinkingImplCopyWith<$Res> {
  __$$GameThinkingImplCopyWithImpl(
      _$GameThinkingImpl _value, $Res Function(_$GameThinkingImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? playerScore = null,
    Object? cpuScore = null,
    Object? playerMove = null,
    Object? currentDisplayMove = null,
  }) {
    return _then(_$GameThinkingImpl(
      playerScore: null == playerScore
          ? _value.playerScore
          : playerScore // ignore: cast_nullable_to_non_nullable
              as int,
      cpuScore: null == cpuScore
          ? _value.cpuScore
          : cpuScore // ignore: cast_nullable_to_non_nullable
              as int,
      playerMove: null == playerMove
          ? _value.playerMove
          : playerMove // ignore: cast_nullable_to_non_nullable
              as Move,
      currentDisplayMove: null == currentDisplayMove
          ? _value.currentDisplayMove
          : currentDisplayMove // ignore: cast_nullable_to_non_nullable
              as Move,
    ));
  }
}

/// @nodoc

class _$GameThinkingImpl implements GameThinking {
  const _$GameThinkingImpl(
      {required this.playerScore,
      required this.cpuScore,
      required this.playerMove,
      required this.currentDisplayMove});

  @override
  final int playerScore;
  @override
  final int cpuScore;
  @override
  final Move playerMove;
  @override
  final Move currentDisplayMove;

  @override
  String toString() {
    return 'GameState.thinking(playerScore: $playerScore, cpuScore: $cpuScore, playerMove: $playerMove, currentDisplayMove: $currentDisplayMove)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GameThinkingImpl &&
            (identical(other.playerScore, playerScore) ||
                other.playerScore == playerScore) &&
            (identical(other.cpuScore, cpuScore) ||
                other.cpuScore == cpuScore) &&
            (identical(other.playerMove, playerMove) ||
                other.playerMove == playerMove) &&
            (identical(other.currentDisplayMove, currentDisplayMove) ||
                other.currentDisplayMove == currentDisplayMove));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, playerScore, cpuScore, playerMove, currentDisplayMove);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$GameThinkingImplCopyWith<_$GameThinkingImpl> get copyWith =>
      __$$GameThinkingImplCopyWithImpl<_$GameThinkingImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(int playerScore, int cpuScore) initial,
    required TResult Function(int playerScore, int cpuScore, Move playerMove,
            Move currentDisplayMove)
        thinking,
    required TResult Function(
            int playerScore, int cpuScore, RoundResult roundResult)
        result,
    required TResult Function(int playerScore, int cpuScore, Failure failure)
        error,
  }) {
    return thinking(playerScore, cpuScore, playerMove, currentDisplayMove);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(int playerScore, int cpuScore)? initial,
    TResult? Function(int playerScore, int cpuScore, Move playerMove,
            Move currentDisplayMove)?
        thinking,
    TResult? Function(int playerScore, int cpuScore, RoundResult roundResult)?
        result,
    TResult? Function(int playerScore, int cpuScore, Failure failure)? error,
  }) {
    return thinking?.call(
        playerScore, cpuScore, playerMove, currentDisplayMove);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(int playerScore, int cpuScore)? initial,
    TResult Function(int playerScore, int cpuScore, Move playerMove,
            Move currentDisplayMove)?
        thinking,
    TResult Function(int playerScore, int cpuScore, RoundResult roundResult)?
        result,
    TResult Function(int playerScore, int cpuScore, Failure failure)? error,
    required TResult orElse(),
  }) {
    if (thinking != null) {
      return thinking(playerScore, cpuScore, playerMove, currentDisplayMove);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(GameInitial value) initial,
    required TResult Function(GameThinking value) thinking,
    required TResult Function(GameResult value) result,
    required TResult Function(GameError value) error,
  }) {
    return thinking(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(GameInitial value)? initial,
    TResult? Function(GameThinking value)? thinking,
    TResult? Function(GameResult value)? result,
    TResult? Function(GameError value)? error,
  }) {
    return thinking?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(GameInitial value)? initial,
    TResult Function(GameThinking value)? thinking,
    TResult Function(GameResult value)? result,
    TResult Function(GameError value)? error,
    required TResult orElse(),
  }) {
    if (thinking != null) {
      return thinking(this);
    }
    return orElse();
  }
}

abstract class GameThinking implements GameState {
  const factory GameThinking(
      {required final int playerScore,
      required final int cpuScore,
      required final Move playerMove,
      required final Move currentDisplayMove}) = _$GameThinkingImpl;

  @override
  int get playerScore;
  @override
  int get cpuScore;
  Move get playerMove;
  Move get currentDisplayMove;
  @override
  @JsonKey(ignore: true)
  _$$GameThinkingImplCopyWith<_$GameThinkingImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$GameResultImplCopyWith<$Res>
    implements $GameStateCopyWith<$Res> {
  factory _$$GameResultImplCopyWith(
          _$GameResultImpl value, $Res Function(_$GameResultImpl) then) =
      __$$GameResultImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int playerScore, int cpuScore, RoundResult roundResult});

  $RoundResultCopyWith<$Res> get roundResult;
}

/// @nodoc
class __$$GameResultImplCopyWithImpl<$Res>
    extends _$GameStateCopyWithImpl<$Res, _$GameResultImpl>
    implements _$$GameResultImplCopyWith<$Res> {
  __$$GameResultImplCopyWithImpl(
      _$GameResultImpl _value, $Res Function(_$GameResultImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? playerScore = null,
    Object? cpuScore = null,
    Object? roundResult = null,
  }) {
    return _then(_$GameResultImpl(
      playerScore: null == playerScore
          ? _value.playerScore
          : playerScore // ignore: cast_nullable_to_non_nullable
              as int,
      cpuScore: null == cpuScore
          ? _value.cpuScore
          : cpuScore // ignore: cast_nullable_to_non_nullable
              as int,
      roundResult: null == roundResult
          ? _value.roundResult
          : roundResult // ignore: cast_nullable_to_non_nullable
              as RoundResult,
    ));
  }

  @override
  @pragma('vm:prefer-inline')
  $RoundResultCopyWith<$Res> get roundResult {
    return $RoundResultCopyWith<$Res>(_value.roundResult, (value) {
      return _then(_value.copyWith(roundResult: value));
    });
  }
}

/// @nodoc

class _$GameResultImpl implements GameResult {
  const _$GameResultImpl(
      {required this.playerScore,
      required this.cpuScore,
      required this.roundResult});

  @override
  final int playerScore;
  @override
  final int cpuScore;
  @override
  final RoundResult roundResult;

  @override
  String toString() {
    return 'GameState.result(playerScore: $playerScore, cpuScore: $cpuScore, roundResult: $roundResult)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GameResultImpl &&
            (identical(other.playerScore, playerScore) ||
                other.playerScore == playerScore) &&
            (identical(other.cpuScore, cpuScore) ||
                other.cpuScore == cpuScore) &&
            (identical(other.roundResult, roundResult) ||
                other.roundResult == roundResult));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, playerScore, cpuScore, roundResult);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$GameResultImplCopyWith<_$GameResultImpl> get copyWith =>
      __$$GameResultImplCopyWithImpl<_$GameResultImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(int playerScore, int cpuScore) initial,
    required TResult Function(int playerScore, int cpuScore, Move playerMove,
            Move currentDisplayMove)
        thinking,
    required TResult Function(
            int playerScore, int cpuScore, RoundResult roundResult)
        result,
    required TResult Function(int playerScore, int cpuScore, Failure failure)
        error,
  }) {
    return result(playerScore, cpuScore, roundResult);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(int playerScore, int cpuScore)? initial,
    TResult? Function(int playerScore, int cpuScore, Move playerMove,
            Move currentDisplayMove)?
        thinking,
    TResult? Function(int playerScore, int cpuScore, RoundResult roundResult)?
        result,
    TResult? Function(int playerScore, int cpuScore, Failure failure)? error,
  }) {
    return result?.call(playerScore, cpuScore, roundResult);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(int playerScore, int cpuScore)? initial,
    TResult Function(int playerScore, int cpuScore, Move playerMove,
            Move currentDisplayMove)?
        thinking,
    TResult Function(int playerScore, int cpuScore, RoundResult roundResult)?
        result,
    TResult Function(int playerScore, int cpuScore, Failure failure)? error,
    required TResult orElse(),
  }) {
    if (result != null) {
      return result(playerScore, cpuScore, roundResult);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(GameInitial value) initial,
    required TResult Function(GameThinking value) thinking,
    required TResult Function(GameResult value) result,
    required TResult Function(GameError value) error,
  }) {
    return result(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(GameInitial value)? initial,
    TResult? Function(GameThinking value)? thinking,
    TResult? Function(GameResult value)? result,
    TResult? Function(GameError value)? error,
  }) {
    return result?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(GameInitial value)? initial,
    TResult Function(GameThinking value)? thinking,
    TResult Function(GameResult value)? result,
    TResult Function(GameError value)? error,
    required TResult orElse(),
  }) {
    if (result != null) {
      return result(this);
    }
    return orElse();
  }
}

abstract class GameResult implements GameState {
  const factory GameResult(
      {required final int playerScore,
      required final int cpuScore,
      required final RoundResult roundResult}) = _$GameResultImpl;

  @override
  int get playerScore;
  @override
  int get cpuScore;
  RoundResult get roundResult;
  @override
  @JsonKey(ignore: true)
  _$$GameResultImplCopyWith<_$GameResultImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$GameErrorImplCopyWith<$Res>
    implements $GameStateCopyWith<$Res> {
  factory _$$GameErrorImplCopyWith(
          _$GameErrorImpl value, $Res Function(_$GameErrorImpl) then) =
      __$$GameErrorImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int playerScore, int cpuScore, Failure failure});
}

/// @nodoc
class __$$GameErrorImplCopyWithImpl<$Res>
    extends _$GameStateCopyWithImpl<$Res, _$GameErrorImpl>
    implements _$$GameErrorImplCopyWith<$Res> {
  __$$GameErrorImplCopyWithImpl(
      _$GameErrorImpl _value, $Res Function(_$GameErrorImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? playerScore = null,
    Object? cpuScore = null,
    Object? failure = null,
  }) {
    return _then(_$GameErrorImpl(
      playerScore: null == playerScore
          ? _value.playerScore
          : playerScore // ignore: cast_nullable_to_non_nullable
              as int,
      cpuScore: null == cpuScore
          ? _value.cpuScore
          : cpuScore // ignore: cast_nullable_to_non_nullable
              as int,
      failure: null == failure
          ? _value.failure
          : failure // ignore: cast_nullable_to_non_nullable
              as Failure,
    ));
  }
}

/// @nodoc

class _$GameErrorImpl implements GameError {
  const _$GameErrorImpl(
      {required this.playerScore,
      required this.cpuScore,
      required this.failure});

  @override
  final int playerScore;
  @override
  final int cpuScore;
  @override
  final Failure failure;

  @override
  String toString() {
    return 'GameState.error(playerScore: $playerScore, cpuScore: $cpuScore, failure: $failure)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GameErrorImpl &&
            (identical(other.playerScore, playerScore) ||
                other.playerScore == playerScore) &&
            (identical(other.cpuScore, cpuScore) ||
                other.cpuScore == cpuScore) &&
            (identical(other.failure, failure) || other.failure == failure));
  }

  @override
  int get hashCode => Object.hash(runtimeType, playerScore, cpuScore, failure);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$GameErrorImplCopyWith<_$GameErrorImpl> get copyWith =>
      __$$GameErrorImplCopyWithImpl<_$GameErrorImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(int playerScore, int cpuScore) initial,
    required TResult Function(int playerScore, int cpuScore, Move playerMove,
            Move currentDisplayMove)
        thinking,
    required TResult Function(
            int playerScore, int cpuScore, RoundResult roundResult)
        result,
    required TResult Function(int playerScore, int cpuScore, Failure failure)
        error,
  }) {
    return error(playerScore, cpuScore, failure);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(int playerScore, int cpuScore)? initial,
    TResult? Function(int playerScore, int cpuScore, Move playerMove,
            Move currentDisplayMove)?
        thinking,
    TResult? Function(int playerScore, int cpuScore, RoundResult roundResult)?
        result,
    TResult? Function(int playerScore, int cpuScore, Failure failure)? error,
  }) {
    return error?.call(playerScore, cpuScore, failure);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(int playerScore, int cpuScore)? initial,
    TResult Function(int playerScore, int cpuScore, Move playerMove,
            Move currentDisplayMove)?
        thinking,
    TResult Function(int playerScore, int cpuScore, RoundResult roundResult)?
        result,
    TResult Function(int playerScore, int cpuScore, Failure failure)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(playerScore, cpuScore, failure);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(GameInitial value) initial,
    required TResult Function(GameThinking value) thinking,
    required TResult Function(GameResult value) result,
    required TResult Function(GameError value) error,
  }) {
    return error(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(GameInitial value)? initial,
    TResult? Function(GameThinking value)? thinking,
    TResult? Function(GameResult value)? result,
    TResult? Function(GameError value)? error,
  }) {
    return error?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(GameInitial value)? initial,
    TResult Function(GameThinking value)? thinking,
    TResult Function(GameResult value)? result,
    TResult Function(GameError value)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(this);
    }
    return orElse();
  }
}

abstract class GameError implements GameState {
  const factory GameError(
      {required final int playerScore,
      required final int cpuScore,
      required final Failure failure}) = _$GameErrorImpl;

  @override
  int get playerScore;
  @override
  int get cpuScore;
  Failure get failure;
  @override
  @JsonKey(ignore: true)
  _$$GameErrorImplCopyWith<_$GameErrorImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
