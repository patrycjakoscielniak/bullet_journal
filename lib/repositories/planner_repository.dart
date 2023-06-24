import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:my_bullet_journal/app/data/planner_remote_data_source.dart';
import 'package:my_bullet_journal/models/planner_item_model.dart';

class PlannerRepository {
  PlannerRepository({required this.remoteDataSource});

  final firebaseRef = FirebaseFirestore.instance
      .collection('users')
      .doc(FirebaseAuth.instance.currentUser?.uid)
      .collection('planner');

  final HolidaysRemoteDioDataSource remoteDataSource;

  // Future<List<HolidaysModel>> getHolidays() async {
  //   final json = await remoteDataSource.getHolidays();
  //   if (json == null) {
  //     return [];
  //   }
  //   return json.map((item) => HolidaysModel.fromJson(item)).toList();
  // }

  Stream<List<PlannerModel>> getAppointments() {
    return firebaseRef.snapshots().map((snapshots) {
      return snapshots.docs.map((doc) {
        return PlannerModel(
          isAllDay: doc.data()['isAllDay'],
          notes: doc.data()['notes'],
          startTime: doc.data()['startTime'],
          endTime: doc.data()['endTime'],
          id: doc.id,
          eventName: doc.data()['name'],
          colorValue: doc.data()['colorValue'],
          recurrenceRule: doc.data()['recurrenceRule'],
          frequency: doc.data()['frequency'],
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
      },
    );
  }

  Future<void> update({
    required String id,
    required String eventName,
    required String? notes,
    required String? recurrenceRule,
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
      'frequency': frequency,
    });
  }

  Future<void> delete({required String id}) async {
    return firebaseRef.doc(id).delete();
  }
}
