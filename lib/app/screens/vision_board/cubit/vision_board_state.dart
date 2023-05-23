part of 'vision_board_cubit.dart';

@immutable
class VisionBoardState {
  const VisionBoardState(
      {required this.items,
      this.errorMessage = '',
      this.status = Status.initial});

  final List<VisionBoardModel> items;
  final String errorMessage;
  final Status status;
}
