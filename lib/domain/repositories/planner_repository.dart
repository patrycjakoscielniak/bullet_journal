import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';
import '../../data/models/planner_item_model.dart';
import 'package:http/http.dart' as http;

@injectable
class PlannerRepository {
  PlannerRepository();

  final firebaseRef = FirebaseFirestore.instance
      .collection('users')
      .doc(FirebaseAuth.instance.currentUser?.uid)
      .collection('planner');

  Stream<List<PlannerModel>> getAppointments() {
    return firebaseRef.snapshots().map((snapshots) {
      return snapshots.docs.map((doc) {
        return PlannerModel(
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

  Future<List<Holidays>> fetchHolidays() async {
    final years = [
      '2023',
      '2024',
      '2025',
      '2026',
      '2027',
      '2028',
      '2029',
      '2030'
    ];
    final List<Holidays> holidaysList = [];
    for (final year in years) {
      final url = Uri.parse('https://public-holiday.p.rapidapi.com/$year/PL');
      final response = await http.get(url, headers: {
        "X-RapidAPI-Key": "139e0b9fa2msh89a1ebdff767cf4p156932jsn676885f8ec26",
        "X-RapidAPI-Host": "public-holiday.p.rapidapi.com"
      });
      var dynamic = jsonDecode(response.body);
      final list =
          (dynamic as List).map((data) => Holidays.fromJson(data)).toList();
      holidaysList.addAll(list);
    }
    return holidaysList;
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
