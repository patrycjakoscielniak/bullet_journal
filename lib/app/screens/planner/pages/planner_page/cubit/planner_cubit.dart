import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:my_bullet_journal/domain/repositories/planner_holidays_repository.dart';
import 'package:my_bullet_journal/domain/repositories/planner_event_repository.dart';
import '../../../../../../data/models/event_model.dart';
import '../../../../../../data/models/holidays_model.dart';
import '../../../../../core/enums.dart';

part 'planner_state.dart';
part 'planner_cubit.freezed.dart';

@injectable
class PlannerCubit extends Cubit<PlannerState> {
  PlannerCubit(this._plannerEventRepository, this._plannerHolidaysRepository)
      : super(PlannerState());

  final PlannerEventRepository _plannerEventRepository;
  final PlannerHolidaysRepository _plannerHolidaysRepository;

  StreamSubscription? _streamSubscription;

  Future<List<HolidayModel>> getHolidays(String country) async {
    final result = await _plannerHolidaysRepository.getHolidays(country);
    emit(PlannerState(
      status: Status.success,
    ));
    return result;
  }

  Future<void> start() async {
    emit(PlannerState(status: Status.loading));

    _streamSubscription = _plannerEventRepository
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
