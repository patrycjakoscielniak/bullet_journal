import 'package:freezed_annotation/freezed_annotation.dart';

part 'wishlist_item_model.freezed.dart';

@freezed
class WishlistItemModel with _$WishlistItemModel {
  const factory WishlistItemModel({
    required String id,
    required String name,
    required String imageURL,
    required String itemURL,
  }) = _WishlistItemModel;
}
