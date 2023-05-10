import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

import '../model/wishlist_item_model.dart';
import '../repository/wishlist_repository.dart';

part 'wishlist_state.dart';

class WishlistCubit extends Cubit<WishlistState> {
  WishlistCubit(this._wishlistRepository)
      : super(const WishlistState(
          errorMessage: '',
          items: [],
        ));

  final WishlistRepository _wishlistRepository;

  StreamSubscription? _streamSubscription;

  Future<void> addItem(
    String name,
    String imageURL,
    String itemURL,
  ) async {
    try {
      await _wishlistRepository.add(name, imageURL, itemURL);
      emit(const WishlistState(items: [], errorMessage: '', saved: true));
    } catch (error) {
      emit(WishlistState(
        items: const [],
        errorMessage: error.toString(),
      ));
    }
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
