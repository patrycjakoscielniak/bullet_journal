part of 'vision_board_cubit.dart';

@freezed
class VisionBoardState with _$VisionBoardState {
  factory VisionBoardState({
    @Default([]) List<VisionBoardModel> items,
    @Default(Status.initial) Status status,
    String? errorMessage,
  }) = _VisionBoardState;
}
