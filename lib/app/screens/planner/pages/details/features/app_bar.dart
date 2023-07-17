import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class EventDetailsAppBarWidget extends StatelessWidget {
  const EventDetailsAppBarWidget({
    super.key,
    required this.eventName,
    required this.colorValue,
  });

  final String eventName;
  final int colorValue;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 68, left: 35, right: 28),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(
              eventName,
              textAlign: TextAlign.center,
              style: GoogleFonts.marckScript(
                  color: Color(colorValue),
                  fontWeight: FontWeight.w400,
                  fontSize: 28),
            ),
          ),
          IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: const Icon(Icons.close)),
        ],
      ),
    );
  }
}
