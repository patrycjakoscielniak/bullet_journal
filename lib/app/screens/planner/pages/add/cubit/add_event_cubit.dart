import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:my_bullet_journal/domain/repositories/planner_event_repository.dart';
import '../../../../../core/enums.dart';

part 'add_event_state.dart';
part 'add_event_cubit.freezed.dart';

@injectable
class AddEventCubit extends Cubit<AddEventState> {
  AddEventCubit(this._plannerRepository) : super(AddEventState());

  final PlannerEventRepository _plannerRepository;

  Future<void> addEvent(
    String name,
    String? notes,
    DateTime startTime,
    DateTime endTime,
    bool isAllDay,
    int colorValue,
    String? recurrenceRule,
    String? frequency,
    String? recurrenceRuleEnding,
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
        recurrenceRuleEnding,
      );
      emit(AddEventState(status: Status.saved));
    } catch (error) {
      emit(AddEventState(
        status: Status.error,
        errorMessage: error.toString(),
      ));
    }
  }
}
