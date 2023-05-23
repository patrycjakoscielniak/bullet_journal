import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

import '../../../../../../repositories/wishlist_repository.dart';
import '../../../../../../models/wishlist_item_model.dart';

part 'wishlist_state.dart';

class WishlistCubit extends Cubit<WishlistState> {
  WishlistCubit(this._wishlistRepository)
      : super(const WishlistState(
          errorMessage: '',
          items: [],
        ));

  final WishlistRepository _wishlistRepository;

  StreamSubscription? _streamSubscription;

  Future<void> updateItem(
      {required String documentID, required String itemURL}) async {
    await _wishlistRepository.update(id: documentID, itemURL: itemURL);
  }

  Future<void> deleteItem({required String documentID}) async {
    await _wishlistRepository.delete(id: documentID);
  }

  Future<void> start() async {
    emit(const WishlistState(
      items: [],
      errorMessage: '',
    ));

    _streamSubscription =
        _wishlistRepository.getWishlistItemStream().listen((wishlist) {
      emit(WishlistState(
        items: wishlist,
        errorMessage: '',
      ));
    })
          ..onError((error) {
            emit(WishlistState(
              items: const [],
              errorMessage: error.toString(),
            ));
          });
  }

  @override
  Future<void> close() {
    _streamSubscription?.cancel();
    return super.close();
  }
}
