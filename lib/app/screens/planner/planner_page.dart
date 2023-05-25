import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class Planner extends StatefulWidget {
  const Planner({
    super.key,
  });

  @override
  State<Planner> createState() => _PlannerState();
}

class _PlannerState extends State<Planner> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SfCalendar(
        view: CalendarView.month,
        monthViewSettings: const MonthViewSettings(showAgenda: true),
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
  }
}
