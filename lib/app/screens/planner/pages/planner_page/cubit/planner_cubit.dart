import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:my_bullet_journal/domain/repositories/planner_repository.dart';
import '../../../../../../data/models/planner_item_model.dart';
import '../../../../../core/enums.dart';

part 'planner_state.dart';
part 'planner_cubit.freezed.dart';

@injectable
class PlannerCubit extends Cubit<PlannerState> {
  PlannerCubit(this._plannerRepository) : super(PlannerState());

  final PlannerRepository _plannerRepository;

  StreamSubscription? _streamSubscription;

  Future<List<Holidays>> getHolidays() async {
    final holidays = await _plannerRepository.fetchHolidays();
    emit(PlannerState(
      status: Status.success,
    ));
    return holidays;
  }

  Future<void> start() async {
    emit(PlannerState(status: Status.loading));

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
