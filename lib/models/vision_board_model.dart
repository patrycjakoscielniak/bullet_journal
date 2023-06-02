import 'package:cloud_firestore/cloud_firestore.dart';

class VisionBoardModel {
  VisionBoardModel({
    required this.image,
    required this.id,
    required this.onCreated,
  });
  final String image;
  final String id;
  final Timestamp? onCreated;
}
