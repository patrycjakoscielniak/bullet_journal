import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:image_picker/image_picker.dart';
import 'package:injectable/injectable.dart';
import '../../../../../../repositories/wishlist_repository.dart';
import '../../../../../core/enums.dart';

part 'add_item_page_state.dart';
part 'add_item_page_cubit.freezed.dart';

@injectable
class AddItemPageCubit extends Cubit<AddItemPageState> {
  AddItemPageCubit(this._wishlistRepository) : super(AddItemPageState());

  final WishlistRepository _wishlistRepository;

  Future<void> addItemwithImageURL(
    String name,
    String imageURL,
    String itemURL,
  ) async {
    try {
      await _wishlistRepository.add(name, imageURL, itemURL);
      emit(AddItemPageState(
        status: Status.saved,
      ));
    } catch (error) {
      emit(AddItemPageState(
        status: Status.error,
        errorMessage: error.toString(),
      ));
    }
  }

  Future<void> addItemWithGalleryImage(
      XFile image, String name, String itemURL) async {
    try {
      await _wishlistRepository.addItem(image, name, itemURL);
      emit(AddItemPageState(status: Status.saved));
    } catch (error) {
      emit(AddItemPageState(
          status: Status.error, errorMessage: error.toString()));
    }
  }
}
