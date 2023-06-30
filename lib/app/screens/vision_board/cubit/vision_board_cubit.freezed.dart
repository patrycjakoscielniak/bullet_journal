// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'vision_board_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$VisionBoardState {
  List<VisionBoardModel> get items => throw _privateConstructorUsedError;
  Status get status => throw _privateConstructorUsedError;
  String? get errorMessage => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $VisionBoardStateCopyWith<VisionBoardState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $VisionBoardStateCopyWith<$Res> {
  factory $VisionBoardStateCopyWith(
          VisionBoardState value, $Res Function(VisionBoardState) then) =
      _$VisionBoardStateCopyWithImpl<$Res, VisionBoardState>;
  @useResult
  $Res call(
      {List<VisionBoardModel> items, Status status, String? errorMessage});
}

/// @nodoc
class _$VisionBoardStateCopyWithImpl<$Res, $Val extends VisionBoardState>
    implements $VisionBoardStateCopyWith<$Res> {
  _$VisionBoardStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? items = null,
    Object? status = null,
    Object? errorMessage = freezed,
  }) {
    return _then(_value.copyWith(
      items: null == items
          ? _value.items
          : items // ignore: cast_nullable_to_non_nullable
              as List<VisionBoardModel>,
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
abstract class _$$_VisionBoardStateCopyWith<$Res>
    implements $VisionBoardStateCopyWith<$Res> {
  factory _$$_VisionBoardStateCopyWith(
          _$_VisionBoardState value, $Res Function(_$_VisionBoardState) then) =
      __$$_VisionBoardStateCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {List<VisionBoardModel> items, Status status, String? errorMessage});
}

/// @nodoc
class __$$_VisionBoardStateCopyWithImpl<$Res>
    extends _$VisionBoardStateCopyWithImpl<$Res, _$_VisionBoardState>
    implements _$$_VisionBoardStateCopyWith<$Res> {
  __$$_VisionBoardStateCopyWithImpl(
      _$_VisionBoardState _value, $Res Function(_$_VisionBoardState) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? items = null,
    Object? status = null,
    Object? errorMessage = freezed,
  }) {
    return _then(_$_VisionBoardState(
      items: null == items
          ? _value._items
          : items // ignore: cast_nullable_to_non_nullable
              as List<VisionBoardModel>,
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

class _$_VisionBoardState implements _VisionBoardState {
  _$_VisionBoardState(
      {final List<VisionBoardModel> items = const [],
      this.status = Status.initial,
      this.errorMessage})
      : _items = items;

  final List<VisionBoardModel> _items;
  @override
  @JsonKey()
  List<VisionBoardModel> get items {
    if (_items is EqualUnmodifiableListView) return _items;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_items);
  }

  @override
  @JsonKey()
  final Status status;
  @override
  final String? errorMessage;

  @override
  String toString() {
    return 'VisionBoardState(items: $items, status: $status, errorMessage: $errorMessage)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_VisionBoardState &&
            const DeepCollectionEquality().equals(other._items, _items) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.errorMessage, errorMessage) ||
                other.errorMessage == errorMessage));
  }

  @override
  int get hashCode => Object.hash(runtimeType,
      const DeepCollectionEquality().hash(_items), status, errorMessage);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_VisionBoardStateCopyWith<_$_VisionBoardState> get copyWith =>
      __$$_VisionBoardStateCopyWithImpl<_$_VisionBoardState>(this, _$identity);
}

abstract class _VisionBoardState implements VisionBoardState {
  factory _VisionBoardState(
      {final List<VisionBoardModel> items,
      final Status status,
      final String? errorMessage}) = _$_VisionBoardState;

  @override
  List<VisionBoardModel> get items;
  @override
  Status get status;
  @override
  String? get errorMessage;
  @override
  @JsonKey(ignore: true)
  _$$_VisionBoardStateCopyWith<_$_VisionBoardState> get copyWith =>
      throw _privateConstructorUsedError;
}
