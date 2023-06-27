// ignore_for_file: must_be_immutable

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart';
import 'package:intl/intl.dart';
import 'package:my_bullet_journal/app/app.dart';
import 'package:my_bullet_journal/app/core/enums.dart';
import 'package:my_bullet_journal/app/screens/planner/pages/edit/cubit/edit_event_cubit.dart';
import 'package:omni_datetime_picker/omni_datetime_picker.dart';
import '../../../../../core/global_variables.dart';
import '../../../variables/planner_variables.dart';

class EditEventPage extends StatefulWidget {
  EditEventPage({
    super.key,
    required this.eventName,
    required this.id,
    required this.dropdownValue,
    required this.colorValue,
    required this.recurrenceRuleWithoutEnd,
    required this.recurrenceRuleEnding,
    required this.displayRecurrenceRuleEndDate,
    required this.frequency,
    required this.dropdownInt,
    required this.eventStartTime,
    required this.eventEndTime,
    required this.isAllDay,
    required this.isRecurring,
    required this.recurrenceType,
    required this.notes,
  });

  final String eventName;
  String id,
      dropdownValue,
      recurrenceRuleWithoutEnd,
      displayRecurrenceRuleEndDate;

  int dropdownInt, colorValue;
  DateTime eventStartTime, eventEndTime;
  bool isAllDay, isRecurring;
  List<bool> recurrenceType;
  String? notes, frequency, recurrenceRuleEnding;

  @override
  State<EditEventPage> createState() => _EditEventPageState();
}

class _EditEventPageState extends State<EditEventPage> {
  final space = const SizedBox(height: 15);
  List<int> intDropdownList = [for (int i = 1; i <= 100; i++) i];
  String? recurrenceRule, recurrenceRuleEndingText;

  @override
  Widget build(BuildContext context) {
    final colorValue = widget.colorValue;
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
    return BlocListener<EditEventCubit, EditEventState>(
      listener: (context, state) {
        if (state.status == Status.updated) {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => const MyApp()));
        }
        if (state.status == Status.error) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(state.errorMessage!)));
        }
      },
      child: Scaffold(
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
              isEventRecurring(recurrenceRulePattern),
              space,
              widget.isRecurring
                  ? editRecurrenceRule(context, recurrenceRulePattern)
                  : space,
              editNotes(),
            ],
          ),
        ),
        bottomSheet: Padding(
          padding: const EdgeInsets.only(bottom: 30, right: 15, left: 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [closePage(context), saveChanges(context, colorValue)],
          ),
        ),
      ),
    );
  }

  IconButton editColor() {
    return IconButton(
      onPressed: () {
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                content: SingleChildScrollView(
                  child: ColorPicker(
                    paletteType: PaletteType.hslWithSaturation,
                    pickerColor: Color(widget.colorValue),
                    onColorChanged: (color) {
                      setState(() {
                        widget.colorValue = color.value;
                      });
                    },
                  ),
                ),
                actions: <Widget>[
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text('Save'),
                  )
                ],
              );
            });
      },
      icon: const Icon(Icons.color_lens),
      color: Color(widget.colorValue),
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
                Platform.isAndroid ? Colors.white30 : Color(widget.colorValue),
            activeTrackColor: Color(widget.colorValue),
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
          style: mainTextStyle),
    );
  }

  Row isEventRecurring(recurrenceRulePattern) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Text(
          'Recurring',
          style: mainTextStyle,
          textAlign: TextAlign.center,
        ),
        Switch.adaptive(
            activeColor:
                Platform.isAndroid ? Colors.white30 : Color(widget.colorValue),
            activeTrackColor: Color(widget.colorValue),
            value: widget.isRecurring,
            onChanged: (value) {
              setState(() {
                widget.isRecurring = value;
              });
              if (value == true) {
                setState(() {
                  widget.recurrenceRuleWithoutEnd =
                      recurrenceRulePattern[1]['rule'];
                  widget.frequency = recurrenceRulePattern[1]['frequency'];
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

  Column editRecurrenceRule(BuildContext context, recurrenceRulePattern) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 15, bottom: 15),
          child: ToggleButtons(
            selectedColor: Colors.white,
            fillColor: Color(widget.colorValue),
            borderColor: Colors.blueGrey,
            selectedBorderColor: Color(widget.colorValue),
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
              if (newIndex == 2) {
                widget.frequency = 'Weekly';
                for (int i = 1; i < byWeekDayValue.length; i++) {
                  if (widget.eventStartTime.weekday == i) {
                    setState(() {
                      widget.recurrenceRuleWithoutEnd = byWeekDayValue[i];
                    });
                  }
                }
              } else {
                setState(() {
                  widget.recurrenceRuleWithoutEnd =
                      recurrenceRulePattern[newIndex]['rule'];
                  widget.frequency =
                      recurrenceRulePattern[newIndex]['frequency'];
                });
              }
            },
            isSelected: widget.recurrenceType,
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
              value: widget.dropdownValue,
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
                    widget.dropdownValue = value;
                  });
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
                              recurrenceRuleEndingText = 'COUNT=$intValue';
                            });
                          }
                        }),
                    Text('Times', style: mainTextStyle)
                  ],
                ),
              )
            : widget.dropdownValue == 'On date'
                ? ElevatedButton(
                    style: elevatedButtonStyle,
                    onPressed: () {
                      DatePicker.showDatePicker(
                        context,
                        onConfirm: (time) {
                          setState(() {
                            widget.displayRecurrenceRuleEndDate =
                                DateFormat('dd  MMMM yyyy').format(time);
                            recurrenceRuleEndingText =
                                'UNTIL=${DateFormat('yyyyMMddTHHmmss').format(time)}Z';
                          });
                        },
                      );
                    },
                    child: Text(
                      widget.displayRecurrenceRuleEndDate,
                      style: mainTextStyle,
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

  TextButton closePage(BuildContext context) {
    return TextButton(
      onPressed: () {
        Navigator.of(context)
            .push(MaterialPageRoute(builder: ((context) => const MyApp())));
      },
      child: Text(
        'Close',
        style: TextStyle(color: Color(widget.colorValue)),
      ),
    );
  }

  TextButton saveChanges(BuildContext context, int colorValue) {
    return TextButton(
      onPressed: () {
        context.read<EditEventCubit>().updateEvent(
              id: widget.id,
              eventName: widget.eventName,
              notes: widget.notes,
              recurrenceRule: (widget.recurrenceRuleWithoutEnd != '')
                  ? '${widget.recurrenceRuleWithoutEnd};$recurrenceRuleEndingText'
                  : recurrenceRule = widget.recurrenceRuleWithoutEnd,
              frequency: widget.frequency,
              startTime: widget.eventStartTime,
              endTime: widget.eventEndTime,
              isAllDay: widget.isAllDay,
              colorValue: colorValue,
            );
      },
      child: Text(
        'Save Changes',
        style: TextStyle(color: Color(widget.colorValue)),
      ),
    );
  }
}
