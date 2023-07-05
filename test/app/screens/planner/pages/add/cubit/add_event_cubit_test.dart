import 'package:bloc_test/bloc_test.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:my_bullet_journal/app/core/enums.dart';
import 'package:my_bullet_journal/app/core/global_variables.dart';
import 'package:my_bullet_journal/app/screens/planner/pages/add/cubit/add_event_cubit.dart';
import 'package:my_bullet_journal/data/models/event_model.dart';
import 'package:my_bullet_journal/domain/repositories/planner_repository.dart';

class MockPlannerRepository extends Mock implements PlannerRepository {}

void main() {
  late MockPlannerRepository repository;
  late AddEventCubit sut;

  setUp(() {
    repository = MockPlannerRepository();
    sut = AddEventCubit(repository);
  });
  group('addEvent', () {
    group('saved', () {
      setUp(() {
        when(() =>
            repository.add(
                'name',
                'notes',
                DateTime(2022, 1, 1),
                DateTime(2022, 1, 1),
                true,
                appGrey.value,
                'recurrenceRule',
                'frequency',
                'recurrenceRuleEnding')).thenAnswer((_) async => [
              EventModel(
                  eventName: 'eventName',
                  id: '123',
                  startTime: Timestamp.fromDate(DateTime(2022, 1, 1)),
                  endTime: Timestamp.fromDate(DateTime(2022, 1, 1)),
                  isAllDay: true,
                  colorValue: appGrey.value)
            ]);
      });
      blocTest(
        'emit Status.saved',
        build: () => sut,
        act: (cubit) => cubit.addEvent(
            'name',
            'notes',
            DateTime(2022, 1, 1),
            DateTime(2022, 1, 1),
            true,
            appGrey.value,
            'recurrenceRule',
            'frequency',
            'recurrenceRuleEnding'),
        expect: () => [AddEventState(status: Status.saved)],
      );
    });
    group('error', () {
      setUp(() {
        when(() => repository.add(
                'name',
                'notes',
                DateTime(2022, 1, 1),
                DateTime(2022, 1, 1),
                true,
                appGrey.value,
                'recurrenceRule',
                'frequency',
                'recurrenceRuleEnding'))
            .thenThrow(Exception('error-exception-test'));
      });
      blocTest(
        'emit Status.error',
        build: () => sut,
        act: (cubit) => cubit.addEvent(
            'name',
            'notes',
            DateTime(2022, 1, 1),
            DateTime(2022, 1, 1),
            true,
            appGrey.value,
            'recurrenceRule',
            'frequency',
            'recurrenceRuleEnding'),
        expect: () => [
          AddEventState(
              status: Status.error,
              errorMessage: 'Exception: error-exception-test')
        ],
      );
    });
  });
}
