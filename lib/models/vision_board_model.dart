import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'vision_board_model.freezed.dart';

@freezed
class VisionBoardModel with _$VisionBoardModel {
  const factory VisionBoardModel({
    required String image,
    required String id,
    Timestamp? onCreated,
  }) = _VisionBoardModel;
}
