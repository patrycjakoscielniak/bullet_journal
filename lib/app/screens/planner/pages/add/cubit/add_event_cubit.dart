import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:my_bullet_journal/repositories/planner_repository.dart';

part 'add_event_state.dart';

class AddEventCubit extends Cubit<AddEventState> {
  AddEventCubit(this._plannerRepository) : super(const AddEventState());

  final PlannerRepository _plannerRepository;

  Future<void> addEvent(
    String name,
    String? notes,
    DateTime startTime,
    DateTime endTime,
    bool isAllDay,
    int colorValue,
    String? recurrenceRule,
    String? frequency,
  ) async {
    try {
      await _plannerRepository.add(
        name,
        notes,
        startTime,
        endTime,
        isAllDay,
        colorValue,
        recurrenceRule,
        frequency,
      );
      emit(const AddEventState(isSaved: true));
    } catch (error) {
      emit(AddEventState(errorMessage: error.toString()));
    }
  }
}
