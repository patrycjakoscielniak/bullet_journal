part of 'planner_cubit.dart';

@immutable
class PlannerState {
  const PlannerState({
    this.holidaysResults = const [],
    this.errorMessage,
    this.status = Status.initial,
  });
  final List<HolidaysModel> holidaysResults;
  final String? errorMessage;
  final Status status;
}
