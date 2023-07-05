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

class Holidays {
  String name;
  DateTime date;

  Holidays({required this.name, required this.date});
  factory Holidays.fromJson(Map<String, dynamic> parsedJson) {
    return Holidays(
        name: parsedJson['localName'].toString(),
        date: DateTime.parse(parsedJson['date']));
  }
}
