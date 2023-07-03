part of 'add_item_cubit.dart';

@freezed
class AddItemState with _$AddItemState {
  factory AddItemState({
    @Default(Status.initial) Status status,
    String? errorMessage,
  }) = _AddItemState;
}
