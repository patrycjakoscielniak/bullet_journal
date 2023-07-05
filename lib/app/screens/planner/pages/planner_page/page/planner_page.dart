import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:my_bullet_journal/app/core/global_variables.dart';
import 'package:my_bullet_journal/app/core/injection_container.dart';
import 'package:my_bullet_journal/app/screens/planner/pages/add/page/add_event_page.dart';
import 'package:my_bullet_journal/app/screens/planner/pages/details/page/event_details_page.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import '../../../../../../data/models/event_model.dart';
import '../../../../../../data/models/holidays_model.dart';
import '../cubit/planner_cubit.dart';
import '../features/calendar_data_source.dart';

class PlannerPage extends StatefulWidget {
  const PlannerPage({
    super.key,
  });

  @override
  State<PlannerPage> createState() => _PlannerPageState();
}

class _PlannerPageState extends State<PlannerPage> {
  List<Appointment> appointments = [];
  List<Appointment> holidays = [];
  List<HolidayModel> holidaysList = [];
  List<EventModel> eventsList = [];
  bool displayHolidays = false;
  final SfCalendarDataSource _dataSource =
      SfCalendarDataSource(<Appointment>[]);
  final _controller = CalendarController();
  String eventId = '';

  String? notesText, recurrencePatternWithoutEndText;
  String timeDetails = '',
      displayRecurrenceRuleEndDate = 'Select a date',
      dropdownValueText = 'Never';
  DateTime? recurrenceRuleEndDate;
  bool isEventRecurring = false;
  int dropdownInt = 1;
  List<bool> recurrenceType = [true, false, false, false];

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        return getIt<PlannerCubit>()..start();
      },
      child: BlocBuilder<PlannerCubit, PlannerState>(
        builder: (context, state) {
          eventsList = state.appointments;
          appointments.clear();

          for (final task in eventsList) {
            if (task.recurrenceRule == '') {
              appointments.add(Appointment(
                id: task.id,
                notes: task.notes,
                subject: task.eventName,
                startTime: task.start,
                endTime: task.end,
                isAllDay: task.isAllDay,
                color: Color(task.colorValue),
              ));
            } else {
              appointments.add(Appointment(
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
          _dataSource.appointments?.addAll(appointments);
          _dataSource.notifyListeners(
              CalendarDataSourceAction.reset, _dataSource.appointments!);
          return Scaffold(
            body: Column(
              children: [
                Row(
                  children: [
                    Switch.adaptive(
                      activeColor: Platform.isAndroid
                          ? Colors.white30
                          : const Color.fromARGB(255, 216, 45, 33),
                      activeTrackColor: const Color.fromARGB(255, 216, 45, 33),
                      onChanged: (value) {
                        setState(() {
                          displayHolidays = value;
                          updateAppointments();
                        });
                      },
                      value: displayHolidays,
                    ),
                    const Text('Display Polish National Holidays')
                  ],
                ),
                Expanded(
                  child: SfCalendar(
                    controller: _controller,
                    todayHighlightColor: appGrey,
                    onTap: calendarTapped,
                    onLongPress: calendarLongPressed,
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
                    dataSource: _dataSource,
                    showNavigationArrow: true,
                    showDatePickerButton: true,
                    firstDayOfWeek: 1,
                    headerHeight: 50,
                    allowedViews: const [
                      CalendarView.day,
                      CalendarView.workWeek,
                      CalendarView.month,
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  void updateAppointments() async {
    if (displayHolidays) {
      _dataSource.appointments?.clear();
      holidaysList = await context.read<PlannerCubit>().getHolidays();
      if (holidaysList.isNotEmpty) {
        for (final holiday in holidaysList) {
          holidays.add(Appointment(
            subject: holiday.name,
            startTime: holiday.date,
            endTime: holiday.date,
            isAllDay: true,
            color: const Color.fromARGB(255, 216, 45, 33),
          ));
        }
        _dataSource.appointments?.addAll(holidays);
      }
    } else {
      _dataSource.appointments?.clear();
      holidays.clear();
    }
    _dataSource.notifyListeners(
        CalendarDataSourceAction.reset, _dataSource.appointments!);
  }

  void calendarTapped(
    CalendarTapDetails details,
  ) {
    if (details.targetElement == CalendarElement.appointment ||
        details.targetElement == CalendarElement.agenda) {
      final appointments = details.appointments;
      if (appointments != null && appointments.isNotEmpty) {
        final tappedAppointment = appointments[0];
        final tappedId = tappedAppointment.id.toString();
        if (tappedId.contains(RegExp(r'[A-Za-z]'))) {
          final event =
              eventsList.where((element) => element.id == tappedId).first;
          final eventName = event.eventName;
          eventId = event.id;
          final startTime = event.start, endTime = event.end;
          final colorValue = event.colorValue;
          final recurrenceRule = event.recurrenceRule,
              recurrenceRuleEnding = event.recurrenceRuleEnding;
          final dateText =
                  DateFormat('dd MMMM yyyy').format(startTime).toString(),
              startTimeText =
                  DateFormat('hh:mm a').format(startTime).toString(),
              endTimeText = DateFormat('hh:mm a').format(endTime).toString();
          if (event.isAllDay) {
            timeDetails = 'All day';
          } else {
            timeDetails = '$startTimeText - $endTimeText';
          }
          if (event.notes != '') {
            notesText = event.notes;
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
            if (recurrenceRule.contains('UNTIL')) {
              dropdownValueText = 'On date';
              recurrencePatternWithoutEndText =
                  recurrenceRule.replaceAll('${recurrenceRuleEnding}Z', '');
              recurrenceRuleEndDate = DateTime.parse(
                  recurrenceRuleEnding!.replaceAll('UNTIL=', ''));
              displayRecurrenceRuleEndDate =
                  DateFormat('dd  MMMM yyyy').format(recurrenceRuleEndDate!);
            } else if (recurrenceRule.contains('COUNT')) {
              dropdownValueText = 'After';
              dropdownInt =
                  int.parse(recurrenceRuleEnding!.replaceAll('COUNT=', ''));
              recurrencePatternWithoutEndText =
                  recurrenceRule.replaceAll(recurrenceRuleEnding, '');
            }
          }
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => EventDetailsPage(
                    id: eventId,
                    colorValue: colorValue,
                    eventName: eventName,
                    startTime: startTime,
                    endTime: endTime,
                    isAllDay: event.isAllDay,
                    isRecurring: isEventRecurring,
                    dropdownValue: dropdownValueText,
                    dropdownInt: dropdownInt,
                    recurrencePatternWithoutEnd:
                        recurrencePatternWithoutEndText,
                    displayRecurrenceRuleEndDate: displayRecurrenceRuleEndDate,
                    frequency: event.frequency,
                    notes: notesText,
                    recurrenceType: recurrenceType,
                    recurrenceRuleEnding: recurrenceRuleEnding,
                    dateText: dateText,
                    timeDetails: timeDetails,
                    recurrenceRule: recurrenceRule,
                  )));
        }
      }
    }
  }

  void calendarLongPressed(CalendarLongPressDetails details) {
    if (details.targetElement == CalendarElement.calendarCell) {
      final choosenDate = details.date;
      if (choosenDate != null) {
        final createEventStartTime = choosenDate;
        final createEventEndTime =
            createEventStartTime.add(const Duration(hours: 1));
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => AddEventPage(
                  eventStartTime: createEventStartTime,
                  eventEndTime: createEventEndTime,
                )));
      }
    }
  }
}
