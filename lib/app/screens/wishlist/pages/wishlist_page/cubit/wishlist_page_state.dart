part of 'wishlist_page_cubit.dart';

@freezed
class WishlistPageState with _$WishlistPageState {
  factory WishlistPageState({
    @Default([]) List<WishlistItemModel> items,
    @Default(Status.initial) Status status,
    String? errorMessage,
  }) = _WishlistPageState;
}
