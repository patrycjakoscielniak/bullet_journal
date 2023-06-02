import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_bullet_journal/app/data/planner_remote_data_source.dart';
import 'package:my_bullet_journal/app/screens/planner/cubit/planner_cubit.dart';
import 'package:my_bullet_journal/repositories/planner_repository.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class Planner extends StatefulWidget {
  const Planner({
    super.key,
  });

  @override
  State<Planner> createState() => _PlannerState();
}

class _PlannerState extends State<Planner> {
  List<Appointment> appointments = [];
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PlannerCubit(
          PlannerRepository(remoteDataSource: HolidaysRemoteDioDataSource()))
        ..start(),
      child: BlocBuilder<PlannerCubit, PlannerState>(
        builder: (context, state) {
          for (final model in state.holidaysResults) {
            appointments.add(Appointment(
                subject: model.eventName,
                startTime: model.start,
                endTime: model.end,
                color: Colors.blueGrey,
                isAllDay: true));
          }
          return Scaffold(
            body: SfCalendar(
              viewNavigationMode: ViewNavigationMode.snap,
              view: CalendarView.month,
              monthViewSettings: const MonthViewSettings(
                showAgenda: true,
              ),
              dataSource: DataSource(appointments),
              showNavigationArrow: true,
              showDatePickerButton: true,
              firstDayOfWeek: 1,
              headerHeight: 50,
              allowedViews: const [
                CalendarView.day,
                CalendarView.workWeek,
                CalendarView.month,
                CalendarView.schedule,
              ],
              onLongPress: (calendarLongPressDetails) {
                //add event
              },
            ),
          );
        },
      ),
    );
  }
}

class DataSource extends CalendarDataSource {
  DataSource(List<Appointment> source) {
    appointments = source;
  }
}
