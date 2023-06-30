// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'wishlist_item_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$WishlistItemModel {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get imageURL => throw _privateConstructorUsedError;
  String get itemURL => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $WishlistItemModelCopyWith<WishlistItemModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $WishlistItemModelCopyWith<$Res> {
  factory $WishlistItemModelCopyWith(
          WishlistItemModel value, $Res Function(WishlistItemModel) then) =
      _$WishlistItemModelCopyWithImpl<$Res, WishlistItemModel>;
  @useResult
  $Res call({String id, String name, String imageURL, String itemURL});
}

/// @nodoc
class _$WishlistItemModelCopyWithImpl<$Res, $Val extends WishlistItemModel>
    implements $WishlistItemModelCopyWith<$Res> {
  _$WishlistItemModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? imageURL = null,
    Object? itemURL = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      imageURL: null == imageURL
          ? _value.imageURL
          : imageURL // ignore: cast_nullable_to_non_nullable
              as String,
      itemURL: null == itemURL
          ? _value.itemURL
          : itemURL // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_WishlistItemModelCopyWith<$Res>
    implements $WishlistItemModelCopyWith<$Res> {
  factory _$$_WishlistItemModelCopyWith(_$_WishlistItemModel value,
          $Res Function(_$_WishlistItemModel) then) =
      __$$_WishlistItemModelCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String id, String name, String imageURL, String itemURL});
}

/// @nodoc
class __$$_WishlistItemModelCopyWithImpl<$Res>
    extends _$WishlistItemModelCopyWithImpl<$Res, _$_WishlistItemModel>
    implements _$$_WishlistItemModelCopyWith<$Res> {
  __$$_WishlistItemModelCopyWithImpl(
      _$_WishlistItemModel _value, $Res Function(_$_WishlistItemModel) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? imageURL = null,
    Object? itemURL = null,
  }) {
    return _then(_$_WishlistItemModel(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      imageURL: null == imageURL
          ? _value.imageURL
          : imageURL // ignore: cast_nullable_to_non_nullable
              as String,
      itemURL: null == itemURL
          ? _value.itemURL
          : itemURL // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$_WishlistItemModel implements _WishlistItemModel {
  const _$_WishlistItemModel(
      {required this.id,
      required this.name,
      required this.imageURL,
      required this.itemURL});

  @override
  final String id;
  @override
  final String name;
  @override
  final String imageURL;
  @override
  final String itemURL;

  @override
  String toString() {
    return 'WishlistItemModel(id: $id, name: $name, imageURL: $imageURL, itemURL: $itemURL)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_WishlistItemModel &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.imageURL, imageURL) ||
                other.imageURL == imageURL) &&
            (identical(other.itemURL, itemURL) || other.itemURL == itemURL));
  }

  @override
  int get hashCode => Object.hash(runtimeType, id, name, imageURL, itemURL);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_WishlistItemModelCopyWith<_$_WishlistItemModel> get copyWith =>
      __$$_WishlistItemModelCopyWithImpl<_$_WishlistItemModel>(
          this, _$identity);
}

abstract class _WishlistItemModel implements WishlistItemModel {
  const factory _WishlistItemModel(
      {required final String id,
      required final String name,
      required final String imageURL,
      required final String itemURL}) = _$_WishlistItemModel;

  @override
  String get id;
  @override
  String get name;
  @override
  String get imageURL;
  @override
  String get itemURL;
  @override
  @JsonKey(ignore: true)
  _$$_WishlistItemModelCopyWith<_$_WishlistItemModel> get copyWith =>
      throw _privateConstructorUsedError;
}
