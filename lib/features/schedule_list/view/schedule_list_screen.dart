import 'package:flutter/material.dart';
import 'package:task_manager/features/schedule_list/schedule_list.dart';

class ScheduleListScreen extends StatelessWidget {
  const ScheduleListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Tasks"),
      ),
      body: Column(
        children: [
          Table(
            columnWidths: const <int, TableColumnWidth>{
              0: FlexColumnWidth(15),
              1: FlexColumnWidth(40),
              2: FlexColumnWidth(5),
            },
            children: [
              TableRow(children: [
                const TableCell(
                    verticalAlignment: TableCellVerticalAlignment.middle,
                    child: DateWidget(date: "Tue, 29")),
                TableCell(
                  verticalAlignment: TableCellVerticalAlignment.middle,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.of(context).pushNamed('/task');
                    },
                    child: Expanded(
                      child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          child: TaskTitleWidget()),
                    ),
                  ),
                ),
                TableCell(
                    verticalAlignment: TableCellVerticalAlignment.middle,
                    child: Text("!"))
              ])
            ],
          )
        ],
      ),
    );
  }
}
