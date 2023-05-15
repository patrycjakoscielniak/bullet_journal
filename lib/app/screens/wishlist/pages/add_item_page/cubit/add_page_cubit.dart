import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

import '../../../../../../repositories/wishlist_repository.dart';

part 'add_page_state.dart';

class AddItemPageCubit extends Cubit<AddItemPageState> {
  AddItemPageCubit(this._wishlistRepository) : super(const AddItemPageState());

  final WishlistRepository _wishlistRepository;

  Future<void> addItem(
    String name,
    String imageURL,
    String itemURL,
  ) async {
    try {
      await _wishlistRepository.add(name, imageURL, itemURL);
      emit(const AddItemPageState(
        saved: true,
      ));
    } catch (error) {
      emit(AddItemPageState(
        errorMessage: error.toString(),
      ));
    }
  }
}
