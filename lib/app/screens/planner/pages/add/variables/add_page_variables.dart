import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

var newEvent = '',
    notes = '',
    recurrenceEndDate = 'Select a date',
    dropdownValue = 'Never';
String? recurrenceRulewithoutEnd, endrecurrenceRule, recurrenceRule;
int colorValue = 0xff70e4e7, intDropdownValue = 1;
const space = SizedBox(height: 15), empty = SizedBox();
List<int> intDropdownList = [for (int i = 1; i <= 100; i++) i];
const appPurple = Color.fromARGB(255, 160, 117, 217);
Color pickerColor = const Color.fromARGB(255, 160, 117, 217),
    currentColor = Colors.black;
bool repeat = false, isAllDay = false;
List<bool> isSelected = [true, false, false, false];
var eventStartTime = DateTime.now(),
    eventEndTime = DateTime.now().add(const Duration(hours: 1));
final buttonStyle = ElevatedButton.styleFrom(
  fixedSize: const Size(400, 25),
  backgroundColor: Colors.white,
  foregroundColor: Colors.black,
);
final textStyle = GoogleFonts.amaticSc(
    textStyle: const TextStyle(fontWeight: FontWeight.w400, fontSize: 22));
