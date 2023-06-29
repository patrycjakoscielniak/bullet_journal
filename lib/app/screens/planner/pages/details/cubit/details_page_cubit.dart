import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';
import 'package:my_bullet_journal/repositories/planner_repository.dart';

import '../../../../../core/enums.dart';

part 'details_page_state.dart';

@injectable
class DetailsPageCubit extends Cubit<DetailsPageState> {
  DetailsPageCubit(this._plannerRepository) : super(const DetailsPageState());

  final PlannerRepository _plannerRepository;

  Future<void> deleteEvent({required String documentID}) async {
    try {
      await _plannerRepository.delete(id: documentID);
      emit(const DetailsPageState(status: Status.deleted));
    } catch (error) {
      emit(DetailsPageState(
        errorMessage: error.toString(),
        status: Status.error,
      ));
    }
  }
}
