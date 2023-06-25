import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:my_bullet_journal/app/data/planner_remote_data_source.dart';
import 'package:my_bullet_journal/app/screens/planner/pages/details/page/event_details_page.dart';
import 'package:my_bullet_journal/models/planner_item_model.dart';
import 'package:my_bullet_journal/repositories/planner_repository.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import '../../add/page/add_event.dart';
import '../cubit/planner_cubit.dart';

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
      String? notesText;
      String timeDetails,
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
          recurrenceRuleWithoutEndText =
              recurrenceRule.replaceAll('${recurrenceRuleEnding}Z', '');
          recurrenceRuleEndDate =
              DateTime.parse(recurrenceRuleEnding!.replaceAll('UNTIL=', ''));
          displayRecurrenceRuleEndDate =
              DateFormat('dd  MMMM yyyy').format(recurrenceRuleEndDate);
        } else if (recurrenceRule.contains('COUNT')) {
          dropdownValueText = 'After';
          dropdownInt =
              int.parse(recurrenceRuleEnding!.replaceAll('COUNT=', ''));
          recurrenceRuleWithoutEndText =
              recurrenceRule.replaceAll(recurrenceRuleEnding, '');
        }
      }
      Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => EventDetails(
                id: eventId,
                colorValue: colorValue,
                eventName: eventName,
                startTime: startTime,
                endTime: endTime,
                isAllDay: event.isAllDay,
                isRecurring: isEventRecurring,
                dropdownValue: dropdownValueText,
                dropdownInt: dropdownInt,
                recurrenceRuleWithoutEnd: recurrenceRuleWithoutEndText,
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

class DataSource extends CalendarDataSource {
  DataSource(List<Appointment> source) {
    appointments = source;
  }
}
