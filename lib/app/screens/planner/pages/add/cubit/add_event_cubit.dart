import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:my_bullet_journal/repositories/planner_repository.dart';

part 'add_event_state.dart';

class AddEventCubit extends Cubit<AddEventState> {
  AddEventCubit(this._plannerRepository) : super(AddEventState());

  final PlannerRepository _plannerRepository;

  Future<void> addEvent(
    String name,
    String? notes,
    DateTime startTime,
    DateTime endTime,
    bool isAllDay,
    Color color,
    String? freq,
    int? byMonth,
    int? byMonthDay,
    int? count,
    String? byDay,
    DateTime? until,
  ) async {
    try {
      await _plannerRepository.add(name, notes, startTime, endTime, isAllDay,
          color, freq, byMonth, byMonthDay, count, byDay, until);
      emit(AddEventState(isSaved: true));
    } catch (error) {
      emit(AddEventState(errorMessage: error.toString()));
    }
  }
}
