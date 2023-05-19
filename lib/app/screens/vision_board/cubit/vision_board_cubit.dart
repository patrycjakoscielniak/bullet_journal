import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meta/meta.dart';
import 'package:my_bullet_journal/repositories/vision_board_repository.dart';

import '../model/vision_board_model.dart';

part 'vision_board_state.dart';

class VisionBoardCubit extends Cubit<VisionBoardState> {
  VisionBoardCubit(this._visionBoardRepository)
      : super(const VisionBoardState(
          errorMessage: '',
          items: [],
        ));
  final VisionBoardRepository _visionBoardRepository;

  StreamSubscription? _streamSubscription;

  Future<void> addImage(XFile image) async {
    try {
      _visionBoardRepository.uploadImage(image);
    } catch (error) {
      emit(VisionBoardState(
        items: const [],
        errorMessage: error.toString(),
      ));
    }
  }

  Future<void> start() async {
    emit(const VisionBoardState(
      items: [],
      errorMessage: '',
    ));

    _streamSubscription =
        _visionBoardRepository.getVisionBoardItemStream().listen((visionBoard) {
      emit(VisionBoardState(
        items: visionBoard,
        errorMessage: '',
      ));
    })
          ..onError((error) {
            emit(VisionBoardState(
              items: const [],
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
