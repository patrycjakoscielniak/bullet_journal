part of 'edit_event_cubit.dart';

@immutable
class EditEventState {
  const EditEventState({this.errorMessage, this.status = Status.success});
  final String? errorMessage;
  final Status status;
}
