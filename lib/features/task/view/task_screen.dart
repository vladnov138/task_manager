import 'package:flutter/material.dart';
import 'package:task_manager/features/task/task.dart';
import 'package:task_manager/theme/theme.dart';

import '../../schedule_list/schedule_list.dart';

class TaskScreen extends StatelessWidget {
  TaskScreen({super.key});

  bool test = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Task')),
      body: Container(
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
                  Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: const TaskTitleWidget()),
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
                    const DetailTextWidget(text: "tratata")
                  ],
                ),
                const TableRow(children: [
                  SizedBox(height: 20),
                  SizedBox(height: 20),
                ]),
              ],
            ),
            CheckboxListTile(
              title: const Text("Passed"),
              controlAffinity: ListTileControlAffinity.leading,
              onChanged: (bool? value) {},
              value: test,
            ),
            CheckboxListTile(
              title: const Text("Important"),
              controlAffinity: ListTileControlAffinity.leading,
              onChanged: (bool? value) {},
              value: !test,
            ),
            Container(
              padding: EdgeInsets.only(top: 25),
              child: MaterialButton(
                onPressed: () {
                  Navigator.of(context).pushNamed(
                    '/task',
                  );
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
