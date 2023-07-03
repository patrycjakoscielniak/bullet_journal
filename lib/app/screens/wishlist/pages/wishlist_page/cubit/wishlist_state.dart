part of 'wishlist_cubit.dart';

@freezed
class WishlistState with _$WishlistState {
  factory WishlistState({
    @Default([]) List<WishlistItemModel> items,
    @Default(Status.initial) Status status,
    String? errorMessage,
  }) = _WishlistState;
}
