part of 'add_item_page_cubit.dart';

@freezed
class AddItemPageState with _$AddItemPageState {
  factory AddItemPageState({
    @Default(Status.initial) Status status,
    String? errorMessage,
  }) = _AddItemPageState;
}
