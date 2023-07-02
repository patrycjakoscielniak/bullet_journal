import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:my_bullet_journal/domain/repositories/planner_repository.dart';
import '../../../../../core/enums.dart';

part 'event_details_state.dart';
part 'event_details_cubit.freezed.dart';

@injectable
class EventDetailsCubit extends Cubit<EventDetailsState> {
  EventDetailsCubit(this._plannerRepository) : super(EventDetailsState());

  final PlannerRepository _plannerRepository;

  Future<void> deleteEvent({required String documentID}) async {
    try {
      await _plannerRepository.delete(id: documentID);
      emit(EventDetailsState(status: Status.deleted));
    } catch (error) {
      emit(EventDetailsState(
        errorMessage: error.toString(),
        status: Status.error,
      ));
    }
  }
}
