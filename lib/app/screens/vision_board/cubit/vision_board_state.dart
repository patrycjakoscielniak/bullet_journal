part of 'vision_board_cubit.dart';

@immutable
class VisionBoardState {
  const VisionBoardState({
    required this.items,
    required this.errorMessage,
  });

  final List<VisionBoardModel> items;
  final String errorMessage;
}
