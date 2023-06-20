import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

var newEvent = '';
var notes = '';
var freq = '';
var byDay = '';
int? byMonth;
int? byMonthDay;
int? count;
DateTime? until;
const space = SizedBox(height: 15);
const empty = SizedBox();
var recurrenceEndDate = 'Select a date';
String dropdownValue = 'Never';
int intDropdownValue = 1;
List<int> intDropdownList = [for (int i = 1; i <= 100; i++) i];
const appPurple = Color.fromARGB(255, 160, 117, 217);
bool repeat = false;
List<bool> isSelected = [true, false, false, false];
bool isAllDay = false;
var currentdate = DateFormat('dd  MMMM yy').format(DateTime.now());
var eventStartTime = DateTime.now();
var eventEndTime = DateTime.now().add(const Duration(hours: 1));
Color pickerColor = const Color.fromARGB(255, 160, 117, 217);
Color currentColor = Colors.black;
final buttonStyle = ElevatedButton.styleFrom(
  fixedSize: const Size(400, 25),
  backgroundColor: Colors.white,
  foregroundColor: Colors.black,
);
final textStyle = GoogleFonts.amaticSc(
    textStyle: const TextStyle(fontWeight: FontWeight.w400, fontSize: 22));
