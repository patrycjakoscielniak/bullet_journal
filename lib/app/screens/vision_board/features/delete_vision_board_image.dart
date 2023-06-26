import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/vision_board_cubit.dart';

class DeleteImage extends StatelessWidget {
  const DeleteImage({
    super.key,
    required List<String> selectedIdList,
    required List<String> selectedUrlList,
  })  : _selectedIdList = selectedIdList,
        _selectedUrlList = selectedUrlList;

  final List<String> _selectedIdList;
  final List<String> _selectedUrlList;

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        for (int i = 0; i < _selectedIdList.length; i++) {
          context
              .read<VisionBoardCubit>()
              .deleteImage(url: _selectedUrlList[i], docId: _selectedIdList[i]);
        }
      },
      backgroundColor: Colors.white,
      foregroundColor: Colors.blueGrey,
      child: const Icon(
        Icons.delete,
      ),
    );
  }
}
