import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import '../../../../../../repositories/wishlist_repository.dart';
import '../../../../../../models/wishlist_item_model.dart';
import '../../../../../core/enums.dart';
part 'wishlist_page_state.dart';
part 'wishlist_page_cubit.freezed.dart';

@injectable
class WishlistPageCubit extends Cubit<WishlistPageState> {
  WishlistPageCubit(this._wishlistRepository) : super(WishlistPageState());

  final WishlistRepository _wishlistRepository;

  StreamSubscription? _streamSubscription;

  Future<void> updateItem(
      {required String documentID, required String itemURL}) async {
    try {
      _wishlistRepository.update(id: documentID, itemURL: itemURL);
      emit(WishlistPageState(
        status: Status.updated,
      ));
    } catch (error) {
      emit(WishlistPageState(
        status: Status.error,
        errorMessage: error.toString(),
      ));
    }
  }

  Future<void> deleteItem({required String documentID}) async {
    try {
      _wishlistRepository.delete(id: documentID);
      emit(WishlistPageState(
        status: Status.deleted,
      ));
    } catch (error) {
      emit(WishlistPageState(
        status: Status.error,
        errorMessage: error.toString(),
      ));
    }
  }

  Future<void> start() async {
    emit(WishlistPageState());

    _streamSubscription =
        _wishlistRepository.getWishlistItemStream().listen((wishlist) {
      emit(WishlistPageState(
        items: wishlist,
      ));
    })
          ..onError((error) {
            emit(WishlistPageState(
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
