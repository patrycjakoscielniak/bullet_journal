import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import '../../../../../../data/models/wishlist_item_model.dart';
import '../../../../../../domain/repositories/wishlist_repository.dart';
import '../../../../../core/enums.dart';
part 'wishlist_state.dart';
part 'wishlist_cubit.freezed.dart';

@injectable
class WishlistCubit extends Cubit<WishlistState> {
  WishlistCubit(this._wishlistRepository) : super(WishlistState());

  final WishlistRepository _wishlistRepository;

  StreamSubscription? _streamSubscription;

  Future<void> updateItem(
      {required String documentID, required String itemURL}) async {
    try {
      _wishlistRepository.update(id: documentID, itemURL: itemURL);
      emit(WishlistState(
        status: Status.updated,
      ));
    } catch (error) {
      emit(WishlistState(
        status: Status.error,
        errorMessage: error.toString(),
      ));
    }
  }

  Future<void> deleteItemFromFirebase({
    required String documentID,
  }) async {
    try {
      _wishlistRepository.deleteFromFirebase(id: documentID);
      emit(WishlistState(
        status: Status.deleted,
      ));
    } catch (error) {
      emit(WishlistState(
        status: Status.error,
        errorMessage: error.toString(),
      ));
    }
  }

  Future<void> deleteItemFromStorage({
    required String url,
  }) async {
    try {
      _wishlistRepository.deleteFromStorage(url: url);
      emit(WishlistState(
        status: Status.deleted,
      ));
    } catch (error) {
      emit(WishlistState(
        status: Status.error,
        errorMessage: error.toString(),
      ));
    }
  }

  Future<void> start() async {
    emit(WishlistState(status: Status.loading));

    _streamSubscription =
        _wishlistRepository.getWishlistItemStream().listen((wishlist) {
      emit(WishlistState(
        items: wishlist,
        status: Status.success,
      ));
    })
          ..onError((error) {
            emit(WishlistState(
              status: Status.error,
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
