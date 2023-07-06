import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';
import '../../data/models/event_model.dart';

@injectable
class PlannerEventRepository {
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
