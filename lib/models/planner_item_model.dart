import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'planner_item_model.freezed.dart';

@freezed
class PlannerModel with _$PlannerModel {
  const PlannerModel._();
  factory PlannerModel({
    required String eventName,
    required String id,
    required Timestamp startTime,
    required Timestamp endTime,
    required bool isAllDay,
    required int colorValue,
    String? notes,
    String? recurrenceRule,
    String? frequency,
    String? recurrenceRuleEnding,
  }) = _PlannerModel;

  DateTime get start {
    return startTime.toDate();
  }

  DateTime get end {
    return endTime.toDate();
  }
}
