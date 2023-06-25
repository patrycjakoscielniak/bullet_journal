import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:my_bullet_journal/app/data/planner_remote_data_source.dart';
import 'package:my_bullet_journal/app/screens/planner/pages/edit/edit_page.dart';
import 'package:my_bullet_journal/app/screens/planner/variables/variables.dart';
import 'package:my_bullet_journal/models/planner_item_model.dart';
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
  List<PlannerModel> plannerEvents = [];
  String eventId = '';
  final CalendarController _controller = CalendarController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PlannerCubit(
          PlannerRepository(remoteDataSource: HolidaysRemoteDioDataSource()))
        ..start(),
      child: BlocBuilder<PlannerCubit, PlannerState>(
        builder: (context, state) {
          plannerEvents = state.appointments;
          events.clear();

          for (final task in plannerEvents) {
            if (task.recurrenceRule == '') {
              events.add(Appointment(
                id: task.id,
                notes: task.notes,
                subject: task.eventName,
                startTime: task.start,
                endTime: task.end,
                isAllDay: task.isAllDay,
                color: Color(task.colorValue),
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
              controller: _controller,
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
              appointmentBuilder:
                  (context, CalendarAppointmentDetails details) {
                final event = details.appointments.first;

                if (details.isMoreAppointmentRegion) {
                  return SizedBox(
                    width: details.bounds.width,
                    height: details.bounds.height,
                    child: Text(
                      '+More',
                      style: appointmentTextStyle,
                    ),
                  );
                } else if (_controller.view == CalendarView.month) {
                  return Container(
                      padding: const EdgeInsets.only(left: 5),
                      decoration: BoxDecoration(
                        color: event.color,
                        shape: BoxShape.rectangle,
                        borderRadius: const BorderRadius.all(
                          Radius.circular(5),
                        ),
                      ),
                      alignment: Alignment.centerLeft,
                      child: event.isAllDay
                          ? Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('${event.subject}',
                                    textAlign: TextAlign.start,
                                    style: appointmentTextStyle),
                                deleteEvent(context)
                              ],
                            )
                          : Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(top: 3),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text('${event.subject}',
                                          style: appointmentTextStyle),
                                      Text(
                                          '${DateFormat('hh:mm a').format(event.startTime)} - ${DateFormat('hh:mm a').format(event.endTime)}',
                                          style: appointmentTextStyle)
                                    ],
                                  ),
                                ),
                                deleteEvent(context)
                              ],
                            ));
                } else {
                  return Container(
                    decoration: BoxDecoration(
                      color: event.color,
                      shape: BoxShape.rectangle,
                      borderRadius: const BorderRadius.all(
                        Radius.circular(3),
                      ),
                    ),
                    width: details.bounds.width,
                    height: details.bounds.height,
                    child: event.isAllDay
                        ? Padding(
                            padding: const EdgeInsets.only(left: 5),
                            child: Text(
                              event.subject,
                              style: appointmentTextStyle,
                            ),
                          )
                        : Padding(
                            padding: const EdgeInsets.only(left: 5, top: 2),
                            child: Text(
                              event.subject,
                              style: appointmentTextStyle,
                            ),
                          ),
                  );
                }
              },
            ),
          );
        },
      ),
    );
  }

  void calendarTapped(CalendarTapDetails details) {
    if (details.targetElement == CalendarElement.appointment ||
        details.targetElement == CalendarElement.agenda) {
      final tappedAppointment = details.appointments![0];
      final tappedId = tappedAppointment.id.toString();
      final event =
          plannerEvents.where((element) => element.id == tappedId).first;
      final eventName = event.eventName;
      eventId = event.id;
      final startTime = event.start, endTime = event.end;
      final colorValue = event.colorValue;
      final recurrenceRule = event.recurrenceRule,
          recurrenceRuleEnding = event.recurrenceRuleEnding;
      final color = Color(colorValue);
      String? notesText;
      String timeDetails = '',
          recurrenceRuleWithoutEndText = '',
          displayRecurrenceRuleEndDate = 'Select a date',
          dropdownValueText = 'Never';
      DateTime? recurrenceRuleEndDate;
      bool isEventRecurring = false;
      int dropdownInt = 1;
      List<bool> recurrenceType = [true, false, false, false];
      final dateText = DateFormat('dd MMMM yyyy').format(startTime).toString(),
          startTimeText = DateFormat('hh:mm a').format(startTime).toString(),
          endTimeText = DateFormat('hh:mm a').format(endTime).toString();
      if (event.isAllDay) {
        timeDetails = 'All day';
      } else {
        timeDetails = '$startTimeText - $endTimeText';
      }
      if (event.notes != '') {
        notesText = event.notes;
      }
      if (event.recurrenceRule != null &&
          event.recurrenceRule!.contains('UNTIL')) {
        dropdownValueText = 'On date';
        recurrenceRuleWithoutEndText =
            recurrenceRule!.replaceAll('${recurrenceRuleEnding}Z', '');
        recurrenceRuleEndDate =
            DateTime.parse(recurrenceRuleEnding!.replaceAll('UNTIL=', ''));
        displayRecurrenceRuleEndDate =
            DateFormat('dd  MMMM yyyy').format(recurrenceRuleEndDate);
      } else if (event.recurrenceRule != null &&
          event.recurrenceRule!.contains('COUNT')) {
        dropdownValueText = 'After';
        dropdownInt = int.parse(recurrenceRuleEnding!.replaceAll('COUNT=', ''));
        recurrenceRuleWithoutEndText =
            recurrenceRule!.replaceAll(recurrenceRuleEnding, '');
      }
      if (recurrenceRule != null && recurrenceRule != '') {
        isEventRecurring = true;
        if (recurrenceRule.contains('MONTHLY')) {
          recurrenceType = [false, true, false, false];
        } else if (recurrenceRule.contains('WEEKLY')) {
          recurrenceType = [false, false, true, false];
        } else if (recurrenceRule.contains('DAILY')) {
          recurrenceType = [false, false, false, true];
        }
      }

      print(recurrenceType);
      showDialog(
          context: context,
          builder: (context) {
            return SimpleDialog(
              title: Text(
                eventName,
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
                              Text('Start Date:   $dateText', style: textStyle),
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
                              (recurrenceRule == null || recurrenceRule == '')
                                  ? 'One-time event'
                                  : 'Recurring ${event.frequency}',
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
                          child: Text(
                              (notesText != null) ? notesText : 'No notes',
                              style: textStyle),
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
                                          colorValue: colorValue,
                                          eventName: eventName,
                                          eventStartTime: startTime,
                                          eventEndTime: endTime,
                                          isAllDay: event.isAllDay,
                                          isRecurring: isEventRecurring,
                                          dropdownValue: dropdownValueText,
                                          dropdownInt: dropdownInt,
                                          recurrenceRuleWithoutEnd:
                                              recurrenceRuleWithoutEndText,
                                          displayRecurrenceRuleEndDate:
                                              displayRecurrenceRuleEndDate,
                                          frequency: event.frequency,
                                          notes: notesText,
                                          recurrenceType: recurrenceType,
                                          recurrenceRuleEnding:
                                              recurrenceRuleEnding,
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

  IconButton deleteEvent(BuildContext context) {
    return IconButton(
        onPressed: () {
          showDialog(
              context: context,
              builder: (context) {
                return FractionallySizedBox(
                  widthFactor: 0.9,
                  child: Material(
                    type: MaterialType.transparency,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(15),
                          decoration: dialogContainerDecoration,
                          child: Column(
                            children: [
                              Text(
                                'Delete this Event?',
                                style: textStyle,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: const Text('Close'),
                                  ),
                                  TextButton(
                                      onPressed: () {
                                        context
                                            .read<PlannerCubit>()
                                            .deleteEvent(
                                                documentID: eventId.toString());
                                        Navigator.of(context).pop();
                                      },
                                      child: const Text('Delete'))
                                ],
                              )
                            ],
                          ),
                        ),
                        const SizedBox(height: 60)
                      ],
                    ),
                  ),
                );
              });
        },
        color: Colors.white,
        icon: const Icon(
          Icons.delete_outline,
        ));
  }
}

class DataSource extends CalendarDataSource {
  DataSource(List<Appointment> source) {
    appointments = source;
  }
}
