import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart';
import 'package:intl/intl.dart';
import 'package:task_manager/theme/theme.dart';

import '../../../generated/l10n.dart';
import '../../../models/task.dart';
import '../widgets/detail_text_widget.dart';

@RoutePage()
class TaskScreen extends StatefulWidget {
  const TaskScreen({super.key, required this.task});

  final Task? task;

  @override
  State<TaskScreen> createState() => _TaskScreenState();
}

class _TaskScreenState extends State<TaskScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  late List<String> categories;

  @override
  void initState() {
    super.initState();

  }

  Task? task;
  bool deadlineValidated = true;
  String title = '';
  String details = '';
  String category = '';
  DateTime? deadline;
  DateTime? notificationDateTime;
  bool complete = false;

  @override
  Widget build(BuildContext context) {
    categories = [
      S.of(context).study,
      S.of(context).job,
      S.of(context).rest,
      S.of(context).hobby,
      S.of(context).others,
    ];
    task = widget.task;
    title = task!.task;
    details = task?.details ?? "";
    category = task!.category;
    deadline = task!.deadline;
    notificationDateTime = task?.notificationDateTime;
    complete = task!.complete;
    return Scaffold(
      appBar: AppBar(title: const Text('Task')),
      body: Padding(
          padding: const EdgeInsets.all(20),
          child: Form(
              key: _formKey,
              child: SingleChildScrollView(
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
                          S.of(context).taskTitle,
                          style: mainTheme.textTheme.headlineSmall,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 0),
                        child: TextFormField(
                          initialValue: title,
                          validator: (value) {
                            return value?.isEmpty ?? true
                                ? S.of(context).cannotBeEmpty
                                : null;
                          },
                          onChanged: (value) {
                            title = value;
                          },
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
                        TextFormField(
                          initialValue: details,
                          onChanged: (value) {
                            details = value;
                          },
                        ),
                      ],
                    ),
                    const TableRow(children: [
                      SizedBox(height: 20),
                      SizedBox(height: 20),
                    ]),
                    TableRow(
                      children: [
                        Text(
                          S.of(context).category,
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
                          S.of(context).deadline,
                          style: mainTheme.textTheme.headlineSmall,
                        ),
                        TextButton(
                          onPressed: () {
                            DatePicker.showDateTimePicker(
                              context,
                              currentTime: deadline?.toLocal(),
                              minTime: DateTime.now().toLocal(),
                              maxTime: DateTime(3000).toLocal(),
                              onConfirm: (dateTime) {
                                setState(() {
                                  deadline = dateTime;
                                });
                              },
                            );
                          },
                          child: Text(DateFormat("dd.MM.yyyy hh:mm")
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
                          S.of(context).notification,
                          style: mainTheme.textTheme.headlineSmall,
                        ),
                        TextButton(
                          onPressed: () {
                            DatePicker.showDateTimePicker(
                              context,
                              currentTime: notificationDateTime ??
                                  DateTime.now().toLocal(),
                              minTime: DateTime.now().toLocal(),
                              maxTime: deadline?.toLocal(),
                              onConfirm: (dateTime) {
                                setState(() {
                                  notificationDateTime = dateTime;
                                });
                              },
                            );
                          },
                          child: Text(notificationDateTime == null
                              ? S.of(context).selectNotificationDate
                              : DateFormat("dd.MM.yyyy hh:mm")
                                  .format(notificationDateTime!)),
                        ),
                      ],
                    ),
                  ],
                ),
                CheckboxListTile(
                  title: Text(S.of(context).completed),
                  controlAffinity: ListTileControlAffinity.leading,
                  onChanged: (bool? value) {
                    setState(() {
                      complete = !complete;
                    });
                  },
                  value: complete,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 25),
                  child: MaterialButton(
                    onPressed: () {
                      validateAndSave();
                    },
                    color: mainTheme.primaryColor,
                    minWidth: 200,
                    child: Text(
                      S.of(context).save,
                      style: mainTheme.textTheme.labelMedium,
                    ),
                  ),
                ),
              ])))),
    );
  }

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

  void _onFormSubmit() {
    task!.task = title;
    task!.details = details;
    task!.category = category;
    task!.deadline = deadline!;
    task!.complete = complete;
    task!.updated_at = DateTime.now().toLocal();
    // task!.notificationId = tas;
    task!.notificationDateTime = notificationDateTime;
    task?.save();
    Navigator.of(context).pop();
  }
}
