import 'package:flutter/material.dart';

final elevatedButtonStyle = ElevatedButton.styleFrom(
  fixedSize: const Size(400, 25),
  backgroundColor: Colors.white,
  foregroundColor: Colors.black,
);
final containerDecoration = BoxDecoration(
    border: Border.all(width: 0.5),
    borderRadius: const BorderRadius.all(Radius.circular(10)));
final List<String> byWeekDayValue = [
  '',
  'FREQ=WEEKLY;BYDAY=MO',
  'FREQ=WEEKLY;BYDAY=TU',
  'FREQ=WEEKLY;BYDAY=WE',
  'FREQ=WEEKLY;BYDAY=TH',
  'FREQ=WEEKLY;BYDAY=FR',
  'FREQ=WEEKLY;BYDAY=SA',
  'FREQ=WEEKLY;BYDAY=SU'
];
