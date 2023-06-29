import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';
import '../../../../../../repositories/wishlist_repository.dart';
import '../../../../../../models/wishlist_item_model.dart';
import '../../../../../core/enums.dart';
part 'wishlist_state.dart';

@injectable
class WishlistCubit extends Cubit<WishlistState> {
  WishlistCubit(this._wishlistRepository) : super(const WishlistState());

  final WishlistRepository _wishlistRepository;

  StreamSubscription? _streamSubscription;

  Future<void> updateItem(
      {required String documentID, required String itemURL}) async {
    try {
      _wishlistRepository.update(id: documentID, itemURL: itemURL);
      emit(const WishlistState(
        status: Status.updated,
      ));
    } catch (error) {
      emit(WishlistState(
        status: Status.error,
        errorMessage: error.toString(),
      ));
    }
  }

  Future<void> deleteItem({required String documentID}) async {
    try {
      _wishlistRepository.delete(id: documentID);
      emit(const WishlistState(
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
    emit(const WishlistState());

    _streamSubscription =
        _wishlistRepository.getWishlistItemStream().listen((wishlist) {
      emit(WishlistState(
        items: wishlist,
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
