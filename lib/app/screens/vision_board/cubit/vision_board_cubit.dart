import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meta/meta.dart';
import 'package:my_bullet_journal/app/core/enums.dart';
import 'package:my_bullet_journal/repositories/vision_board_repository.dart';

import '../../../../models/vision_board_model.dart';

part 'vision_board_state.dart';

class VisionBoardCubit extends Cubit<VisionBoardState> {
  VisionBoardCubit(this._visionBoardRepository)
      : super(const VisionBoardState(items: []));

  final VisionBoardRepository _visionBoardRepository;

  StreamSubscription? _streamSubscription;

  Future<void> addImage(XFile image) async {
    try {
      _visionBoardRepository.uploadImage(image);
      emit(const VisionBoardState(
        status: Status.saved,
        items: [],
      ));
    } catch (error) {
      emit(VisionBoardState(
        errorMessage: error.toString(),
        status: Status.error,
        items: const [],
      ));
    }
  }

  Future<void> deleteImage({required String url, required String docId}) async {
    try {
      await _visionBoardRepository.deleteImage(url: url, id: docId);
      emit(const VisionBoardState(
        items: [],
        status: Status.deleted,
      ));
    } catch (error) {
      emit(VisionBoardState(
        items: const [],
        errorMessage: error.toString(),
        status: Status.error,
      ));
    }
  }

  Future<void> start() async {
    emit(const VisionBoardState(
      status: Status.loading,
      items: [],
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
              items: const [],
            ));
          });
  }

  @override
  Future<void> close() {
    _streamSubscription?.cancel();
    return super.close();
  }
}
