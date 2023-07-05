import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';
import 'package:my_bullet_journal/data/remote_data_sources/planner_remote_data_source.dart';
import '../../data/models/event_model.dart';
import '../../data/models/holidays_model.dart';

@injectable
class PlannerRepository {
  PlannerRepository(this._plannerRemoteDataSource);
  final PlannerRemoteDataSource _plannerRemoteDataSource;

  final firebaseRef = FirebaseFirestore.instance
      .collection('users')
      .doc(FirebaseAuth.instance.currentUser?.uid)
      .collection('planner');

  Stream<List<EventModel>> getAppointments() {
    return firebaseRef.snapshots().map((snapshots) {
      return snapshots.docs.map((doc) {
        return EventModel(
          isAllDay: doc.data()['isAllDay'],
          notes: doc.data()['notes'],
          startTime: (doc.data()['startTime']),
          endTime: doc.data()['endTime'],
          id: doc.id,
          eventName: doc.data()['name'],
          colorValue: doc.data()['colorValue'],
          recurrenceRule: doc.data()['recurrenceRule'],
          frequency: doc.data()['frequency'],
          recurrenceRuleEnding: doc.data()['recurrenceRuleEnding'],
        );
      }).toList();
    });
  }

  Future<List<HolidayModel>> getHolidays() async {
    final response = await _plannerRemoteDataSource.fetchHolidays();
    var dynamic = jsonDecode(response);
    final list =
        (dynamic as List).map((data) => HolidayModel.fromJson(data)).toList();
    return list;
  }

  Future<void> add(
    String name,
    String? notes,
    DateTime startTime,
    DateTime endTime,
    bool isAllDay,
    int colorValue,
    String? recurrenceRule,
    String? frequency,
    String? recurrenceRuleEnding,
  ) async {
    await firebaseRef.add(
      {
        'name': name,
        'notes': notes,
        'startTime': startTime,
        'endTime': endTime,
        'isAllDay': isAllDay,
        'colorValue': colorValue,
        'recurrenceRule': recurrenceRule,
        'frequency': frequency,
        'recurrenceRuleEnding': recurrenceRuleEnding,
      },
    );
  }

  Future<void> update({
    required String id,
    required String eventName,
    required String? notes,
    required String? recurrenceRule,
    required String? recurrenceRuleEnding,
    required String? frequency,
    required DateTime startTime,
    required DateTime endTime,
    required bool isAllDay,
    required int colorValue,
  }) async {
    return firebaseRef.doc(id).update({
      'name': eventName,
      'notes': notes,
      'startTime': startTime,
      'endTime': endTime,
      'isAllDay': isAllDay,
      'colorValue': colorValue,
      'recurrenceRule': recurrenceRule,
      'recurrenceRuleEnding': recurrenceRuleEnding,
      'frequency': frequency,
    });
  }

  Future<void> delete({required String id}) async {
    return firebaseRef.doc(id).delete();
  }
}
