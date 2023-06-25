import 'package:flutter/material.dart';

import '../../../variables/variables.dart';

class EventDetailsPageBody extends StatelessWidget {
  const EventDetailsPageBody({
    super.key,
    required this.body,
  });

  final List<Widget> body;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Column(
        children: [
          for (int i = 0; i < 3; i++)
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                  padding: const EdgeInsets.only(left: 8),
                  alignment: Alignment.centerLeft,
                  constraints: BoxConstraints(
                    minWidth: MediaQuery.of(context).size.width,
                    minHeight: 50,
                  ),
                  decoration: containerDecoration,
                  child: body[i]),
            )
        ],
      ),
    );
  }
}
