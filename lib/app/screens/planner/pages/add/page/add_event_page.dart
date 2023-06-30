// ignore_for_file: must_be_immutable

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart';
import 'package:intl/intl.dart';
import 'package:my_bullet_journal/app/app.dart';
import 'package:my_bullet_journal/app/core/enums.dart';
import 'package:my_bullet_journal/app/screens/planner/pages/add/cubit/add_event_cubit.dart';
import 'package:omni_datetime_picker/omni_datetime_picker.dart';
import '../../../../../core/global_variables.dart';
import '../../../variables/planner_variables.dart';

class AddEventPage extends StatefulWidget {
  AddEventPage({
    super.key,
    required this.eventStartTime,
    required this.eventEndTime,
  });

  DateTime eventStartTime, eventEndTime;

  @override
  State<AddEventPage> createState() => _AddEventState();
}

class _AddEventState extends State<AddEventPage> {
  String eventName = '',
      displayRecurrenceRuleEndDate = 'Select a date',
      dropdownValue = 'Never';

  String? recurrencePattenWithoutEnd,
      recurrencePattenEnd,
      recurrenceRuleEnding,
      recurrenceRule,
      frequency,
      notes;
  int colorValue = appPurple.value, intDropdownValue = 1;
  Color pickerColor = appPurple;
  bool isRecurring = false, isAllDay = false;
  List<bool> isSelected = [true, false, false, false];

