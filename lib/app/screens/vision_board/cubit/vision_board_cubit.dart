import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:image_picker/image_picker.dart';
import 'package:injectable/injectable.dart';
import 'package:my_bullet_journal/app/core/enums.dart';
import 'package:my_bullet_journal/domain/repositories/vision_board_repository.dart';
import '../../../../data/models/vision_board_model.dart';

part 'vision_board_state.dart';
part 'vision_board_cubit.freezed.dart';

@injectable
class VisionBoardCubit extends Cubit<VisionBoardState> {
  VisionBoardCubit(this._visionBoardRepository) : super(VisionBoardState());

  final VisionBoardRepository _visionBoardRepository;

  StreamSubscription? _streamSubscription;

  Future<void> addImage(XFile image) async {
    try {
      _visionBoardRepository.uploadImage(image);
      emit(VisionBoardState(
        status: Status.saved,
      ));
    } catch (error) {
      emit(VisionBoardState(
        errorMessage: error.toString(),
        status: Status.error,
      ));
    }
  }

  Future<void> deleteImage({required String url, required String docId}) async {
    try {
      await _visionBoardRepository.deleteImage(url: url, id: docId);
      emit(VisionBoardState(
        status: Status.deleted,
      ));
    } catch (error) {
      emit(VisionBoardState(
        errorMessage: error.toString(),
        status: Status.error,
      ));
    }
  }

  Future<void> start() async {
    emit(VisionBoardState(
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
