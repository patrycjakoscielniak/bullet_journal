// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'edit_event_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$EditEventState {
  Status get status => throw _privateConstructorUsedError;
  String? get errorMessage => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $EditEventStateCopyWith<EditEventState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $EditEventStateCopyWith<$Res> {
  factory $EditEventStateCopyWith(
          EditEventState value, $Res Function(EditEventState) then) =
      _$EditEventStateCopyWithImpl<$Res, EditEventState>;
  @useResult
  $Res call({Status status, String? errorMessage});
}

/// @nodoc
class _$EditEventStateCopyWithImpl<$Res, $Val extends EditEventState>
    implements $EditEventStateCopyWith<$Res> {
  _$EditEventStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? errorMessage = freezed,
  }) {
    return _then(_value.copyWith(
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as Status,
      errorMessage: freezed == errorMessage
          ? _value.errorMessage
          : errorMessage // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_EditEventStateCopyWith<$Res>
    implements $EditEventStateCopyWith<$Res> {
  factory _$$_EditEventStateCopyWith(
          _$_EditEventState value, $Res Function(_$_EditEventState) then) =
      __$$_EditEventStateCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({Status status, String? errorMessage});
}

/// @nodoc
class __$$_EditEventStateCopyWithImpl<$Res>
    extends _$EditEventStateCopyWithImpl<$Res, _$_EditEventState>
    implements _$$_EditEventStateCopyWith<$Res> {
  __$$_EditEventStateCopyWithImpl(
      _$_EditEventState _value, $Res Function(_$_EditEventState) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? errorMessage = freezed,
  }) {
    return _then(_$_EditEventState(
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as Status,
      errorMessage: freezed == errorMessage
          ? _value.errorMessage
          : errorMessage // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$_EditEventState implements _EditEventState {
  _$_EditEventState({this.status = Status.initial, this.errorMessage});

  @override
  @JsonKey()
  final Status status;
  @override
  final String? errorMessage;

  @override
  String toString() {
    return 'EditEventState(status: $status, errorMessage: $errorMessage)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_EditEventState &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.errorMessage, errorMessage) ||
                other.errorMessage == errorMessage));
  }

  @override
  int get hashCode => Object.hash(runtimeType, status, errorMessage);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_EditEventStateCopyWith<_$_EditEventState> get copyWith =>
      __$$_EditEventStateCopyWithImpl<_$_EditEventState>(this, _$identity);
}

abstract class _EditEventState implements EditEventState {
  factory _EditEventState({final Status status, final String? errorMessage}) =
      _$_EditEventState;

  @override
  Status get status;
  @override
  String? get errorMessage;
  @override
  @JsonKey(ignore: true)
  _$$_EditEventStateCopyWith<_$_EditEventState> get copyWith =>
      throw _privateConstructorUsedError;
}
