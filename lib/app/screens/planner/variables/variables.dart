import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

const space = SizedBox(height: 15), empty = SizedBox();
const appPurple = Color.fromARGB(255, 160, 117, 217);
final buttonStyle = ElevatedButton.styleFrom(
  fixedSize: const Size(400, 25),
  backgroundColor: Colors.white,
  foregroundColor: Colors.black,
);
final textStyle = GoogleFonts.amaticSc(
    textStyle: const TextStyle(fontWeight: FontWeight.w400, fontSize: 22));
final appointmentTextStyle = GoogleFonts.roboto(
    textStyle: const TextStyle(color: Colors.white, fontSize: 13));
final containerDecoration = BoxDecoration(
    border: Border.all(width: 0.5),
    borderRadius: const BorderRadius.all(Radius.circular(10)));
final dialogContainerDecoration = BoxDecoration(
    color: Colors.white,
    border: Border.all(width: 0.5),
    borderRadius: const BorderRadius.all(Radius.circular(10)));
