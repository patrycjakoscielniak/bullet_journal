import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:my_bullet_journal/app/data/planner_remote_data_source.dart';
import 'package:my_bullet_journal/app/screens/planner/pages/edit/edit_page.dart';
import 'package:my_bullet_journal/app/screens/planner/variables/variables.dart';
import 'package:my_bullet_journal/repositories/planner_repository.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import '../add/add_event.dart';
import 'cubit/planner_cubit.dart';

class Planner extends StatefulWidget {
  const Planner({
    super.key,
  });

  @override
  State<Planner> createState() => _PlannerState();
}

class _PlannerState extends State<Planner> {
  List<Appointment> events = [];
  String subjectText = '',
      dateText = '',
      timeDetails = '',
      recurrenceRuleWithoutEndText = '',
      recurrenceRuleEndingText = '',
      displayRecurrenceRuleEndDate = 'Select a date',
      dropdownValueText = '';
  String? notesText = '', frequencyText = '';
  late Object id;
  late Color color;
  late DateTime existingEventStartTime, existingEventEndTime;
  DateTime? recurrenceRuleEndDate;
  bool isEventAllDay = false, isEventRecurring = false;
  int dropdownInt = 1;
  final List<String> oneDigitMonthDays = [
        'BYMONTHDAY=1',
        'BYMONTHDAY=2',
        'BYMONTHDAY=3',
        'BYMONTHDAY=4',
        'BYMONTHDAY=5',
        'BYMONTHDAY=6',
        'BYMONTHDAY=7',
        'BYMONTHDAY=1',
        'BYMONTHDAY=1',
      ],
      twoDigitsMonth = [
        'BYMONTH=10',
        'BYMONTH=11',
        'BYMONTH=12',
      ];
  List<bool> recurrenceType = [true, false, false, false],
      isOneDigitMonthDayList = [],
      isTwoDigitMonthList = [];

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PlannerCubit(
          PlannerRepository(remoteDataSource: HolidaysRemoteDioDataSource()))
        ..start(),
      child: BlocBuilder<PlannerCubit, PlannerState>(
        builder: (context, state) {
          final tasks = state.appointments;
          events.clear();

          for (final task in tasks) {
            if (task.recurrenceRule == '') {
              events.add(Appointment(
                id: task.id,
                notes: task.notes,
                subject: task.eventName,
                startTime: task.start,
                endTime: task.end,
                isAllDay: task.isAllDay,
                color: Color(task.colorValue),
                location: task.frequency,
              ));
            } else {
              events.add(Appointment(
                id: task.id,
                notes: task.notes,
                subject: task.eventName,
                startTime: task.start,
                endTime: task.end,
                isAllDay: task.isAllDay,
                color: Color(task.colorValue),
                location: task.frequency,
                recurrenceRule: task.recurrenceRule,
              ));
            }
          }

          return Scaffold(
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const AddEvent()));
              },
              mini: true,
              child: const Icon(Icons.add),
            ),
            body: SfCalendar(
              onTap: calendarTapped,
              headerStyle: CalendarHeaderStyle(
                  textStyle: GoogleFonts.amaticSc(fontSize: 25)),
              viewNavigationMode: ViewNavigationMode.snap,
              view: CalendarView.month,
              monthViewSettings: const MonthViewSettings(
                  dayFormat: 'EEE',
                  agendaItemHeight: 40,
                  showAgenda: true,
                  appointmentDisplayMode:
                      MonthAppointmentDisplayMode.indicator),
              dataSource: DataSource(events),
              showNavigationArrow: true,
              showDatePickerButton: true,
              firstDayOfWeek: 1,
              headerHeight: 50,
              allowedViews: const [
                CalendarView.day,
                CalendarView.workWeek,
                CalendarView.week,
                CalendarView.month,
              ],
            ),
          );
        },
      ),
    );
  }

  void calendarTapped(CalendarTapDetails details) {
    if (details.targetElement == CalendarElement.appointment ||
        details.targetElement == CalendarElement.agenda) {
      final Appointment appointmentDetails = details.appointments![0];
      subjectText = appointmentDetails.subject;
      final startTime = appointmentDetails.startTime,
          endTime = appointmentDetails.endTime;
      dateText = DateFormat('dd MMMM yyyy')
          .format(appointmentDetails.startTime)
          .toString();
      final eventId = appointmentDetails.id.toString();
      final startTimeText =
          DateFormat('hh:mm a').format(appointmentDetails.startTime).toString();
      final endTimeText =
          DateFormat('hh:mm a').format(appointmentDetails.endTime).toString();
      if (appointmentDetails.isAllDay) {
        timeDetails = 'All day';
      } else {
        timeDetails = '$startTimeText - $endTimeText';
      }
      color = appointmentDetails.color;
      if (appointmentDetails.location != '') {
        frequencyText = appointmentDetails.location;
        isEventRecurring = true;
      } else {
        frequencyText = 'One-time event';
        isEventRecurring = false;
      }
      if (appointmentDetails.notes != '') {
        notesText = appointmentDetails.notes;
      } else {
        notesText = 'No notes';
      }
      if (appointmentDetails.recurrenceRule != null) {
        if (appointmentDetails.recurrenceRule!.contains('UNTIL')) {
          dropdownValueText = 'On date';
        }
        if (appointmentDetails.recurrenceRule!.contains('COUNT')) {
          dropdownValueText = 'After';
        } else {
          dropdownValueText = 'Never';
        }
        isEventRecurring = true;
      } else {
        isEventRecurring = false;
        dropdownValueText = 'Never';
      }
      if (appointmentDetails.location == '') {
        recurrenceType = [true, false, false, false];
        recurrenceRuleWithoutEndText = '';
      }
      if (appointmentDetails.location == 'Yearly') {
        recurrenceType = [true, false, false, false];
        recurrenceRuleWithoutEndText =
            'FREQ=YEARLY;BYMONTH=${DateFormat('M').format(appointmentDetails.startTime)};BYMONTHDAY=${DateFormat('d').format(appointmentDetails.startTime)}';
        if (appointmentDetails.recurrenceRule!.contains('UNTIL')) {
          if (appointmentDetails.recurrenceRule!.length == 56) {
            recurrenceRuleEndDate = DateTime.parse(
                appointmentDetails.recurrenceRule!.substring(41, 55));
            displayRecurrenceRuleEndDate =
                DateFormat('dd  MMMM yyyy').format(recurrenceRuleEndDate!);
            recurrenceRuleEndingText =
                appointmentDetails.recurrenceRule!.substring(35, 55);
          }
          if (appointmentDetails.recurrenceRule!.length == 57) {
            recurrenceRuleEndDate = DateTime.parse(
                appointmentDetails.recurrenceRule!.substring(42, 56));
            displayRecurrenceRuleEndDate =
                DateFormat('dd  MMMM yyyy').format(recurrenceRuleEndDate!);
            recurrenceRuleEndingText =
                appointmentDetails.recurrenceRule!.substring(36, 56);
          }
          if (appointmentDetails.recurrenceRule!.length == 58) {
            recurrenceRuleEndDate = DateTime.parse(
                appointmentDetails.recurrenceRule!.substring(43, 57));
            displayRecurrenceRuleEndDate =
                DateFormat('dd  MMMM yyyy').format(recurrenceRuleEndDate!);
            recurrenceRuleEndingText =
                appointmentDetails.recurrenceRule!.substring(37, 57);
          }
        }
        if (appointmentDetails.recurrenceRule!.contains('COUNT')) {
          for (final element in oneDigitMonthDays) {
            bool isMonthDayOneDigit =
                appointmentDetails.recurrenceRule!.contains(element);
            isOneDigitMonthDayList.add(isMonthDayOneDigit);
          }
          for (final element in twoDigitsMonth) {
            bool isMonthTwoDigits =
                appointmentDetails.recurrenceRule!.contains(element);
            isTwoDigitMonthList.add(isMonthTwoDigits);
          }
          if (appointmentDetails.recurrenceRule!.length == 42) {
            recurrenceRuleEndingText =
                appointmentDetails.recurrenceRule!.substring(35);
            dropdownInt =
                int.parse(appointmentDetails.recurrenceRule!.substring(41));
          }
          if (appointmentDetails.recurrenceRule!.length == 43) {
            if (isTwoDigitMonthList.contains(true) &&
                    isOneDigitMonthDayList.contains(true) ||
                !isTwoDigitMonthList.contains(true) &&
                    !isOneDigitMonthDayList.contains(true)) {
              recurrenceRuleEndingText =
                  appointmentDetails.recurrenceRule!.substring(36);
              dropdownInt =
                  int.parse(appointmentDetails.recurrenceRule!.substring(42));
            }
            if (!isTwoDigitMonthList.contains(true) &&
                isOneDigitMonthDayList.contains(true)) {
              recurrenceRuleEndingText =
                  appointmentDetails.recurrenceRule!.substring(35);
              dropdownInt =
                  int.parse(appointmentDetails.recurrenceRule!.substring(41));
            }
          }
          if (appointmentDetails.recurrenceRule!.length == 44) {
            if (isTwoDigitMonthList.contains(true) &&
                    isOneDigitMonthDayList.contains(true) ||
                !isTwoDigitMonthList.contains(true) &&
                    !isOneDigitMonthDayList.contains(true)) {
              recurrenceRuleEndingText =
                  appointmentDetails.recurrenceRule!.substring(36);
              dropdownInt =
                  int.parse(appointmentDetails.recurrenceRule!.substring(42));
            }
            if (!isTwoDigitMonthList.contains(true) &&
                isOneDigitMonthDayList.contains(true)) {
              recurrenceRuleEndingText =
                  appointmentDetails.recurrenceRule!.substring(35);
              dropdownInt =
                  int.parse(appointmentDetails.recurrenceRule!.substring(41));
            }
            if (isTwoDigitMonthList.contains(true) &&
                !isOneDigitMonthDayList.contains(true)) {
              recurrenceRuleEndingText =
                  appointmentDetails.recurrenceRule!.substring(37);
              dropdownInt =
                  int.parse(appointmentDetails.recurrenceRule!.substring(43));
            }
          }
          if (appointmentDetails.recurrenceRule!.length == 45) {
            if (isTwoDigitMonthList.contains(true) &&
                    isOneDigitMonthDayList.contains(true) ||
                !isTwoDigitMonthList.contains(true) &&
                    !isOneDigitMonthDayList.contains(true)) {
              recurrenceRuleEndingText =
                  appointmentDetails.recurrenceRule!.substring(36);
              dropdownInt =
                  int.parse(appointmentDetails.recurrenceRule!.substring(42));
            }

            if (isTwoDigitMonthList.contains(true) &&
                !isOneDigitMonthDayList.contains(true)) {
              recurrenceRuleEndingText =
                  appointmentDetails.recurrenceRule!.substring(37);
              dropdownInt =
                  int.parse(appointmentDetails.recurrenceRule!.substring(43));
            }
          }
          if (appointmentDetails.recurrenceRule!.length == 46) {
            recurrenceRuleEndingText =
                appointmentDetails.recurrenceRule!.substring(38);
            dropdownInt =
                int.parse(appointmentDetails.recurrenceRule!.substring(44));
          }
        } else {
          recurrenceRuleEndingText = '';
        }
      }
      if (appointmentDetails.location == 'Monthly') {
        recurrenceType = [false, true, false, false];
        recurrenceRuleWithoutEndText =
            'FREQ=MONTHLY;BYMONTHDAY=${DateFormat('d').format(appointmentDetails.startTime)}';

        if (appointmentDetails.recurrenceRule!.contains('UNTIL')) {
          if (appointmentDetails.recurrenceRule!.length == 48) {
            recurrenceRuleEndDate = DateTime.parse(
                appointmentDetails.recurrenceRule!.substring(32, 47));
            displayRecurrenceRuleEndDate =
                DateFormat('dd  MMMM yyyy').format(recurrenceRuleEndDate!);
            recurrenceRuleEndingText =
                appointmentDetails.recurrenceRule!.substring(26, 47);
          }
          if (appointmentDetails.recurrenceRule!.length == 49) {
            recurrenceRuleEndDate = DateTime.parse(
                appointmentDetails.recurrenceRule!.substring(33, 48));
            displayRecurrenceRuleEndDate =
                DateFormat('dd  MMMM yyyy').format(recurrenceRuleEndDate!);
            recurrenceRuleEndingText =
                appointmentDetails.recurrenceRule!.substring(27, 48);
          }
        }
        if (appointmentDetails.recurrenceRule!.contains('COUNT')) {
          for (final element in oneDigitMonthDays) {
            bool isMonthDayOneDigit =
                appointmentDetails.recurrenceRule!.contains(element);
            isOneDigitMonthDayList.add(isMonthDayOneDigit);
            if (appointmentDetails.recurrenceRule!.length == 33) {
              recurrenceRuleEndingText =
                  appointmentDetails.recurrenceRule!.substring(26);
              dropdownInt =
                  int.parse(appointmentDetails.recurrenceRule!.substring(32));
            }
            if (appointmentDetails.recurrenceRule!.length == 34) {
              if (isOneDigitMonthDayList.contains(true)) {
                recurrenceRuleEndingText =
                    appointmentDetails.recurrenceRule!.substring(26);
                dropdownInt =
                    int.parse(appointmentDetails.recurrenceRule!.substring(32));
              } else {
                recurrenceRuleEndingText =
                    appointmentDetails.recurrenceRule!.substring(27);
                dropdownInt =
                    int.parse(appointmentDetails.recurrenceRule!.substring(33));
              }
            }
            if (appointmentDetails.recurrenceRule!.length == 35) {
              if (isOneDigitMonthDayList.contains(true)) {
                recurrenceRuleEndingText =
                    appointmentDetails.recurrenceRule!.substring(26);
                dropdownInt =
                    int.parse(appointmentDetails.recurrenceRule!.substring(32));
              } else {
                recurrenceRuleEndingText =
                    appointmentDetails.recurrenceRule!.substring(27);
                dropdownInt =
                    int.parse(appointmentDetails.recurrenceRule!.substring(33));
              }
            }
            if (appointmentDetails.recurrenceRule!.length == 36) {
              recurrenceRuleEndingText =
                  appointmentDetails.recurrenceRule!.substring(27);
              dropdownInt =
                  int.parse(appointmentDetails.recurrenceRule!.substring(33));
            }
          }
        } else {
          recurrenceRuleEndingText = '';
        }
      }
      if (appointmentDetails.location == 'Weekly') {
        recurrenceType = [false, false, true, false];
        if (appointmentDetails.recurrenceRule!.contains('UNTIL')) {
          recurrenceRuleEndDate = DateTime.parse(
              appointmentDetails.recurrenceRule!.substring(27, 42));
          displayRecurrenceRuleEndDate =
              DateFormat('dd  MMMM yyyy').format(recurrenceRuleEndDate!);
          recurrenceRuleEndingText =
              appointmentDetails.recurrenceRule!.substring(21, 42);
        }
        if (appointmentDetails.recurrenceRule!.contains('COUNT')) {
          recurrenceRuleEndingText =
              appointmentDetails.recurrenceRule!.substring(21);
          dropdownInt =
              int.parse(appointmentDetails.recurrenceRule!.substring(27));
        } else {
          recurrenceRuleEndingText = '';
        }

        if (appointmentDetails.startTime.weekday == 1) {
          recurrenceRuleWithoutEndText = 'FREQ=WEEKLY;BYDAY=MO';
        }
        if (appointmentDetails.startTime.weekday == 2) {
          recurrenceRuleWithoutEndText = 'FREQ=WEEKLY;BYDAY=TU';
        }
        if (appointmentDetails.startTime.weekday == 3) {
          recurrenceRuleWithoutEndText = 'FREQ=WEEKLY;BYDAY=WE';
        }
        if (appointmentDetails.startTime.weekday == 4) {
          recurrenceRuleWithoutEndText = 'FREQ=WEEKLY;BYDAY=TH';
        }
        if (appointmentDetails.startTime.weekday == 5) {
          recurrenceRuleWithoutEndText = 'FREQ=WEEKLY;BYDAY=FR';
        }
        if (appointmentDetails.startTime.weekday == 6) {
          recurrenceRuleWithoutEndText = 'FREQ=WEEKLY;BYDAY=SA';
        }
        if (appointmentDetails.startTime.weekday == 7) {
          recurrenceRuleWithoutEndText = 'FREQ=WEEKLY;BYDAY=SU';
        }
      }
      if (appointmentDetails.location == 'Daily') {
        recurrenceType = [false, false, false, true];
        recurrenceRuleWithoutEndText = 'FREQ=DAILY';
        if (appointmentDetails.recurrenceRule!.contains('UNTIL')) {
          recurrenceRuleEndDate = DateTime.parse(
              appointmentDetails.recurrenceRule!.substring(17, 32));
          displayRecurrenceRuleEndDate =
              DateFormat('dd  MMMM yyyy').format(recurrenceRuleEndDate!);
          recurrenceRuleEndingText =
              appointmentDetails.recurrenceRule!.substring(11, 32);
        }
        if (appointmentDetails.recurrenceRule!.contains('COUNT')) {
          dropdownInt =
              int.parse(appointmentDetails.recurrenceRule!.substring(17));
          recurrenceRuleEndingText =
              appointmentDetails.recurrenceRule!.substring(11);
        } else {
          recurrenceRuleEndingText = '';
        }
      }
      showDialog(
          context: context,
          builder: (context) {
            return SimpleDialog(
              title: Text(
                subjectText,
                textAlign: TextAlign.center,
                style: GoogleFonts.marckScript(
                    color: color, fontWeight: FontWeight.w400, fontSize: 28),
              ),
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(32.0))),
              children: [
                Padding(
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
                            minHeight: 70,
                          ),
                          decoration: containerDecoration,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Date:   $dateText', style: textStyle),
                              Text('Time:   $timeDetails', style: textStyle),
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
                              (frequencyText == 'One-time event')
                                  ? frequencyText!
                                  : 'Recurring $frequencyText',
                              style: textStyle),
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
                          child: Text(notesText!, style: textStyle),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: const Text('Close',
                                    style: TextStyle(color: Colors.black))),
                            const VerticalDivider(
                              thickness: 8,
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => EditEventPage(
                                          id: eventId,
                                          color: color,
                                          eventName: subjectText,
                                          eventStartTime: startTime,
                                          eventEndTime: endTime,
                                          isAllDay: isEventAllDay,
                                          isRecurring: isEventRecurring,
                                          dropdownValue: dropdownValueText,
                                          dropdownInt: dropdownInt,
                                          recurrenceRuleEndDate:
                                              recurrenceRuleEndDate,
                                          recurrenceRuleWithoutEnd:
                                              recurrenceRuleWithoutEndText,
                                          recurrenceRuleEndingText:
                                              recurrenceRuleEndingText,
                                          displayRecurrenceRuleEndDate:
                                              displayRecurrenceRuleEndDate,
                                          frequency: frequencyText,
                                          notes: notesText,
                                          recurrenceType: recurrenceType,
                                        )));
                              },
                              child: const Text('Edit',
                                  style: TextStyle(color: Colors.black)),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ],
            );
          });
    }
  }
}

class DataSource extends CalendarDataSource {
  DataSource(List<Appointment> source) {
    appointments = source;
  }
}
