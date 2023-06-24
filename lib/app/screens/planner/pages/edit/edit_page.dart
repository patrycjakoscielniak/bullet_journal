import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart';
import 'package:intl/intl.dart';
import 'package:my_bullet_journal/app/core/enums.dart';
import 'package:my_bullet_journal/app/data/planner_remote_data_source.dart';
import 'package:my_bullet_journal/app/screens/planner/pages/edit/cubit/edit_event_cubit.dart';
import 'package:my_bullet_journal/app/screens/planner/pages/planner_page/planner_page.dart';
import 'package:my_bullet_journal/repositories/planner_repository.dart';
import 'package:omni_datetime_picker/omni_datetime_picker.dart';

import '../../variables/variables.dart';

class EditEventPage extends StatefulWidget {
  EditEventPage({
    super.key,
    required this.eventName,
    required this.color,
    required this.id,
    required this.dropdownValue,
    required this.recurrenceRuleWithoutEnd,
    required this.recurrenceRuleEndingText,
    required this.displayRecurrenceRuleEndDate,
    required this.frequency,
    required this.dropdownInt,
    required this.eventStartTime,
    required this.eventEndTime,
    required this.recurrenceRuleEndDate,
    required this.isAllDay,
    required this.isRecurring,
    required this.recurrenceType,
    required this.notes,
  });

  final String eventName;
  String id,
      dropdownValue,
      recurrenceRuleWithoutEnd,
      recurrenceRuleEndingText,
      displayRecurrenceRuleEndDate;

  int dropdownInt;
  Color color;
  DateTime eventStartTime, eventEndTime;
  DateTime? recurrenceRuleEndDate;
  bool isAllDay, isRecurring;
  List<bool> recurrenceType;
  String? notes, frequency;

  @override
  State<EditEventPage> createState() => _EditEventPageState();
}

class _EditEventPageState extends State<EditEventPage> {
  final space = const SizedBox(height: 15);
  List<int> intDropdownList = [for (int i = 1; i <= 100; i++) i];
  String? recurrenceRule;

