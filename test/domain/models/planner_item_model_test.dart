import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:my_bullet_journal/app/core/global_variables.dart';
import 'package:my_bullet_journal/domain/models/planner_item_model.dart';

void main() {
  test('should getter start return startTime converted to DateTime', () {
    final model = PlannerModel(
      eventName: '',
      id: '',
      startTime: Timestamp.fromDate(DateTime(2022, 1, 1, 12, 0)),
      endTime: Timestamp.now(),
      isAllDay: false,
      colorValue: appPurple.value,
    );
    final result = model.start;
    expect(result, DateTime(2022, 1, 1, 12, 0));
  });
  test('should getter end return endTime converted to DateTime', () {
    final model = PlannerModel(
      eventName: '',
      id: '',
      startTime: Timestamp.now(),
      endTime: Timestamp.fromDate(DateTime(2022, 1, 1, 13, 0)),
      isAllDay: false,
      colorValue: appPurple.value,
    );
    final result = model.end;
    expect(result, DateTime(2022, 1, 1, 13, 0));
  });
}
