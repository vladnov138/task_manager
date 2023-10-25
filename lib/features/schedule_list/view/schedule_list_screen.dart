import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';
import 'package:task_manager/features/schedule_list/schedule_list.dart';

import '../../../client/hive_names.dart';
import '../../../models/task.dart';

class ScheduleListScreen extends StatelessWidget {
  const ScheduleListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Tasks"),
      ),
      body: ValueListenableBuilder(
          valueListenable: Hive.box<Task>(HiveBoxes.task).listenable(),
          builder: (context, Box<Task> box, _) {
            if (box.values.isEmpty) {
              return const Center(
                child: Text("Todo list is empty"),
              );
            }
            List<Task> sortered = box.values.toList();
            sortered.sort((a, b) => a.deadline.compareTo(b.deadline));
            return ListView.builder(
              itemCount: sortered.length,
              itemBuilder: (context, index) {
                Task? res = sortered[index];
                return Dismissible(
                  background: Container(color: Colors.red),
                  key: UniqueKey(),
                  onDismissed: (direction) {
                    res.delete();
                  },
                  child: ListTile(
                      title: Text(res.task ?? ''),
                      subtitle: Text("Study"),
                      leading: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(DateFormat('EEE, d').format(res.deadline) ??
                                ''),
                            Text(DateFormat("hh:mm").format(res.deadline))
                          ]),
                      trailing: res.important ? SvgPicture.asset(
                        "assets/important_icon.svg",
                        width: 25,
                        height: 25,
                      ) : null,
                      onTap: () {
                        Navigator.of(context)
                            .pushNamed("/task", arguments: res);
                      },
                  ),
                );
              },
            );
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pushNamed('/add_task');
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
