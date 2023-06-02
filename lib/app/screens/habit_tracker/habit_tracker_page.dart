import 'package:flutter/material.dart';
import 'package:flutter_event_calendar/flutter_event_calendar.dart';

class HabitTracker extends StatefulWidget {
  const HabitTracker({
    super.key,
  });

  @override
  State<HabitTracker> createState() => _HabitTrackerState();
}

class _HabitTrackerState extends State<HabitTracker> {
  final gregType = CalendarType.GREGORIAN;
  final done = const Icon(Icons.check_box_outlined);
  final undone = const Icon(Icons.check_box_outline_blank);
  bool isSelected = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: EventCalendar(
        calendarType: gregType,
        headerOptions: HeaderOptions(
          weekDayStringType: WeekDayStringTypes.FULL,
        ),
        dayOptions: DayOptions(
            weekDaySelectedColor: Colors.cyan,
            eventCounterColor: const Color.fromARGB(255, 160, 117, 217)),
        eventOptions: EventOptions(),
        calendarOptions: CalendarOptions(
          toggleViewType: true,
        ),
        events: [
          Event(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        height: 50,
                        decoration: const BoxDecoration(
                            color: Colors.cyan,
                            borderRadius:
                                BorderRadius.all(Radius.circular(30))),
                        child: const Center(
                            child: Text(
                          'Picie wody',
                          style: TextStyle(color: Colors.white),
                        )),
                      ),
                    ),
                    SizedBox(
                      height: 50,
                      width: 55,
                      child: Center(
                          child: IconButton(
                        onPressed: () {
                          setState(() {});
                        },
                        icon: undone,
                      )),
                    ),
                  ],
                ),
              ),
              dateTime: CalendarDateTime(
                  year: 2023, month: 5, day: 25, calendarType: gregType)),
          Event(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        height: 50,
                        decoration: const BoxDecoration(
                            color: Colors.cyan,
                            borderRadius:
                                BorderRadius.all(Radius.circular(30))),
                        child: const Center(
                            child: Text(
                          'Krem z filtrem',
                          style: TextStyle(color: Colors.white),
                        )),
                      ),
                    ),
                    SizedBox(
                        height: 50,
                        width: 55,
                        child: Center(
                            child: IconButton(
                          onPressed: () {
                            if (isSelected) {
                              setState(() {
                                isSelected = false;
                              });
                            } else {
                              setState(() {
                                isSelected = true;
                              });
                            }
                          },
                          isSelected: isSelected,
                          selectedIcon: done,
                          icon: undone,
                        )))
                  ],
                ),
              ),
              dateTime: CalendarDateTime(
                  year: 2023,
                  month: 5,
                  day: 25,
                  hour: 12,
                  calendarType: gregType))
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color.fromARGB(255, 160, 117, 217),
        foregroundColor: Colors.white,
        mini: true,
        onPressed: () {},
        child: const Icon(Icons.add),
      ),
    );
  }
}
