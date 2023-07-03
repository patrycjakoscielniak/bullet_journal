import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mocktail/mocktail.dart';
import 'package:my_bullet_journal/app/core/enums.dart';
import 'package:my_bullet_journal/app/screens/vision_board/cubit/vision_board_cubit.dart';
import 'package:my_bullet_journal/data/models/vision_board_model.dart';
import 'package:my_bullet_journal/domain/repositories/vision_board_repository.dart';

class MockVisionBoardRepository extends Mock implements VisionBoardRepository {}

class MockXFile extends Mock implements XFile {}

void main() {
  late VisionBoardCubit sut;
  late MockVisionBoardRepository repository;
  late MockXFile xFile;

  setUp(() {
    repository = MockVisionBoardRepository();
    sut = VisionBoardCubit(repository);
    xFile = MockXFile();
  });

  group('addImage', () {
    group('saved', () {
      setUp(() {
        when(() => repository.uploadImage(xFile)).thenAnswer((_) async => [
              const VisionBoardModel(
                image: 'image',
                id: '123',
              )
            ]);
      });
      blocTest(
        'emit Status.saved',
        build: () => sut,
        act: (cubit) => cubit.addImage(xFile),
        expect: () => [VisionBoardState(status: Status.saved)],
      );
    });
    group('error', () {
      setUp(() {
        when(() => repository.uploadImage(xFile))
            .thenThrow(Exception('test-exception-error'));
      });
      blocTest('emit Status.error with errorMessage',
          build: () => sut,
          act: (cubit) => cubit.addImage(xFile),
          expect: () => [
                VisionBoardState(
                    status: Status.error,
                    errorMessage: 'Exception: test-exception-error')
              ]);
    });
  });
  group('deleteImage', () {
    group('deleted', () {
      setUp(() {
        when(() => repository.deleteImage(id: '123', url: 'imageUrl'))
            .thenAnswer((_) async => [
                  const VisionBoardModel(
                    image: 'image',
                    id: '123',
                  )
                ]);
      });
      blocTest(
        'emit Status.deleted',
        build: () => sut,
        act: (cubit) => cubit.deleteImage(docId: '123', url: 'imageUrl'),
        expect: () => [VisionBoardState(status: Status.deleted)],
      );
    });
    group('error', () {});
  });
  group('start', () {
    group('success', () {
      setUp(() {
        when(() => repository.getVisionBoardItemStream())
            .thenAnswer((_) => Stream.fromIterable([
                  [
                    const VisionBoardModel(id: '1', image: 'image'),
                    const VisionBoardModel(id: '2', image: 'image2'),
                  ]
                ]));
      });
      blocTest(
        'emits Status.loading then Status.success with items',
        build: () => sut,
        act: (cubit) => cubit.start(),
        expect: () => [
          VisionBoardState(status: Status.loading),
          VisionBoardState(status: Status.success, items: [
            const VisionBoardModel(id: '1', image: 'image'),
            const VisionBoardModel(id: '2', image: 'image2'),
          ]),
        ],
      );
    });
    group('error', () {
      setUp(() {
        when(() => repository.getVisionBoardItemStream())
            .thenAnswer((_) => Stream.error(Exception('test-exception-error')));
      });
      blocTest(
        'emits Status.error with errorMessage',
        build: () => sut,
        act: (cubit) => cubit.start(),
        expect: () => [
          VisionBoardState(status: Status.loading),
          VisionBoardState(
              status: Status.error,
              errorMessage: 'Exception: test-exception-error'),
        ],
      );
    });
  });
}
