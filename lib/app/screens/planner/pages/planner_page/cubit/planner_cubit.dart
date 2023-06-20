import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:my_bullet_journal/models/planner_item_model.dart';
import 'package:my_bullet_journal/repositories/planner_repository.dart';
import '../../../../../core/enums.dart';

part 'planner_state.dart';

class PlannerCubit extends Cubit<PlannerState> {
  PlannerCubit(this._plannerRepository) : super(const PlannerState());

  final PlannerRepository _plannerRepository;

  StreamSubscription? _streamSubscription;

  Future<void> start() async {
    emit(const PlannerState(status: Status.loading));

    _streamSubscription = _plannerRepository
        .getAppointments()
        .listen((planner) {
      emit(PlannerState(appointments: planner, status: Status.success));
    })
      ..onError((error) {
        emit(
            PlannerState(errorMessage: error.toString(), status: Status.error));
      });
  }

  @override
  Future<void> close() {
    _streamSubscription?.cancel();
    return super.close();
  }
}
