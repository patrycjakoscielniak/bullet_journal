import 'package:bloc_test/bloc_test.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:my_bullet_journal/app/core/enums.dart';
import 'package:my_bullet_journal/app/core/global_variables.dart';
import 'package:my_bullet_journal/app/screens/planner/pages/edit/cubit/edit_event_cubit.dart';
import 'package:my_bullet_journal/data/models/event_model.dart';
import 'package:my_bullet_journal/domain/repositories/planner_repository.dart';

class MockPlannerRepository extends Mock implements PlannerRepository {}

void main() {
  late MockPlannerRepository repository;
  late EditEventCubit sut;

  setUp(() {
    repository = MockPlannerRepository();
    sut = EditEventCubit(repository);
  });
  group('updateEvent', () {
    group('updated', () {
      setUp(() {
        when(() =>
            repository.update(
                id: '123',
                notes: 'notes',
                startTime: DateTime(2022, 1, 1),
                endTime: DateTime(2022, 1, 1),
                isAllDay: true,
                colorValue: appGrey.value,
                recurrenceRule: 'recurrenceRule',
                frequency: 'frequency',
                recurrenceRuleEnding: 'recurrenceRuleEnding',
                eventName: 'name')).thenAnswer((_) async => [
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
        'emit Status.updated',
        build: () => sut,
        act: (cubit) => cubit.updateEvent(
            id: '123',
            eventName: 'name',
            notes: 'notes',
            startTime: DateTime(2022, 1, 1),
            endTime: DateTime(2022, 1, 1),
            isAllDay: true,
            colorValue: appGrey.value,
            recurrenceRule: 'recurrenceRule',
            frequency: 'frequency',
            recurrenceRuleEnding: 'recurrenceRuleEnding'),
        expect: () => [EditEventState(status: Status.updated)],
      );
    });
    group('error', () {
      setUp(() {
        when(() => repository.update(
            id: '123',
            notes: 'notes',
            startTime: DateTime(2022, 1, 1),
            endTime: DateTime(2022, 1, 1),
            isAllDay: true,
            colorValue: appGrey.value,
            recurrenceRule: 'recurrenceRule',
            frequency: 'frequency',
            recurrenceRuleEnding: 'recurrenceRuleEnding',
            eventName: 'name')).thenThrow(Exception('error-exception-test'));
      });
      blocTest(
        'emit Status.error',
        build: () => sut,
        act: (cubit) => cubit.updateEvent(
            id: '123',
            eventName: 'name',
            notes: 'notes',
            startTime: DateTime(2022, 1, 1),
            endTime: DateTime(2022, 1, 1),
            isAllDay: true,
            colorValue: appGrey.value,
            recurrenceRule: 'recurrenceRule',
            frequency: 'frequency',
            recurrenceRuleEnding: 'recurrenceRuleEnding'),
        expect: () => [
          EditEventState(
              status: Status.error,
              errorMessage: 'Exception: error-exception-test')
        ],
      );
    });
  });
}
