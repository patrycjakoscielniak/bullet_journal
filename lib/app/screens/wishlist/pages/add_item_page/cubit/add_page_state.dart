part of 'add_page_cubit.dart';

@immutable
class AddItemPageState {
  const AddItemPageState({
    this.status = Status.initial,
    this.errorMessage,
  });
  final Status status;
  final String? errorMessage;
}
