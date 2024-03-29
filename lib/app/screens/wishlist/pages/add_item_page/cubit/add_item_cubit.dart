import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:image_picker/image_picker.dart';
import 'package:injectable/injectable.dart';
import '../../../../../../domain/repositories/wishlist_repository.dart';
import '../../../../../core/enums.dart';

part 'add_item_state.dart';
part 'add_item_cubit.freezed.dart';

@injectable
class AddItemCubit extends Cubit<AddItemState> {
  AddItemCubit(this._wishlistRepository) : super(AddItemState());

  final WishlistRepository _wishlistRepository;

  Future<void> addItemwithImageURL(
    String name,
    String imageURL,
    String itemURL,
  ) async {
    try {
      await _wishlistRepository.add(name, imageURL, itemURL);
      emit(AddItemState(
        status: Status.saved,
      ));
    } catch (error) {
      emit(AddItemState(
        status: Status.error,
        errorMessage: error.toString(),
      ));
    }
  }

  Future<void> addItemWithGalleryImage(
      XFile image, String name, String itemURL) async {
    try {
      await _wishlistRepository.addItem(image, name, itemURL);
      emit(AddItemState(status: Status.saved));
    } catch (error) {
      emit(AddItemState(status: Status.error, errorMessage: error.toString()));
    }
  }
}
