import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_bullet_journal/app/app.dart';
import '../../../variables/variables.dart';
import '../cubit/details_page_cubit.dart';

class DeleteEventDialog extends StatelessWidget {
  const DeleteEventDialog({
    super.key,
    required this.id,
    required this.colorValue,
  });

  final String id;
  final int colorValue;

  @override
  Widget build(BuildContext context) {
    return IconButton(
        onPressed: () {
          showDialog(
              context: context,
              builder: (context) {
                return FractionallySizedBox(
                  widthFactor: 0.9,
                  child: Material(
                    type: MaterialType.transparency,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(15),
                          decoration: dialogContainerDecoration,
                          child: Column(
                            children: [
                              Text(
                                'Delete this Event?',
                                style: textStyle,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: Text(
                                      'Close',
                                      style:
                                          TextStyle(color: Color(colorValue)),
                                    ),
                                  ),
                                  TextButton(
                                      onPressed: () {
                                        context
                                            .read<DetailsPageCubit>()
                                            .deleteEvent(documentID: id);
                                        Navigator.of(context).push(
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    const MyApp()));
                                      },
                                      child: Text(
                                        'Delete',
                                        style:
                                            TextStyle(color: Color(colorValue)),
                                      ))
                                ],
                              )
                            ],
                          ),
                        ),
                        const SizedBox(height: 60)
                      ],
                    ),
                  ),
                );
              });
        },
        icon: Icon(
          Icons.delete_outline,
          color: Color(colorValue),
        ));
  }
}
