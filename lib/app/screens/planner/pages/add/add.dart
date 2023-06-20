import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart';
import 'package:intl/intl.dart';
import 'package:my_bullet_journal/app/data/planner_remote_data_source.dart';
import 'package:my_bullet_journal/app/screens/planner/pages/add/cubit/add_event_cubit.dart';
import 'package:my_bullet_journal/repositories/planner_repository.dart';
import 'package:omni_datetime_picker/omni_datetime_picker.dart';

import 'variables/variables.dart';

class AddEvent extends StatefulWidget {
  const AddEvent({
    super.key,
  });

  @override
  State<AddEvent> createState() => _AddEventState();
}

class _AddEventState extends State<AddEvent> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AddEventCubit(
          PlannerRepository(remoteDataSource: HolidaysRemoteDioDataSource())),
      child: BlocConsumer<AddEventCubit, AddEventState>(
        listener: (context, state) {
          if (state.isSaved) {
            Navigator.of(context).pop();
          }
          if (state.errorMessage.isNotEmpty) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(state.errorMessage),
              duration: const Duration(seconds: 7),
            ));
          }
        },
        builder: (context, state) {
          return Scaffold(
            body: Padding(
              padding: const EdgeInsets.only(right: 50.0, left: 50, top: 80),
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
                  isAllDay
                      ? pickAllDayEventDate(context)
                      : Column(
                          children: [
                            pickEventDate(context),
                            space,
                          ],
                        ),
                  isEventRepeating(),
                  repeat ? setRecurrencePattern(context) : empty,
                  space,
                  addNotes(),
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
                      Navigator.of(context).pop();
                    },
                    child: const Text('Close'),
                  ),
                  TextButton(
                    onPressed: newEvent.isEmpty
                        ? null
                        : () {
                            context.read<AddEventCubit>().addEvent(
                                  newEvent,
                                  notes,
                                  eventStartTime,
                                  eventEndTime,
                                  isAllDay,
                                  currentColor,
                                  freq,
                                  byMonth,
                                  byMonthDay,
                                  count,
                                  byDay,
                                  until,
                                );
                          },
                    child: const Text(
                      'Add',
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

  Expanded addEventName() {
    return Expanded(
      child: TextField(
        onChanged: (value) {
          setState(() {
            newEvent = value;
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
                        currentColor = color;
                      });
                    },
                  ),
                ),
                actions: <Widget>[
                  TextButton(
                    onPressed: () {
                      setState(() {
                        pickerColor = currentColor;
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
        color: currentColor,
      ),
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
            value: isAllDay,
            onChanged: (value) {
              setState(() {
                isAllDay = value;
              });
            })
      ],
    );
  }

  Column pickAllDayEventDate(BuildContext context) {
    return Column(
      children: [
        ElevatedButton(
          style: buttonStyle,
          onPressed: () {
            DatePicker.showDatePicker(
              context,
              onConfirm: (time) {
                setState(() {
                  eventStartTime = time;
                  eventEndTime = time.add(const Duration(hours: 1));
                });
              },
            );
          },
          child: Text(DateFormat('dd  MMMM').format(eventStartTime)),
        ),
        space,
      ],
    );
  }

  ElevatedButton pickEventDate(BuildContext context) {
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
              eventStartTime = dateTimeList.first;
            });
            setState(() {
              eventEndTime = dateTimeList.last;
            });
          }
        },
        child: Text(
            'from ${DateFormat('dd MMM hh : mm').format(eventStartTime)}  to  ${DateFormat('dd MMM hh : mm').format(eventEndTime)}',
            style: textStyle));
  }

  Row isEventRepeating() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Text(
          'Repeat',
          style: textStyle,
          textAlign: TextAlign.center,
        ),
        Switch.adaptive(
            value: repeat,
            onChanged: (value) {
              setState(() {
                repeat = value;
              });
              if (value == true) {
                setState(() {
                  freq = 'YEARLY';
                  byMonth = int.parse(DateFormat('M').format(eventStartTime));
                  byMonthDay =
                      int.parse(DateFormat('d').format(eventStartTime));
                  byDay = '';
                });
              }
            })
      ],
    );
  }

  Column setRecurrencePattern(BuildContext context) {
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
                for (int index = 0; index < isSelected.length; index++) {
                  if (index == newIndex) {
                    isSelected[index] = true;
                  } else {
                    isSelected[index] = false;
                  }
                }
              });
              if (isSelected.elementAt(0) == true) {
                setState(() {
                  freq = 'YEARLY';
                  byMonth = int.parse(DateFormat('M').format(eventStartTime));
                  byMonthDay =
                      int.parse(DateFormat('d').format(eventStartTime));
                  byDay = '';
                });
              }
              if (isSelected.elementAt(1) == true) {
                setState(() {
                  freq = 'MONTHLY';
                  byMonth = null;
                  byMonthDay =
                      int.parse(DateFormat('d').format(eventStartTime));
                  byDay = '';
                });
              }
              if (isSelected.elementAt(2) == true) {
                setState(() {
                  freq = 'WEEKLY';
                  byMonth = null;
                  byMonthDay = null;
                  if (eventStartTime.weekday == 1) {
                    setState(() {
                      byDay = 'MO';
                    });
                  }
                  if (eventStartTime.weekday == 2) {
                    setState(() {
                      byDay = 'TU';
                    });
                  }
                  if (eventStartTime.weekday == 3) {
                    setState(() {
                      byDay = 'WE';
                    });
                  }
                  if (eventStartTime.weekday == 4) {
                    setState(() {
                      byDay = 'TH';
                    });
                  }
                  if (eventStartTime.weekday == 5) {
                    setState(() {
                      byDay = 'FR';
                    });
                  }
                  if (eventStartTime.weekday == 6) {
                    setState(() {
                      byDay = 'SA';
                    });
                  }
                  if (eventStartTime.weekday == 7) {
                    setState(() {
                      byDay = 'SU';
                    });
                  }
                });
              }
              if (isSelected.elementAt(3) == true) {
                setState(() {
                  freq = 'DAILY';
                  byDay = '';
                  byMonth = null;
                  byMonthDay = null;
                });
              }
            },
            isSelected: isSelected,
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
              value: dropdownValue,
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
                              count = value;
                              until = null;
                            });
                          }
                        }),
                    Text('Times', style: textStyle)
                  ],
                ),
              )
            : dropdownValue == 'On date'
                ? ElevatedButton(
                    style: buttonStyle,
                    onPressed: () {
                      DatePicker.showDatePicker(
                        context,
                        onConfirm: (time) {
                          setState(() {
                            recurrenceEndDate =
                                DateFormat('dd  MMMM yyyy').format(time);
                            until = time;
                            count = null;
                          });
                        },
                      );
                    },
                    child: Text(
                      recurrenceEndDate,
                      style: textStyle,
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
}
