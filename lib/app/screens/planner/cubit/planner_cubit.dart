import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:my_bullet_journal/models/planner_item_model.dart';
import 'package:my_bullet_journal/repositories/planner_repository.dart';

import '../../../core/enums.dart';

part 'planner_state.dart';

class PlannerCubit extends Cubit<PlannerState> {
  PlannerCubit(this._plannerRepository) : super(const PlannerState());

  final PlannerRepository _plannerRepository;

  Future<void> start() async {
    emit(const PlannerState(status: Status.loading));
    await Future.delayed(const Duration(seconds: 2));
    try {
      final result = await _plannerRepository.getHolidays();
      print('$result');
      emit(PlannerState(
        holidaysResults: result,
        status: Status.success,
      ));
    } catch (error) {
      emit(PlannerState(
        status: Status.error,
        errorMessage: error.toString(),
      ));
    }
  }
}
