import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meta/meta.dart';
import 'package:my_bullet_journal/app/core/enums.dart';
import 'package:my_bullet_journal/repositories/vision_board_repository.dart';

import '../model/vision_board_model.dart';

part 'vision_board_state.dart';

class VisionBoardCubit extends Cubit<VisionBoardState> {
  VisionBoardCubit(this._visionBoardRepository)
      : super(const VisionBoardState());

  final VisionBoardRepository _visionBoardRepository;

  StreamSubscription? _streamSubscription;

  Future<void> addImage(XFile image) async {
    try {
      _visionBoardRepository.uploadImage(image);
      emit(const VisionBoardState(
        status: Status.saved,
      ));
    } catch (error) {
      emit(VisionBoardState(
        errorMessage: error.toString(),
        status: Status.error,
      ));
    }
  }

  Future<void> start() async {
    emit(const VisionBoardState(
      status: Status.loading,
    ));

    _streamSubscription =
        _visionBoardRepository.getVisionBoardItemStream().listen((visionBoard) {
      emit(VisionBoardState(
        items: visionBoard,
        status: Status.success,
      ));
    })
          ..onError((error) {
            emit(VisionBoardState(
              status: Status.error,
              errorMessage: error.toString(),
            ));
          });
  }

  @override
  Future<void> close() {
    _streamSubscription?.cancel();
    return super.close();
  }
}
