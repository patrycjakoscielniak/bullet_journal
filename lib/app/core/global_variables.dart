import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

const appPurple = Color.fromARGB(255, 160, 117, 217);
const errorColor = Color.fromARGB(255, 221, 55, 9);
const appGrey = Colors.blueGrey;
final dialogContainerDecoration = BoxDecoration(
    color: Colors.white,
    border: Border.all(width: 0.5),
    borderRadius: const BorderRadius.all(Radius.circular(10)));
final mainTextStyle = GoogleFonts.amaticSc(
    textStyle: const TextStyle(fontWeight: FontWeight.w400, fontSize: 22));
const space = SizedBox(height: 15), empty = SizedBox();
final initialdiplaysTextStyle = GoogleFonts.tangerine(
    fontSize: 28, fontWeight: FontWeight.w400, color: appGrey);
