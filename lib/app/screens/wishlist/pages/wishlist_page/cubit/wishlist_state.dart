part of 'wishlist_cubit.dart';

@immutable
class WishlistState {
  const WishlistState({
    this.items = const [],
    this.errorMessage,
    this.status = Status.initial,
  });

  final List<WishlistItemModel> items;
  final String? errorMessage;
  final Status status;
}
