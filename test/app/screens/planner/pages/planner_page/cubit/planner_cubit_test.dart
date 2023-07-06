import 'package:bloc_test/bloc_test.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:my_bullet_journal/app/core/enums.dart';
import 'package:my_bullet_journal/app/core/global_variables.dart';
import 'package:my_bullet_journal/app/screens/planner/pages/planner_page/cubit/planner_cubit.dart';
import 'package:my_bullet_journal/data/models/event_model.dart';
import 'package:my_bullet_journal/data/models/holidays_model.dart';
import 'package:my_bullet_journal/domain/repositories/planner_event_repository.dart';
import 'package:my_bullet_journal/domain/repositories/planner_holidays_repository.dart';

class MockPlannerEventsRepository extends Mock
    implements PlannerEventRepository {}

class MockPlannerHolidaysRepository extends Mock
    implements PlannerHolidaysRepository {}

void main() {
  late MockPlannerEventsRepository eventRepository;
  late MockPlannerHolidaysRepository holidaysRepository;
  late PlannerCubit sut;

  setUp(() {
    eventRepository = MockPlannerEventsRepository();
    holidaysRepository = MockPlannerHolidaysRepository();
    sut = PlannerCubit(eventRepository, holidaysRepository);
  });
  group('getHolidays', () {
    setUp(() {
      when(() => holidaysRepository.getHolidays('US')).thenAnswer((_) async => [
            HolidayModel(
                name: 'name1', date: DateTime(2022, 1, 1), type: 'type1'),
            HolidayModel(
                name: 'name2', date: DateTime(2023, 1, 1), type: 'type2'),
          ]);
    });
    blocTest(
      'return List and emit Status.success',
      build: () => sut,
      act: (cubit) => cubit.getHolidays('US'),
      expect: () => [PlannerState(status: Status.success)],
    );
  });
  group('start', () {
    group('success', () {
      setUp(() {
        when(() => eventRepository.getAppointments())
            .thenAnswer((_) => Stream.fromIterable([
                  [
                    EventModel(
                        id: '1',
                        eventName: 'name',
                        startTime: Timestamp.fromDate(DateTime(2022, 1, 1)),
                        endTime: Timestamp.fromDate(DateTime(2022, 1, 1)),
                        isAllDay: true,
                        colorValue: appGrey.value),
                    EventModel(
                        id: '2',
                        eventName: 'name2',
                        startTime: Timestamp.fromDate(DateTime(2022, 1, 1)),
                        endTime: Timestamp.fromDate(DateTime(2022, 1, 1)),
                        isAllDay: true,
                        colorValue: appGrey.value),
                  ]
                ]));
      });
      blocTest(
        'emits Status.loading then Status.success with items',
        build: () => sut,
        act: (cubit) => cubit.start(),
        expect: () => [
          PlannerState(status: Status.loading),
          PlannerState(status: Status.success, appointments: [
            EventModel(
                id: '1',
                eventName: 'name',
                startTime: Timestamp.fromDate(DateTime(2022, 1, 1)),
                endTime: Timestamp.fromDate(DateTime(2022, 1, 1)),
                isAllDay: true,
                colorValue: appGrey.value),
            EventModel(
                id: '2',
                eventName: 'name2',
                startTime: Timestamp.fromDate(DateTime(2022, 1, 1)),
                endTime: Timestamp.fromDate(DateTime(2022, 1, 1)),
                isAllDay: true,
                colorValue: appGrey.value),
          ]),
        ],
      );
    });
    group('error', () {
      setUp(() {
        when(() => eventRepository.getAppointments())
            .thenAnswer((_) => Stream.error(Exception('test-exception-error')));
      });
      blocTest(
        'emits Status.error with errorMessage',
        build: () => sut,
        act: (cubit) => cubit.start(),
        expect: () => [
          PlannerState(status: Status.loading),
          PlannerState(
              status: Status.error,
              errorMessage: 'Exception: test-exception-error'),
        ],
      );
    });
  });
}