  @override
  Widget build(BuildContext context) {
    final recurrenceRulePattern = [
      {
        'frequency': 'Yearly',
        'rule':
            'FREQ=YEARLY;BYMONTH=${DateFormat('M').format(widget.eventStartTime)};BYMONTHDAY=${DateFormat('d').format(widget.eventStartTime)}'
      },
      {
        'frequency': 'Monthly',
        'rule':
            'FREQ=MONTHLY;BYMONTHDAY=${DateFormat('d').format(widget.eventStartTime)}'
      },
      {},
      {'frequency': 'Daily', 'rule': 'FREQ=DAILY'},
    ];
    return BlocConsumer<AddEventCubit, AddEventState>(
      listener: (context, state) {
        if (state.status == Status.saved) {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => const MyApp()));
        }
        if (state.status == Status.error) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(state.errorMessage!),
            duration: const Duration(seconds: 7),
          ));
        }
      },
      builder: (context, state) {
        return Scaffold(
          body: Padding(
            padding: const EdgeInsets.only(right: 50, left: 50, top: 80),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(
                  children: [
                    addEventName(),
                    chooseEventColor(context),
                  ],
                ),
                space,
                isEventAllDay(),
                space,
                isAllDay ? space : pickEventDate(context),
                isEventisRecurringing(recurrenceRulePattern),
                isRecurring
                    ? setRecurrencePattern(context, recurrenceRulePattern)
                    : space,
                addNotes(),
              ],
            ),
          ),
          bottomSheet: Padding(
            padding: const EdgeInsets.only(bottom: 30, right: 15, left: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [ClosePage(colorValue: colorValue), addEvent(context)],
            ),
          ),
        );
      },
    );
  }

  Expanded addEventName() {
    return Expanded(
      child: TextField(
        onChanged: (value) {
          setState(() {
            eventName = value;
          });
        },
        textAlign: TextAlign.center,
        decoration: const InputDecoration(hintText: 'New Event'),
      ),
    );
  }

  IconButton chooseEventColor(BuildContext context) {
    return IconButton(
      onPressed: () {
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                content: SingleChildScrollView(
                  child: ColorPicker(
                    paletteType: PaletteType.hslWithSaturation,
                    pickerColor: pickerColor,
                    onColorChanged: (color) {
                      setState(() {
                        colorValue = color.value;
                      });
                    },
                  ),
                ),
                actions: <Widget>[
                  TextButton(
                    onPressed: () {
                      setState(() {
                        pickerColor = Color(colorValue);
                      });
                      Navigator.of(context).pop();
                    },
                    child: const Text('Save'),
                  )
                ],
              );
            });
      },
      icon: Icon(
        Icons.color_lens,
        color: pickerColor,
      ),
    );
  }

  Row isEventAllDay() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Text(
          'AllDay',
          style: mainTextStyle,
        ),
        Switch.adaptive(
            activeColor:
                Platform.isAndroid ? Colors.white30 : Color(colorValue),
            activeTrackColor: Color(colorValue),
            value: isAllDay,
            onChanged: (value) {
              setState(() {
                isAllDay = value;
              });
            })
      ],
    );
  }

  Column pickEventDate(BuildContext context) {
    return Column(
      children: [
        ElevatedButton(
            style: elevatedButtonStyle,
            onPressed: () async {
              List<DateTime>? dateTimeList = await showOmniDateTimeRangePicker(
                context: context,
                isForce2Digits: true,
                startInitialDate: widget.eventStartTime,
                startFirstDate: DateTime(1900),
                startLastDate: DateTime.now().add(
                  const Duration(days: 3652),
                ),
                endInitialDate: widget.eventEndTime,
                endFirstDate: DateTime(1900),
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
                style: mainTextStyle)),
        space,
      ],
    );
  }

  Row isEventisRecurringing(recurrenceRulePattern) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Text(
          'isRecurring',
          style: mainTextStyle,
          textAlign: TextAlign.center,
        ),
        Switch.adaptive(
            activeColor:
                Platform.isAndroid ? Colors.white30 : Color(colorValue),
            activeTrackColor: Color(colorValue),
            value: isRecurring,
            onChanged: (value) {
              setState(() {
                isRecurring = value;
              });
              if (value == true) {
                setState(() {
                  recurrencePattenWithoutEnd = recurrenceRulePattern[1]['rule'];
                  frequency = recurrenceRulePattern[1]['frequency'];
                });
              } else {
                setState(() {
                  recurrencePattenWithoutEnd = '';
                  frequency = '';
                });
              }
            })
      ],
    );
  }

  Column setRecurrencePattern(BuildContext context, recurrenceRulePattern) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 15, bottom: 15),
          child: ToggleButtons(
            selectedColor: Colors.white,
            fillColor: Color(colorValue),
            borderColor: Colors.blueGrey,
            color: Colors.black,
            constraints: const BoxConstraints(minWidth: 67, minHeight: 40),
            onPressed: (newIndex) {
              setState(() {
                for (int index = 0; index < isSelected.length; index++) {
                  if (index == newIndex) {
                    isSelected[index] = true;
                  } else {
                    isSelected[index] = false;
                  }
                }
                if (newIndex == 2) {
                  frequency = 'Weekly';
                  for (int i = 1; i < byWeekDayValue.length; i++) {
                    if (widget.eventStartTime.weekday == i) {
                      setState(() {
                        recurrencePattenWithoutEnd = byWeekDayValue[i];
                      });
                    }
                  }
                } else {
                  setState(() {
                    recurrencePattenWithoutEnd =
                        recurrenceRulePattern[newIndex]['rule'];
                    frequency = recurrenceRulePattern[newIndex]['frequency'];
                  });
                }
              });
            },
            isSelected: isSelected,
            children: [
              Text('Yearly', style: mainTextStyle),
              Text('Monthly', style: mainTextStyle),
              Text('Weekly', style: mainTextStyle),
              Text('Daily', style: mainTextStyle)
            ],
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text(
              'End',
              style: mainTextStyle,
            ),
            DropdownButton(
              value: dropdownValue,
              items: <String>['Never', 'After', 'On date']
                  .map<DropdownMenuItem<String>>((value) {
                return DropdownMenuItem<String>(
                    value: value,
                    child: Text(
                      value,
                      style: mainTextStyle,
                    ));
              }).toList(),
              onChanged: (value) {
                if (value != null) {
                  setState(() {
                    dropdownValue = value;
                  });
                }
              },
            ),
          ],
        ),
        dropdownValue == 'After'
            ? Padding(
                padding: const EdgeInsets.only(top: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    DropdownButton<int>(
                        value: intDropdownValue,
                        items: intDropdownList.map((int value) {
                          return DropdownMenuItem<int>(
                            value: value,
                            child: Text(value.toString()),
                          );
                        }).toList(),
                        onChanged: (value) {
                          if (value != null) {
                            setState(() {
                              intDropdownValue = value;
                              recurrencePattenEnd = 'COUNT=$value';
                              recurrenceRuleEnding = recurrencePattenEnd;
                            });
                          }
                        }),
                    Text('Times', style: mainTextStyle)
                  ],
                ),
              )
            : dropdownValue == 'On date'
                ? ElevatedButton(
                    style: elevatedButtonStyle,
                    onPressed: () {
                      DatePicker.showDatePicker(
                        context,
                        onConfirm: (time) {
                          setState(() {
                            displayRecurrenceRuleEndDate =
                                DateFormat('dd  MMMM yyyy').format(time);
                            recurrenceRuleEnding =
                                'UNTIL=${DateFormat('yyyyMMddTHHmmss').format(time)}';
                            recurrencePattenEnd = '${recurrenceRuleEnding}Z';
                          });
                        },
                      );
                    },
                    child: Text(
                      displayRecurrenceRuleEndDate,
                      style: mainTextStyle,
                    ))
                : empty
      ],
    );
  }

  TextField addNotes() {
    return TextField(
      onChanged: (value) {
        setState(() {
          notes = value;
        });
      },
      textAlign: TextAlign.center,
      decoration: const InputDecoration(hintText: 'Notes'),
    );
  }

  TextButton addEvent(BuildContext context) {
    return TextButton(
      onPressed: eventName.isEmpty
          ? null
          : () {
              setState(() {
                if (recurrencePattenEnd != null &&
                    recurrencePattenWithoutEnd != null) {
                  recurrenceRule =
                      '$recurrencePattenWithoutEnd;$recurrencePattenEnd';
                } else if (recurrencePattenWithoutEnd != null &&
                    recurrencePattenEnd == null) {
                  recurrenceRule = recurrencePattenWithoutEnd;
                }
              });
              context.read<AddEventCubit>().addEvent(
                    eventName,
                    notes,
                    widget.eventStartTime,
                    widget.eventEndTime,
                    isAllDay,
                    colorValue,
                    recurrenceRule,
                    frequency,
                    recurrenceRuleEnding,
                  );
            },
      child: Text(
        'Add',
        style:
            TextStyle(color: eventName.isEmpty ? appGrey : Color(colorValue)),
      ),
    );
  }
}

class ClosePage extends StatelessWidget {
  const ClosePage({
    super.key,
    required this.colorValue,
  });

  final int colorValue;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        Navigator.of(context).pop();
      },
      child: Text(
        'Close',
        style: TextStyle(color: Color(colorValue)),
      ),
    );
  }
}
