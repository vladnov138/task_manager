import 'package:flutter/material.dart';
import 'package:task_manager/features/task/task.dart';
import 'package:task_manager/theme/theme.dart';

import '../../../models/task.dart';
import '../../schedule_list/schedule_list.dart';

class TaskScreen extends StatefulWidget {
  TaskScreen({super.key});

  @override
  State<TaskScreen> createState() => _TaskScreenState();
}

class _TaskScreenState extends State<TaskScreen> {
  @override
  void didChangeDependencies() {
    final args = ModalRoute.of(context)?.settings.arguments;
    assert(args != null && args is Task, 'You must provide String args');
    res = args as Task;
    setState(() {

    });
    super.didChangeDependencies();
  }

  Task? res;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Task')),
      body: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(children: [
            Table(
              columnWidths: const <int, TableColumnWidth>{
                0: FlexColumnWidth(10),
                1: FlexColumnWidth(20),
              },
              children: [
                TableRow(children: [
                  TableCell(
                    verticalAlignment: TableCellVerticalAlignment.middle,
                    child: Text(
                      "Task title",
                      style: mainTheme.textTheme.headlineSmall,
                    ),
                  ),
                  Padding(
                      padding: EdgeInsets.symmetric(horizontal: 0),
                      child: TextFormField(
                        initialValue: res!.task,
                      ),
                  ),
                ]),
                const TableRow(children: [
                  SizedBox(height: 20),
                  SizedBox(height: 20),
                ]),
                TableRow(
                  children: [
                    Text(
                      "Details",
                      style: mainTheme.textTheme.headlineSmall,
                    ),
                    DetailTextWidget(text: res!.details)
                  ],
                ),
                const TableRow(children: [
                  SizedBox(height: 20),
                  SizedBox(height: 20),
                ]),
              ],
            ),
            CheckboxListTile(
              title: const Text("Completed"),
              controlAffinity: ListTileControlAffinity.leading,
              onChanged: (bool? value) {
                setState(() {
                  res!.complete = !res!.complete;
                });
              },
              value: res!.complete,
            ),
            CheckboxListTile(
              title: const Text("Important"),
              controlAffinity: ListTileControlAffinity.leading,
              onChanged: (bool? value) {
                setState(() {
                  res!.important = !res!.important;
                });
              },
              value: res!.important,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 25),
              child: MaterialButton(
                onPressed: () {
                  res!.save();
                  Navigator.of(context).pop();
                },
                color: Colors.blue,
                minWidth: 200,
                child: Text(
                  "Save",
                  style: mainTheme.textTheme.labelMedium,
                ),
              ),
            ),
          ])),
    );
  }
}
