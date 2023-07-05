// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'planner_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$PlannerState {
  List<EventModel> get appointments => throw _privateConstructorUsedError;
  Status get status => throw _privateConstructorUsedError;
  String? get errorMessage => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $PlannerStateCopyWith<PlannerState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PlannerStateCopyWith<$Res> {
  factory $PlannerStateCopyWith(
          PlannerState value, $Res Function(PlannerState) then) =
      _$PlannerStateCopyWithImpl<$Res, PlannerState>;
  @useResult
  $Res call(
      {List<EventModel> appointments, Status status, String? errorMessage});
}

/// @nodoc
class _$PlannerStateCopyWithImpl<$Res, $Val extends PlannerState>
    implements $PlannerStateCopyWith<$Res> {
  _$PlannerStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? appointments = null,
    Object? status = null,
    Object? errorMessage = freezed,
  }) {
    return _then(_value.copyWith(
      appointments: null == appointments
          ? _value.appointments
          : appointments // ignore: cast_nullable_to_non_nullable
              as List<EventModel>,
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
abstract class _$$_PlannerStateCopyWith<$Res>
    implements $PlannerStateCopyWith<$Res> {
  factory _$$_PlannerStateCopyWith(
          _$_PlannerState value, $Res Function(_$_PlannerState) then) =
      __$$_PlannerStateCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {List<EventModel> appointments, Status status, String? errorMessage});
}

/// @nodoc
class __$$_PlannerStateCopyWithImpl<$Res>
    extends _$PlannerStateCopyWithImpl<$Res, _$_PlannerState>
    implements _$$_PlannerStateCopyWith<$Res> {
  __$$_PlannerStateCopyWithImpl(
      _$_PlannerState _value, $Res Function(_$_PlannerState) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? appointments = null,
    Object? status = null,
    Object? errorMessage = freezed,
  }) {
    return _then(_$_PlannerState(
      appointments: null == appointments
          ? _value._appointments
          : appointments // ignore: cast_nullable_to_non_nullable
              as List<EventModel>,
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

class _$_PlannerState implements _PlannerState {
  _$_PlannerState(
      {final List<EventModel> appointments = const [],
      this.status = Status.initial,
      this.errorMessage})
      : _appointments = appointments;

  final List<EventModel> _appointments;
  @override
  @JsonKey()
  List<EventModel> get appointments {
    if (_appointments is EqualUnmodifiableListView) return _appointments;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_appointments);
  }

  @override
  @JsonKey()
  final Status status;
  @override
  final String? errorMessage;

  @override
  String toString() {
    return 'PlannerState(appointments: $appointments, status: $status, errorMessage: $errorMessage)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_PlannerState &&
            const DeepCollectionEquality()
                .equals(other._appointments, _appointments) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.errorMessage, errorMessage) ||
                other.errorMessage == errorMessage));
  }

  @override
  int get hashCode => Object.hash(runtimeType,
      const DeepCollectionEquality().hash(_appointments), status, errorMessage);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_PlannerStateCopyWith<_$_PlannerState> get copyWith =>
      __$$_PlannerStateCopyWithImpl<_$_PlannerState>(this, _$identity);
}

abstract class _PlannerState implements PlannerState {
  factory _PlannerState(
      {final List<EventModel> appointments,
      final Status status,
      final String? errorMessage}) = _$_PlannerState;

  @override
  List<EventModel> get appointments;
  @override
  Status get status;
  @override
  String? get errorMessage;
  @override
  @JsonKey(ignore: true)
  _$$_PlannerStateCopyWith<_$_PlannerState> get copyWith =>
      throw _privateConstructorUsedError;
}
