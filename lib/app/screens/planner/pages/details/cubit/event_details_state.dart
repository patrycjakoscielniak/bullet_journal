part of 'event_details_cubit.dart';

@freezed
class EventDetailsState with _$EventDetailsState {
  factory EventDetailsState({
    @Default(Status.initial) Status status,
    String? errorMessage,
  }) = _EventDetailsState;
}
