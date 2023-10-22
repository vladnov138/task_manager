import 'package:flutter/material.dart';

class TaskTitleWidget extends StatelessWidget {
  const TaskTitleWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(width: 1, color: Colors.orange),
            color: const Color.fromARGB(180, 253, 234, 92),
          ),
          // width: 280,
          child: const Text("Сходить в котокафе", textAlign: TextAlign.center,),
        )
      ],
    );
  }
}
