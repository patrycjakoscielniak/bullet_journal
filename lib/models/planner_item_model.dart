import 'package:cloud_firestore/cloud_firestore.dart';

class PlannerModel {
  PlannerModel({
    this.notes,
    required this.startTime,
    required this.endTime,
    required this.eventName,
    required this.id,
    required this.isAllDay,
  });
  final bool isAllDay;
  final String? notes;
  final String id;
  final Timestamp startTime;
  final Timestamp endTime;
  final String eventName;

  DateTime get start {
    return startTime.toDate();
  }

  DateTime get end {
    return endTime.toDate();
  }
}
