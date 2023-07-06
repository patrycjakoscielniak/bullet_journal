// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'holidays_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$HolidayModel {
  String get name => throw _privateConstructorUsedError;
  DateTime get date => throw _privateConstructorUsedError;
  String get type => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $HolidayModelCopyWith<HolidayModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $HolidayModelCopyWith<$Res> {
  factory $HolidayModelCopyWith(
          HolidayModel value, $Res Function(HolidayModel) then) =
      _$HolidayModelCopyWithImpl<$Res, HolidayModel>;
  @useResult
  $Res call({String name, DateTime date, String type});
}

/// @nodoc
class _$HolidayModelCopyWithImpl<$Res, $Val extends HolidayModel>
    implements $HolidayModelCopyWith<$Res> {
  _$HolidayModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? date = null,
    Object? type = null,
  }) {
    return _then(_value.copyWith(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      date: null == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as DateTime,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_HolidayModelCopyWith<$Res>
    implements $HolidayModelCopyWith<$Res> {
  factory _$$_HolidayModelCopyWith(
          _$_HolidayModel value, $Res Function(_$_HolidayModel) then) =
      __$$_HolidayModelCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String name, DateTime date, String type});
}

/// @nodoc
class __$$_HolidayModelCopyWithImpl<$Res>
    extends _$HolidayModelCopyWithImpl<$Res, _$_HolidayModel>
    implements _$$_HolidayModelCopyWith<$Res> {
  __$$_HolidayModelCopyWithImpl(
      _$_HolidayModel _value, $Res Function(_$_HolidayModel) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? date = null,
    Object? type = null,
  }) {
    return _then(_$_HolidayModel(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      date: null == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as DateTime,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$_HolidayModel extends _HolidayModel {
  _$_HolidayModel({required this.name, required this.date, required this.type})
      : super._();

  @override
  final String name;
  @override
  final DateTime date;
  @override
  final String type;

  @override
  String toString() {
    return 'HolidayModel(name: $name, date: $date, type: $type)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_HolidayModel &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.date, date) || other.date == date) &&
            (identical(other.type, type) || other.type == type));
  }

  @override
  int get hashCode => Object.hash(runtimeType, name, date, type);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_HolidayModelCopyWith<_$_HolidayModel> get copyWith =>
      __$$_HolidayModelCopyWithImpl<_$_HolidayModel>(this, _$identity);
}

abstract class _HolidayModel extends HolidayModel {
  factory _HolidayModel(
      {required final String name,
      required final DateTime date,
      required final String type}) = _$_HolidayModel;
  _HolidayModel._() : super._();

  @override
  String get name;
  @override
  DateTime get date;
  @override
  String get type;
  @override
  @JsonKey(ignore: true)
  _$$_HolidayModelCopyWith<_$_HolidayModel> get copyWith =>
      throw _privateConstructorUsedError;
}
