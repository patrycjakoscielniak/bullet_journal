import 'dart:io';

import 'package:flutter/material.dart';
import 'package:my_bullet_journal/app/screens/planner/variables/planner_variables.dart';
import '../../../../../core/global_variables.dart';
import '../../edit/page/edit_page.dart';
import '../features/body.dart';
import '../features/app_bar.dart';
import '../features/delete_event_dialog.dart';

class EventDetails extends StatelessWidget {
  const EventDetails({
    super.key,
    required this.eventName,
    required this.id,
    required this.timeDetails,
    required this.dateText,
    required this.dropdownValue,
    required this.colorValue,
    required this.recurrenceRuleWithoutEnd,
    required this.recurrenceRule,
    required this.recurrenceRuleEnding,
    required this.displayRecurrenceRuleEndDate,
    required this.frequency,
    required this.dropdownInt,
    required this.startTime,
    required this.endTime,
    required this.isAllDay,
    required this.isRecurring,
    required this.recurrenceType,
    required this.notes,
  });

  final String eventName,
      id,
      timeDetails,
      dateText,
      dropdownValue,
      recurrenceRuleWithoutEnd,
      displayRecurrenceRuleEndDate;
  final int dropdownInt, colorValue;
  final DateTime startTime, endTime;
  final bool isAllDay, isRecurring;
  final List<bool> recurrenceType;
  final String? notes, frequency, recurrenceRuleEnding, recurrenceRule;

  @override
  Widget build(BuildContext context) {
    List<Widget> body = [
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Start Date:   $dateText', style: mainTextStyle),
          Text('Time:   $timeDetails', style: mainTextStyle),
        ],
      ),
      Text(
          (recurrenceRule == null || recurrenceRule == '')
              ? 'One-time event'
              : 'Recurring $frequency',
          style: mainTextStyle),
      Text((notes != null) ? notes! : 'No notes', style: mainTextStyle),
    ];
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(MediaQuery.of(context).size.width, 200),
        child: EventDetailsAppBarWidget(
            eventName: eventName, colorValue: colorValue),
      ),
      body: EventDetailsPageBody(body: body),
      bottomSheet: BottomAppBar(
        height: Platform.isAndroid ? 60 : 80,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            DeleteEventDialog(id: id, colorValue: colorValue),
            const VerticalDivider(),
            IconButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => EditEventPage(
                          id: id,
                          colorValue: colorValue,
                          eventName: eventName,
                          eventStartTime: startTime,
                          eventEndTime: endTime,
                          isAllDay: isAllDay,
                          isRecurring: isRecurring,
                          dropdownValue: dropdownValue,
                          dropdownInt: dropdownInt,
                          recurrenceRuleWithoutEnd: recurrenceRuleWithoutEnd,
                          displayRecurrenceRuleEndDate:
                              displayRecurrenceRuleEndDate,
                          frequency: frequency,
                          notes: notes,
                          recurrenceType: recurrenceType,
                          recurrenceRuleEnding: recurrenceRuleEnding,
                        )));
              },
              icon: Icon(
                Icons.edit_outlined,
                color: Color(colorValue),
              ),
            )
          ],
        ),
      ),
    );
  }
}
