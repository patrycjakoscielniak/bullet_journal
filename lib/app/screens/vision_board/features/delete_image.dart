import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_bullet_journal/app/screens/vision_board/cubit/vision_board_cubit.dart';

class DeleteImage extends StatelessWidget {
  const DeleteImage({
    super.key,
    required this.id,
  });

  final String id;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        showDialog(
          context: context,
          builder: (BuildContext contex) {
            return AlertDialog(
              title: const Center(
                child: Text(
                  'Delete Item',
                ),
              ),
              content: SingleChildScrollView(
                child: ListBody(
                  children: [
                    const Text('Are you sure you want to delete item?'),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(
                            key: ValueKey(id),
                            onPressed: () {
                              context
                                  .read<VisionBoardCubit>()
                                  .deleteImage(docID: id);
                              Navigator.pop(context);
                            },
                            child: const Text('Yes')),
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text('No'),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
      icon: const Icon(
        Icons.delete,
        color: Colors.blueGrey,
      ),
    );
  }
}
