import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart';
import 'package:intl/intl.dart';
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
  List<String> categories = [
    'Study',
    'Job',
    'Rest',
    'Hobby',
    'Others',
  ];

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
                TableRow(
                  children: [
                    Text(
                      "Category",
                      style: mainTheme.textTheme.headlineSmall,
                    ),
                    DropdownButton(
                      value: res!.category,
                      icon: const Icon(Icons.keyboard_arrow_down),
                      items: categories.map((String items) {
                        return DropdownMenuItem(
                          value: items,
                          child: Text(items),
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                        setState(() {
                          res!.category = newValue!;
                        });
                      },
                    ),
                  ],
                ),
                const TableRow(
                  children: [
                    SizedBox(height: 20),
                    SizedBox(height: 20),
                  ],
                ),
                TableRow(
                  children: [
                    Text(
                      "Deadline",
                      style: mainTheme.textTheme.headlineSmall,
                    ),
                    TextButton(
                      onPressed: () {
                        DatePicker.showDateTimePicker(
                          context,
                          currentTime: res!.deadline,
                          minTime: DateTime.now(),
                          maxTime: DateTime(3000),
                          onConfirm: (dateTime) {
                            setState(() {
                              res!.deadline = dateTime;
                            });
                          },
                        );
                      },
                      child: Text(DateFormat("dd.MM.yyyy hh:mm")
                          .format(res!.deadline)),
                    ),
                  ],
                ),
                const TableRow(
                  children: [
                    SizedBox(height: 20),
                    SizedBox(height: 20),
                  ],
                ),
                TableRow(
                  children: [
                    Text(
                      "Notification",
                      style: mainTheme.textTheme.headlineSmall,
                    ),
                    TextButton(
                      onPressed: () {
                        DatePicker.showDateTimePicker(
                          context,
                          currentTime: res?.notificationDateTime ?? DateTime.now(),
                          minTime: DateTime.now(),
                          maxTime: res!.deadline,
                          onConfirm: (dateTime) {
                            setState(() {
                              res!.notificationDateTime = dateTime;
                            });
                          },
                        );
                      },
                      child: Text(res?.notificationDateTime == null
                          ? "Select notification date"
                          : DateFormat("dd.MM.yyyy hh:mm")
                          .format(res!.notificationDateTime!)),
                    ),
                  ],
                ),
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
