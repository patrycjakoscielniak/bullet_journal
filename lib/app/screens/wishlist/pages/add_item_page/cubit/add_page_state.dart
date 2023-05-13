part of 'add_page_cubit.dart';

@immutable
class AddItemPageState {
  const AddItemPageState({
    this.saved = false,
    this.errorMessage = '',
  });
  final bool saved;
  final String errorMessage;
}
