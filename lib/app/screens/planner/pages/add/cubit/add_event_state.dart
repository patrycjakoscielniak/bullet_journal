part of 'add_event_cubit.dart';

@immutable
class AddEventState {
  AddEventState({
    this.isSaved = false,
    this.errorMessage = '',
  });
  final bool isSaved;
  final String errorMessage;
}
