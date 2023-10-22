import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart';

import '../../../theme/theme.dart';
import '../../task/widgets/detail_text_widget.dart';

class AddingTaskScreen extends StatefulWidget {
  const AddingTaskScreen({super.key});

  @override
  State<AddingTaskScreen> createState() => _AddingTaskScreenState();
}

class _AddingTaskScreenState extends State<AddingTaskScreen> {

  bool test = false;

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
                      initialValue: "",
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
                    const DetailTextWidget(text: "")
                  ],
                ),
                const TableRow(children: [
                  SizedBox(height: 20),
                  SizedBox(height: 20),
                ],),
                TableRow(children: [
                  Text(
                    "Deadline",
                    style: mainTheme.textTheme.headlineSmall,
                  ),
                  TextButton(onPressed: () {
                    DatePicker.showDateTimePicker(
                      context,
                      // dateFormat: 'dd MMMM yyyy HH:mm',
                      currentTime: DateTime.now(),
                      minTime: DateTime(2000),
                      maxTime: DateTime(3000),
                      // onMonthChangeStartWithFirstDate: true,
                      onConfirm: (dateTime) {
                        DateTime selectdate = dateTime;
                        // final selIOS = DateTime.for('dd-MMM-yyyy - HH:mm').format(selectdate);
                        print(dateTime);
                      },);
                  }, child: Text("Date")),
                ])
              ],
            ),
            CheckboxListTile(
              title: const Text("Important"),
              controlAffinity: ListTileControlAffinity.leading,
              onChanged: (bool? value) {
                setState(() {
                  test = value ?? false;
                });
              },
              value: test,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 25),
              child: MaterialButton(
                onPressed: () {
                  Navigator.of(context).pushNamed(
                    '/task',
                  );
                },
                color: Colors.blue,
                minWidth: 200,
                child: Text(
                  "Add",
                  style: mainTheme.textTheme.labelMedium,
                ),
              ),
            ),
          ])),
    );
  }
}
