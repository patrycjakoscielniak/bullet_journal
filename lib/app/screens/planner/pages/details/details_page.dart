import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DetailsPage extends StatefulWidget {
  const DetailsPage({
    super.key,
    required this.subjectText,
    required this.startTimeText,
    required this.endTimeText,
    required this.dateText,
    required this.timeDetails,
    required this.notes,
  });

  final String subjectText,
      startTimeText,
      endTimeText,
      dateText,
      timeDetails,
      notes;

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  final containerDecoration = BoxDecoration(
      border: Border.all(width: 0.5),
      borderRadius: const BorderRadius.all(Radius.circular(10)));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        foregroundColor: Colors.black,
        title: Text(
          'Event',
          style: GoogleFonts.amaticSc(color: Colors.black),
        ),
      ),
      bottomSheet: SizedBox(
        height: 70,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.edit_outlined,
                )),
            const VerticalDivider(),
            IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.delete_outline,
                ))
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                padding: const EdgeInsets.only(left: 8),
                alignment: Alignment.centerLeft,
                constraints: BoxConstraints(
                  minWidth: MediaQuery.of(context).size.width,
                  minHeight: 80,
                ),
                decoration: containerDecoration,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.subjectText,
                    ),
                    Text(
                      widget.dateText,
                    ),
                    Text(
                      widget.timeDetails,
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                padding: const EdgeInsets.only(left: 8),
                alignment: Alignment.centerLeft,
                constraints: BoxConstraints(
                  minWidth: MediaQuery.of(context).size.width,
                  minHeight: 50,
                ),
                decoration: containerDecoration,
                child: Text(
                  widget.notes,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
