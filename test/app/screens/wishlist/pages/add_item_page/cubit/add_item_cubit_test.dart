import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mocktail/mocktail.dart';
import 'package:my_bullet_journal/app/core/enums.dart';
import 'package:my_bullet_journal/app/screens/wishlist/pages/add_item_page/cubit/add_item_cubit.dart';
import 'package:my_bullet_journal/data/models/wishlist_item_model.dart';
import 'package:my_bullet_journal/domain/repositories/wishlist_repository.dart';

class MockWishlistRepository extends Mock implements WishlistRepository {}

class MockXFile extends Mock implements XFile {}

void main() {
  late AddItemCubit sut;
  late MockWishlistRepository repository;
  late MockXFile xFile;

  setUp(() {
    repository = MockWishlistRepository();
    sut = AddItemCubit(repository);
    xFile = MockXFile();
  });
  group('addItemWithImageUrl', () {
    group('saved', () {
      setUp(() {
        when(() => repository.add('name', 'imageUrl', ''))
            .thenAnswer((_) async => [
                  const WishlistItemModel(
                      id: '123',
                      name: 'name',
                      imageURL: 'imageUrl',
                      itemURL: 'itemUrl'),
                ]);
      });
      blocTest(
        'emits Status.saved',
        build: () => sut,
        act: (cubit) => cubit.addItemwithImageURL('name', 'imageUrl', ''),
        expect: () => [
          AddItemState(status: Status.saved),
        ],
      );
    });
    group('error', () {
      setUp(() {
        when(() => repository.add('name', 'imageUrl', ''))
            .thenThrow(Exception('test-exception-error'));
      });
      blocTest(
        'emits Status.error with errorMessage',
        build: () => sut,
        act: (cubit) => cubit.addItemwithImageURL('name', 'imageUrl', ''),
        expect: () => [
          AddItemState(
              status: Status.error,
              errorMessage: 'Exception: test-exception-error'),
        ],
      );
    });
  });
  group('addItemWithGalleryImage', () {
    group('saved', () {
      setUp(() {
        when(() => repository.addItem(xFile, 'name', ''))
            .thenAnswer((_) async => [
                  const WishlistItemModel(
                      id: '123',
                      name: 'name',
                      imageURL: 'imageUrl',
                      itemURL: ''),
                ]);
      });
      blocTest(
        'emits Status.saved',
        build: () => sut,
        act: (cubit) => cubit.addItemWithGalleryImage(xFile, 'name', ''),
        expect: () => [
          AddItemState(status: Status.saved),
        ],
      );
    });
    group('error', () {
      setUp(() {
        when(() => repository.addItem(xFile, 'name', ''))
            .thenThrow(Exception('test-exception-error'));
      });
      blocTest(
        'emits Status.error with errorMessage',
        build: () => sut,
        act: (cubit) => cubit.addItemWithGalleryImage(xFile, 'name', ''),
        expect: () => [
          AddItemState(
              status: Status.error,
              errorMessage: 'Exception: test-exception-error'),
        ],
      );
    });
  });
}