  @override
  Widget build(BuildContext context) {
    final colorValue = widget.color.value;
    return BlocProvider(
      create: (context) => EditEventCubit(
          PlannerRepository(remoteDataSource: HolidaysRemoteDioDataSource())),
      child: BlocConsumer<EditEventCubit, EditEventState>(
        listener: (context, state) {
          if (state.status == Status.updated) {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => const Planner()));
          }
          if (state.status == Status.error) {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(state.errorMessage!)));
          }
        },
        builder: (context, state) {
          return Scaffold(
            body: Padding(
              padding: const EdgeInsets.only(
                right: 50,
                left: 50,
                top: 80,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                          child: TextField(
                        textAlign: TextAlign.center,
                        decoration: InputDecoration(
                          hintText: widget.eventName,
                        ),
                        readOnly: true,
                      )),
                      editColor()
                    ],
                  ),
                  space,
                  isEventAllDay(),
                  space,
                  editEventDateTime(context),
                  space,
                  isEventRecurring(),
                  space,
                  widget.isRecurring ? editRecurrenceRule(context) : space,
                  editNotes(),
                ],
              ),
            ),
            bottomSheet: Padding(
              padding: const EdgeInsets.only(bottom: 30, right: 15, left: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const Planner()));
                    },
                    child: const Text('Close'),
                  ),
                  TextButton(
                    onPressed: () {
                      context.read<EditEventCubit>().updateEvent(
                            id: widget.id,
                            eventName: widget.eventName,
                            notes: widget.notes,
                            recurrenceRule: (widget.recurrenceRuleWithoutEnd !=
                                    '')
                                ? '${widget.recurrenceRuleWithoutEnd};${widget.recurrenceRuleEndingText}'
                                : recurrenceRule =
                                    widget.recurrenceRuleWithoutEnd,
                            frequency: widget.frequency,
                            startTime: widget.eventStartTime,
                            endTime: widget.eventEndTime,
                            isAllDay: widget.isAllDay,
                            colorValue: colorValue,
                          );
                    },
                    child: const Text(
                      'Save Changes',
                    ),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  IconButton editColor() {
    return IconButton(
      onPressed: () {},
      icon: const Icon(Icons.color_lens),
      color: widget.color,
    );
  }

  Row isEventAllDay() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Text(
          'AllDay',
          style: textStyle,
        ),
        Switch.adaptive(
            value: widget.isAllDay,
            onChanged: (value) {
              setState(() {
                widget.isAllDay = value;
              });
            })
      ],
    );
  }

  ElevatedButton editEventDateTime(BuildContext context) {
    return ElevatedButton(
      style: buttonStyle,
      onPressed: () async {
        List<DateTime>? dateTimeList = await showOmniDateTimeRangePicker(
          context: context,
          isForce2Digits: true,
          startInitialDate: DateTime.now(),
          startFirstDate: DateTime(1600).subtract(const Duration(days: 3652)),
          startLastDate: DateTime.now().add(
            const Duration(days: 3652),
          ),
          endInitialDate: DateTime.now(),
          endFirstDate: DateTime(1600).subtract(const Duration(days: 3652)),
          endLastDate: DateTime.now().add(
            const Duration(days: 3652),
          ),
          borderRadius: BorderRadius.circular(15),
        );
        if (dateTimeList != null) {
          setState(() {
            widget.eventStartTime = dateTimeList.first;
          });
          setState(() {
            widget.eventEndTime = dateTimeList.last;
          });
        }
      },
      child: Text(
          'from ${DateFormat('dd MMM hh : mm').format(widget.eventStartTime)}  to  ${DateFormat('dd MMM hh : mm').format(widget.eventEndTime)}',
          style: textStyle),
    );
  }

  Row isEventRecurring() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Text(
          'Repeat',
          style: textStyle,
          textAlign: TextAlign.center,
        ),
        Switch.adaptive(
            value: widget.isRecurring,
            onChanged: (value) {
              setState(() {
                widget.isRecurring = value;
              });
              if (value == true) {
                setState(() {
                  widget.recurrenceRuleWithoutEnd =
                      'FREQ=YEARLY;BYMONTH=${DateFormat('M').format(widget.eventStartTime)};BYMONTHDAY=${DateFormat('d').format(widget.eventStartTime)}';
                  widget.frequency = 'Yearly';
                });
              } else {
                setState(() {
                  widget.recurrenceRuleWithoutEnd = '';
                  widget.frequency = '';
                });
              }
            })
      ],
    );
  }

  Column editRecurrenceRule(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 15, bottom: 15),
          child: ToggleButtons(
            selectedColor: Colors.white,
            fillColor: appPurple,
            borderColor: Colors.blueGrey,
            color: Colors.black,
            constraints: const BoxConstraints(minWidth: 67, minHeight: 40),
            onPressed: (newIndex) {
              setState(() {
                for (int index = 0;
                    index < widget.recurrenceType.length;
                    index++) {
                  if (index == newIndex) {
                    widget.recurrenceType[index] = true;
                  } else {
                    widget.recurrenceType[index] = false;
                  }
                }
              });
              if (widget.recurrenceType.elementAt(0) == true) {
                setState(() {
                  widget.recurrenceRuleWithoutEnd =
                      'FREQ=YEARLY;BYMONTH=${DateFormat('M').format(widget.eventStartTime)};BYMONTHDAY=${DateFormat('d').format(widget.eventStartTime)}';
                  widget.frequency = 'Yearly';
                });
              }
              if (widget.recurrenceType.elementAt(1) == true) {
                setState(() {
                  widget.frequency = 'Monthly';
                  widget.recurrenceRuleWithoutEnd =
                      'FREQ=MONTHLY;BYMONTHDAY=${DateFormat('d').format(widget.eventStartTime)}';
                });
              }
              if (widget.recurrenceType.elementAt(2) == true &&
                  widget.eventStartTime.weekday == 1) {
                setState(() {
                  widget.frequency = 'Weekly';
                  widget.recurrenceRuleWithoutEnd = 'FREQ=WEEKLY;BYDAY=MO';
                });
              }
              if (widget.recurrenceType.elementAt(2) == true &&
                  widget.eventStartTime.weekday == 2) {
                setState(() {
                  widget.frequency = 'Weekly';
                  widget.recurrenceRuleWithoutEnd = 'FREQ=WEEKLY;BYDAY=TU';
                });
              }
              if (widget.recurrenceType.elementAt(2) == true &&
                  widget.eventStartTime.weekday == 3) {
                setState(() {
                  widget.frequency = 'Weekly';
                  widget.recurrenceRuleWithoutEnd = 'FREQ=WEEKLY;BYDAY=WE';
                });
              }
              if (widget.recurrenceType.elementAt(2) == true &&
                  widget.eventStartTime.weekday == 4) {
                setState(() {
                  widget.frequency = 'Weekly';
                  widget.recurrenceRuleWithoutEnd = 'FREQ=WEEKLY;BYDAY=TH';
                });
              }
              if (widget.recurrenceType.elementAt(2) == true &&
                  widget.eventStartTime.weekday == 5) {
                setState(() {
                  widget.frequency = 'Weekly';
                  widget.recurrenceRuleWithoutEnd = 'FREQ=WEEKLY;BYDAY=FR';
                });
              }
              if (widget.recurrenceType.elementAt(2) == true &&
                  widget.eventStartTime.weekday == 6) {
                setState(() {
                  widget.frequency = 'Weekly';
                  widget.recurrenceRuleWithoutEnd = 'FREQ=WEEKLY;BYDAY=SA';
                });
              }
              if (widget.recurrenceType.elementAt(2) == true &&
                  widget.eventStartTime.weekday == 7) {
                setState(() {
                  widget.frequency = 'Weekly';
                  widget.recurrenceRuleWithoutEnd = 'FREQ=WEEKLY;BYDAY=SU';
                });
              }
              if (widget.recurrenceType.elementAt(3) == true) {
                setState(() {
                  widget.frequency = 'Daily';
                  widget.recurrenceRuleWithoutEnd = 'FREQ=DAILY';
                });
              }
            },
            isSelected: widget.recurrenceType,
            children: [
              Text('Yearly', style: textStyle),
              Text('Monthly', style: textStyle),
              Text('Weekly', style: textStyle),
              Text('Daily', style: textStyle)
            ],
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text(
              'End',
              style: textStyle,
            ),
            DropdownButton(
              value: widget.dropdownValue,
              items: <String>['Never', 'After', 'On date']
                  .map<DropdownMenuItem<String>>((value) {
                return DropdownMenuItem<String>(
                    value: value,
                    child: Text(
                      value,
                      style: textStyle,
                    ));
              }).toList(),
              onChanged: (value) {
                if (value != null) {
                  setState(() {
                    widget.dropdownValue = value;
                  });
                  if (value == 'Never') {
                    setState(() {
                      widget.recurrenceRuleEndingText = '';
                    });
                  }
                }
              },
            ),
          ],
        ),
        widget.dropdownValue == 'After'
            ? Padding(
                padding: const EdgeInsets.only(top: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    DropdownButton<int>(
                        value: widget.dropdownInt,
                        items: intDropdownList.map((int intValue) {
                          return DropdownMenuItem<int>(
                            value: intValue,
                            child: Text(intValue.toString()),
                          );
                        }).toList(),
                        onChanged: (intValue) {
                          if (intValue != null) {
                            setState(() {
                              widget.dropdownInt = intValue;
                              widget.recurrenceRuleEndingText =
                                  'COUNT=$intValue';
                            });
                          }
                        }),
                    Text('Times', style: textStyle)
                  ],
                ),
              )
            : widget.dropdownValue == 'On date'
                ? ElevatedButton(
                    style: buttonStyle,
                    onPressed: () {
                      DatePicker.showDatePicker(
                        context,
                        onConfirm: (time) {
                          setState(() {
                            widget.displayRecurrenceRuleEndDate =
                                DateFormat('dd  MMMM yyyy').format(time);
                            widget.recurrenceRuleEndingText =
                                'UNTIL=${DateFormat('yyyyMMddTHHmmss').format(time)}Z';
                          });
                        },
                      );
                    },
                    child: Text(
                      widget.displayRecurrenceRuleEndDate,
                      style: textStyle,
                    ))
                : empty
      ],
    );
  }

  TextField editNotes() {
    return TextField(
      onChanged: (value) {
        setState(() {
          widget.notes = value;
        });
      },
      textAlign: TextAlign.center,
      decoration: InputDecoration(
          hintText: (widget.notes != '') ? widget.notes : 'Add notes'),
    );
  }
}
