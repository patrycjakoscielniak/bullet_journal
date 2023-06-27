import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

const space = SizedBox(height: 15), empty = SizedBox();
final elevatedButtonStyle = ElevatedButton.styleFrom(
  fixedSize: const Size(400, 25),
  backgroundColor: Colors.white,
  foregroundColor: Colors.black,
);
final appointmentTextStyle = GoogleFonts.roboto(
    textStyle: const TextStyle(color: Colors.white, fontSize: 13));
final containerDecoration = BoxDecoration(
    border: Border.all(width: 0.5),
    borderRadius: const BorderRadius.all(Radius.circular(10)));
