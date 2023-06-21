import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:my_bullet_journal/app/data/planner_remote_data_source.dart';
import 'package:my_bullet_journal/repositories/planner_repository.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import '../add/add_event.dart';
import '../details/details_page.dart';
import 'cubit/planner_cubit.dart';

class Planner extends StatefulWidget {
  const Planner({
    super.key,
  });

  @override
  State<Planner> createState() => _PlannerState();
}

class _PlannerState extends State<Planner> {
  final textStyle = GoogleFonts.amaticSc();
  List<Appointment> events = [];
  String? subjectText = '',
      startTimeText = '',
      endTimeText = '',
      dateText = '',
      timeDetails = '',
      notes = '';

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
                notes: task.notes,
                subject: task.eventName,
                startTime: task.start,
                endTime: task.end,
                isAllDay: task.isAllDay,
                color: Color(task.colorValue),
              ));
            } else {
              events.add(Appointment(
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
      dateText = DateFormat('dd MMMM yyyy')
          .format(appointmentDetails.startTime)
          .toString();
      startTimeText =
          DateFormat('hh:mm a').format(appointmentDetails.startTime).toString();
      endTimeText =
          DateFormat('hh:mm a').format(appointmentDetails.endTime).toString();
      if (appointmentDetails.isAllDay) {
        timeDetails = 'All day';
      } else {
        timeDetails = '$startTimeText - $endTimeText';
      }
      if (appointmentDetails.notes != '') {
        notes = appointmentDetails.notes;
      } else {
        notes = 'No notes';
      }
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => DetailsPage(
                    subjectText: subjectText!,
                    startTimeText: startTimeText!,
                    endTimeText: endTimeText!,
                    dateText: dateText!,
                    timeDetails: timeDetails!,
                    notes: notes!,
                  )));
    }
  }
}

class DataSource extends CalendarDataSource {
  DataSource(List<Appointment> source) {
    appointments = source;
  }
}
