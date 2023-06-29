import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';

import '../../../../../../repositories/wishlist_repository.dart';
import '../../../../../core/enums.dart';

part 'add_page_state.dart';

@injectable
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
        status: Status.saved,
      ));
    } catch (error) {
      emit(AddItemPageState(
        status: Status.error,
        errorMessage: error.toString(),
      ));
    }
  }
}
