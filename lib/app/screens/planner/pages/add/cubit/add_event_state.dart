part of 'add_event_cubit.dart';

@freezed
class AddEventState with _$AddEventState {
  factory AddEventState({
    @Default(Status.initial) Status status,
    String? errorMessage,
  }) = _AddEventState;
}
