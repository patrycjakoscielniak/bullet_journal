part of 'edit_event_cubit.dart';

@freezed
class EditEventState with _$EditEventState {
  factory EditEventState({
    @Default(Status.initial) Status status,
    String? errorMessage,
  }) = _EditEventState;
}
