import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart';
import 'package:hive/hive.dart';
import 'package:task_manager/models/task.dart';

import '../../../client/hive_names.dart';
import '../../../theme/theme.dart';

class AddingTaskScreen extends StatefulWidget {
  const AddingTaskScreen({super.key});

  @override
  State<AddingTaskScreen> createState() => _AddingTaskScreenState();
}

class _AddingTaskScreenState extends State<AddingTaskScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool test = false;
  String? task;
  String? details;
  DateTime? deadline;
  bool important = false;

  void validateAndSave() {
    final FormState? form = _formKey.currentState;
    if (form != null && form.validate()) {
      print('Form is valid');
      _onFormSubmit();
    } else {
      print('Form is invalid');
    }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Task'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
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
                          setState(() {
                            task = value;
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
                        "Details",
                        style: mainTheme.textTheme.headlineSmall,
                      ),
                      TextFormField(
                        onChanged: (value) {
                          setState(() {
                            details = value;
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
                              // dateFormat: 'dd MMMM yyyy HH:mm',
                              currentTime: DateTime.now(),
                              minTime: DateTime(2000),
                              maxTime: DateTime(3000),
                              // onMonthChangeStartWithFirstDate: true,
                              onConfirm: (dateTime) {
                                print(dateTime);
                                deadline = dateTime;
                              },
                            );
                          },
                          child: const Text("Date"),
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
    );
  }

  void _onFormSubmit() {
    Box<Task> contactsBox = Hive.box<Task>(HiveBoxes.task);
    print(task);
    print(details);
    print(deadline);
    contactsBox.add(
        Task(
            task: task!,
            details: details!,
            deadline: deadline!,
            important: important,
            complete: false,
            updated_at: DateTime.now())
    );
    Navigator.of(context).pop();
  }
}
