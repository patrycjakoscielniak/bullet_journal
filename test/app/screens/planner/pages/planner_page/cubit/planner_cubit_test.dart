import 'package:bloc_test/bloc_test.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:my_bullet_journal/app/core/enums.dart';
import 'package:my_bullet_journal/app/core/global_variables.dart';
import 'package:my_bullet_journal/app/screens/planner/pages/planner_page/cubit/planner_cubit.dart';
import 'package:my_bullet_journal/data/models/planner_item_model.dart';
import 'package:my_bullet_journal/domain/repositories/planner_repository.dart';

class MockPlannerRepository extends Mock implements PlannerRepository {}

void main() {
  late MockPlannerRepository repository;
  late PlannerCubit sut;

  setUp(() {
    repository = MockPlannerRepository();
    sut = PlannerCubit(repository);
  });
  group('start', () {
    group('success', () {
      setUp(() {
        when(() => repository.getAppointments())
            .thenAnswer((_) => Stream.fromIterable([
                  [
                    PlannerModel(
                        id: '1',
                        eventName: 'name',
                        startTime: Timestamp.fromDate(DateTime(2022, 1, 1)),
                        endTime: Timestamp.fromDate(DateTime(2022, 1, 1)),
                        isAllDay: true,
                        colorValue: appGrey.value),
                    PlannerModel(
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
            PlannerModel(
                id: '1',
                eventName: 'name',
                startTime: Timestamp.fromDate(DateTime(2022, 1, 1)),
                endTime: Timestamp.fromDate(DateTime(2022, 1, 1)),
                isAllDay: true,
                colorValue: appGrey.value),
            PlannerModel(
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
        when(() => repository.getAppointments())
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
