part of 'wishlist_cubit.dart';

@immutable
class WishlistState {
  const WishlistState({
    required this.items,
    required this.errorMessage,
    this.saved = false,
  });

  final List<WishlistItemModel> items;
  final String errorMessage;
  final bool saved;
}
