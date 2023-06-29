import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';
import 'package:my_bullet_journal/repositories/planner_repository.dart';

import '../../../../../core/enums.dart';

part 'edit_event_state.dart';

@injectable
class EditEventCubit extends Cubit<EditEventState> {
  EditEventCubit(this._plannerRepository) : super(const EditEventState());

  final PlannerRepository _plannerRepository;

  Future<void> updateEvent({
    required String id,
    required String eventName,
    required String? notes,
    required String? recurrenceRule,
    required String? recurrenceRuleEnding,
    required String? frequency,
    required DateTime startTime,
    required DateTime endTime,
    required bool isAllDay,
    required int colorValue,
  }) async {
    try {
      await _plannerRepository.update(
          id: id,
          eventName: eventName,
          notes: notes,
          recurrenceRule: recurrenceRule,
          recurrenceRuleEnding: recurrenceRuleEnding,
          frequency: frequency,
          startTime: startTime,
          endTime: endTime,
          isAllDay: isAllDay,
          colorValue: colorValue);
      emit(const EditEventState(status: Status.updated));
    } catch (error) {
      emit(EditEventState(
        status: Status.error,
        errorMessage: error.toString(),
      ));
    }
  }
}
