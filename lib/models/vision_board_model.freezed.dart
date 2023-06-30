// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'vision_board_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$VisionBoardModel {
  String get image => throw _privateConstructorUsedError;
  String get id => throw _privateConstructorUsedError;
  Timestamp? get onCreated => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $VisionBoardModelCopyWith<VisionBoardModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $VisionBoardModelCopyWith<$Res> {
  factory $VisionBoardModelCopyWith(
          VisionBoardModel value, $Res Function(VisionBoardModel) then) =
      _$VisionBoardModelCopyWithImpl<$Res, VisionBoardModel>;
  @useResult
  $Res call({String image, String id, Timestamp? onCreated});
}

/// @nodoc
class _$VisionBoardModelCopyWithImpl<$Res, $Val extends VisionBoardModel>
    implements $VisionBoardModelCopyWith<$Res> {
  _$VisionBoardModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? image = null,
    Object? id = null,
    Object? onCreated = freezed,
  }) {
    return _then(_value.copyWith(
      image: null == image
          ? _value.image
          : image // ignore: cast_nullable_to_non_nullable
              as String,
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      onCreated: freezed == onCreated
          ? _value.onCreated
          : onCreated // ignore: cast_nullable_to_non_nullable
              as Timestamp?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_VisionBoardModelCopyWith<$Res>
    implements $VisionBoardModelCopyWith<$Res> {
  factory _$$_VisionBoardModelCopyWith(
          _$_VisionBoardModel value, $Res Function(_$_VisionBoardModel) then) =
      __$$_VisionBoardModelCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String image, String id, Timestamp? onCreated});
}

/// @nodoc
class __$$_VisionBoardModelCopyWithImpl<$Res>
    extends _$VisionBoardModelCopyWithImpl<$Res, _$_VisionBoardModel>
    implements _$$_VisionBoardModelCopyWith<$Res> {
  __$$_VisionBoardModelCopyWithImpl(
      _$_VisionBoardModel _value, $Res Function(_$_VisionBoardModel) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? image = null,
    Object? id = null,
    Object? onCreated = freezed,
  }) {
    return _then(_$_VisionBoardModel(
      image: null == image
          ? _value.image
          : image // ignore: cast_nullable_to_non_nullable
              as String,
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      onCreated: freezed == onCreated
          ? _value.onCreated
          : onCreated // ignore: cast_nullable_to_non_nullable
              as Timestamp?,
    ));
  }
}

/// @nodoc

class _$_VisionBoardModel implements _VisionBoardModel {
  const _$_VisionBoardModel(
      {required this.image, required this.id, this.onCreated});

  @override
  final String image;
  @override
  final String id;
  @override
  final Timestamp? onCreated;

  @override
  String toString() {
    return 'VisionBoardModel(image: $image, id: $id, onCreated: $onCreated)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_VisionBoardModel &&
            (identical(other.image, image) || other.image == image) &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.onCreated, onCreated) ||
                other.onCreated == onCreated));
  }

  @override
  int get hashCode => Object.hash(runtimeType, image, id, onCreated);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_VisionBoardModelCopyWith<_$_VisionBoardModel> get copyWith =>
      __$$_VisionBoardModelCopyWithImpl<_$_VisionBoardModel>(this, _$identity);
}

abstract class _VisionBoardModel implements VisionBoardModel {
  const factory _VisionBoardModel(
      {required final String image,
      required final String id,
      final Timestamp? onCreated}) = _$_VisionBoardModel;

  @override
  String get image;
  @override
  String get id;
  @override
  Timestamp? get onCreated;
  @override
  @JsonKey(ignore: true)
  _$$_VisionBoardModelCopyWith<_$_VisionBoardModel> get copyWith =>
      throw _privateConstructorUsedError;
}
