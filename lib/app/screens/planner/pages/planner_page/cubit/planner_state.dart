part of 'planner_cubit.dart';

@immutable
class PlannerState {
  const PlannerState({
    this.appointments = const [],
    this.errorMessage,
    this.status = Status.initial,
  });
  final List<PlannerModel> appointments;
  final String? errorMessage;
  final Status status;
}
