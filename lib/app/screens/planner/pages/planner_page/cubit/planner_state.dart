part of 'planner_cubit.dart';

@freezed
class PlannerState with _$PlannerState {
  factory PlannerState({
    @Default([]) List<PlannerModel> appointments,
    @Default(Status.initial) Status status,
    String? errorMessage,
  }) = _PlannerState;
}
