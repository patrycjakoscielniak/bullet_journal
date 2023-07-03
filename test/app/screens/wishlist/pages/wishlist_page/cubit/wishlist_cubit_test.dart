import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:my_bullet_journal/app/core/enums.dart';
import 'package:my_bullet_journal/app/screens/wishlist/pages/wishlist_page/cubit/wishlist_cubit.dart';
import 'package:my_bullet_journal/data/models/wishlist_item_model.dart';
import 'package:my_bullet_journal/domain/repositories/wishlist_repository.dart';

class MockWishlistRepository extends Mock implements WishlistRepository {}

void main() {
  late WishlistCubit sut;
  late MockWishlistRepository repository;

  setUp(() {
    repository = MockWishlistRepository();
    sut = WishlistCubit(repository);
  });
  group('updateItem', () {
    group('updated', () {
      setUp(() {
        when(() => repository.update(id: '456', itemURL: 'newItemUrl'))
            .thenAnswer((_) async => [
                  const WishlistItemModel(
                      id: '123',
                      name: 'name',
                      imageURL: 'imageUrl',
                      itemURL: 'itemUrl'),
                  const WishlistItemModel(
                      id: '456',
                      name: 'name',
                      imageURL: 'imageUrl',
                      itemURL: 'itemUrl'),
                ]);
      });
      blocTest(
        'emits Status.updated',
        build: () => sut,
        act: (cubit) =>
            cubit.updateItem(documentID: '456', itemURL: 'newItemUrl'),
        expect: () => [
          WishlistState(status: Status.updated),
        ],
      );
    });
    group('error', () {
      setUp(() {
        when(() => repository.update(id: '456', itemURL: 'newItemUrl'))
            .thenThrow(Exception('test-exception-error'));
      });
      blocTest(
        'emits Status.error with errorMessage',
        build: () => sut,
        act: (cubit) =>
            cubit.updateItem(documentID: '456', itemURL: 'newItemUrl'),
        expect: () => [
          WishlistState(
              status: Status.error,
              errorMessage: 'Exception: test-exception-error'),
        ],
      );
    });
  });
  group('deleteItemFromFirebase', () {
    group('deleted', () {
      setUp(() {
        when(() => repository.deleteFromFirebase(
              id: '456',
            )).thenAnswer((_) async => [
              const WishlistItemModel(
                  id: '123',
                  name: 'name',
                  imageURL: 'imageUrl',
                  itemURL: 'itemUrl'),
              const WishlistItemModel(
                  id: '456',
                  name: 'name',
                  imageURL: 'imageUrl',
                  itemURL: 'itemUrl'),
            ]);
      });
      blocTest(
        'emits Status.deleted',
        build: () => sut,
        act: (cubit) => cubit.deleteItemFromFirebase(
          documentID: '456',
        ),
        expect: () => [
          WishlistState(status: Status.deleted),
        ],
      );
    });
    group('error', () {
      setUp(() {
        when(() => repository.deleteFromFirebase(
              id: '456',
            )).thenThrow(Exception('test-exception-error'));
      });
      blocTest(
        'emits Status.error with errorMessage',
        build: () => sut,
        act: (cubit) => cubit.deleteItemFromFirebase(
          documentID: '456',
        ),
        expect: () => [
          WishlistState(
              status: Status.error,
              errorMessage: 'Exception: test-exception-error'),
        ],
      );
    });
  });
  group('deleteItemFromStorage', () {
    group('deleted', () {
      setUp(() {
        when(() => repository.deleteFromStorage(
              url: 'imageUrl1',
            )).thenAnswer((_) async => [
              const WishlistItemModel(
                  id: '123', name: 'name', imageURL: 'imageUrl1', itemURL: ''),
              const WishlistItemModel(
                  id: '456', name: 'name', imageURL: 'imageUrl', itemURL: ''),
            ]);
      });
      blocTest(
        'emits Status.deleted',
        build: () => sut,
        act: (cubit) => cubit.deleteItemFromStorage(
          url: 'imageUrl1',
        ),
        expect: () => [
          WishlistState(status: Status.deleted),
        ],
      );
    });
    group('error', () {
      setUp(() {
        when(() => repository.deleteFromStorage(
              url: 'imageUrl1',
            )).thenThrow(Exception('test-exception-error'));
      });
      blocTest(
        'emits Status.error with errorMessage',
        build: () => sut,
        act: (cubit) => cubit.deleteItemFromStorage(
          url: 'imageUrl1',
        ),
        expect: () => [
          WishlistState(
              status: Status.error,
              errorMessage: 'Exception: test-exception-error'),
        ],
      );
    });
  });
  group('start', () {
    group('success', () {
      setUp(() {
        when(() => repository.getWishlistItemStream())
            .thenAnswer((_) => Stream.fromIterable([
                  [
                    const WishlistItemModel(
                        id: '1',
                        name: 'name',
                        imageURL: 'imageURL',
                        itemURL: 'itemURL'),
                    const WishlistItemModel(
                        id: '2',
                        name: 'name2',
                        imageURL: 'imageURL2',
                        itemURL: 'itemURL2')
                  ]
                ]));
      });
      blocTest(
        'emits Status.loading then Status.success with items',
        build: () => sut,
        act: (cubit) => cubit.start(),
        expect: () => [
          WishlistState(status: Status.loading),
          WishlistState(status: Status.success, items: [
            const WishlistItemModel(
                id: '1',
                name: 'name',
                imageURL: 'imageURL',
                itemURL: 'itemURL'),
            const WishlistItemModel(
                id: '2',
                name: 'name2',
                imageURL: 'imageURL2',
                itemURL: 'itemURL2')
          ]),
        ],
      );
    });
    group('error', () {
      setUp(() {
        when(() => repository.getWishlistItemStream())
            .thenAnswer((_) => Stream.error(Exception('error-exception-test')));
      });
      blocTest(
        'emits Status.error with errorMessage',
        build: () => sut,
        act: (cubit) => cubit.start(),
        expect: () => [
          WishlistState(status: Status.loading),
          WishlistState(
              status: Status.error,
              errorMessage: 'Exception: error-exception-test'),
        ],
      );
    });
  });
}
