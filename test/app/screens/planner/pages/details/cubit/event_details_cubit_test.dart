import 'package:bloc_test/bloc_test.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:my_bullet_journal/app/core/enums.dart';
import 'package:my_bullet_journal/app/core/global_variables.dart';
import 'package:my_bullet_journal/app/screens/planner/pages/details/cubit/event_details_cubit.dart';
import 'package:my_bullet_journal/data/models/event_model.dart';
import 'package:my_bullet_journal/domain/repositories/planner_repository.dart';

class MockPlannerRepository extends Mock implements PlannerRepository {}

void main() {
  late MockPlannerRepository repository;
  late EventDetailsCubit sut;

  setUp(() {
    repository = MockPlannerRepository();
    sut = EventDetailsCubit(repository);
  });
  group('deleteEvent', () {
    group('deleted', () {
      setUp(() {
        when(() => repository.delete(id: '123')).thenAnswer((_) async =>
            EventModel(
                eventName: 'eventName',
                id: '123',
                startTime: Timestamp.fromDate(DateTime(2022, 1, 1)),
                endTime: Timestamp.fromDate(DateTime(2022, 1, 1)),
                isAllDay: true,
                colorValue: appGrey.value));
      });
      blocTest(
        'emit Status.deleted',
        build: () => sut,
        act: (cubit) => cubit.deleteEvent(documentID: '123'),
        expect: () => [EventDetailsState(status: Status.deleted)],
      );
    });
    group('error', () {
      setUp(() {
        when(() => repository.delete(id: '123'))
            .thenThrow(Exception('error-exception-test'));
      });
      blocTest(
        'emit Status.error with errorMessage',
        build: () => sut,
        act: (cubit) => cubit.deleteEvent(documentID: '123'),
        expect: () => [
          EventDetailsState(
              status: Status.error,
              errorMessage: 'Exception: error-exception-test')
        ],
      );
    });
  });
}
