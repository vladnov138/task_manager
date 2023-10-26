import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart';
import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';
import 'package:task_manager/models/task.dart';
import 'package:task_manager/services/NotificationService.dart';

import '../../../client/hive_names.dart';
import '../../../theme/theme.dart';

class AddingTaskScreen extends StatefulWidget {
  const AddingTaskScreen({super.key});

  @override
  State<AddingTaskScreen> createState() => _AddingTaskScreenState();
}

class _AddingTaskScreenState extends State<AddingTaskScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  List<String> categories = [
    'Study',
    'Job',
    'Rest',
    'Hobby',
    'Others',
  ];

  bool deadlineValidated = true;
  String? task;
  String details = '';
  String category = '';
  DateTime? deadline;
  DateTime? notificationDateTime;
  bool important = false;

  void validateAndSave() {
    final FormState? form = _formKey.currentState;
    if (form != null && form.validate() && deadline != null) {
      print('Form is valid');
      _onFormSubmit();
    } else {
      setState(() {
        deadlineValidated = !(deadline == null);
      });
      print('Form is invalid');
    }
  }

  @override
  Widget build(BuildContext context) {
    category = category == '' ? categories[0] : category;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Task'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Table(
                  columnWidths: const <int, TableColumnWidth>{
                    0: FlexColumnWidth(10),
                    1: FlexColumnWidth(20),
                  },
                  children: [
                    TableRow(
                      children: [
                        TableCell(
                          verticalAlignment: TableCellVerticalAlignment.middle,
                          child: Text(
                            "Task title",
                            style: mainTheme.textTheme.headlineSmall,
                          ),
                        ),
                        TextFormField(
                          validator: (value) {
                            print(value);
                            return value?.isEmpty ?? true
                                ? "Cannot be empty"
                                : null;
                          },
                          onChanged: (value) {
                            task = value;
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
                          "Details",
                          style: mainTheme.textTheme.headlineSmall,
                        ),
                        TextFormField(
                          onChanged: (value) {
                            details = value;
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
                          "Category",
                          style: mainTheme.textTheme.headlineSmall,
                        ),
                        DropdownButton(
                          value: category,
                          icon: const Icon(Icons.keyboard_arrow_down),
                          items: categories.map((String items) {
                            return DropdownMenuItem(
                              value: items,
                              child: Text(items),
                            );
                          }).toList(),
                          onChanged: (String? newValue) {
                            setState(() {
                              category = newValue!;
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
                          style: !deadlineValidated
                              ? ButtonStyle(
                                  shape: MaterialStateProperty.all(
                                      RoundedRectangleBorder(
                                          side: const BorderSide(
                                            color: Colors.red,
                                            width: 1,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(0))))
                              : null,
                          onPressed: () {
                            DatePicker.showDateTimePicker(
                              context,
                              currentTime: DateTime.now(),
                              minTime: DateTime.now(),
                              maxTime: DateTime(3000),
                              onConfirm: (dateTime) {
                                setState(() {
                                  deadline = dateTime;
                                });
                              },
                            );
                          },
                          child: Text(deadline == null
                              ? "Select date"
                              : DateFormat("dd.MM.yyyy hh:mm")
                                  .format(deadline!)),
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
                            if (deadline == null) {
                              setState(() {
                                deadlineValidated = false;
                              });
                              return;
                            }
                            DatePicker.showDateTimePicker(
                              context,
                              currentTime: DateTime.now(),
                              minTime: DateTime.now(),
                              maxTime: deadline,
                              onConfirm: (dateTime) {
                                setState(() {
                                  notificationDateTime = dateTime;
                                });
                              },
                            );
                          },
                          child: Text(notificationDateTime == null
                              ? "Select notification date"
                              : DateFormat("dd.MM.yyyy hh:mm")
                              .format(notificationDateTime!)),
                        ),
                      ],
                    ),
                  ],
                ),
                CheckboxListTile(
                  title: const Text("Important"),
                  controlAffinity: ListTileControlAffinity.leading,
                  onChanged: (bool? value) {
                    setState(() {
                      important = value ?? false;
                    });
                  },
                  value: important,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 25),
                  child: MaterialButton(
                    onPressed: validateAndSave,
                    color: Colors.blue,
                    minWidth: 200,
                    child: Text(
                      "Add",
                      style: mainTheme.textTheme.labelMedium,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _onFormSubmit() {
    Box<Task> contactsBox = Hive.box<Task>(HiveBoxes.task);
    int? pushId;
    if (notificationDateTime != null) {
      for (int i = contactsBox.values.length - 1; i > 0; i--) {
        int? lastNotificationId = contactsBox.values.toList()[i].notificationId;
        if (lastNotificationId != null) {
          pushId = lastNotificationId + 1;
        }
      }
    }
    contactsBox.add(Task(
        task: task!,
        details: details!,
        category: category,
        deadline: deadline!,
        important: important,
        complete: false,
        updated_at: DateTime.now(),
        notificationId: pushId,
        notificationDateTime: notificationDateTime));
    if (pushId != null) {
      GetIt.I<NotificationService>()
          .sendNotification(pushId, task!, details, notificationDateTime!);
    }
    Navigator.of(context).pop();
  }
}
