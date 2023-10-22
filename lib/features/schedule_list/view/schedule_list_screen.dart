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
      body: Padding(
        padding: const EdgeInsets.only(top: 15, left: 15, right: 15),
        child: Column(
          children: [
            Table(
              columnWidths: const <int, TableColumnWidth>{
                0: FlexColumnWidth(15),
                1: FlexColumnWidth(80),
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
                      child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: const TaskTitleWidget()),
                    ),
                  ),
                  const TableCell(
                      verticalAlignment: TableCellVerticalAlignment.middle,
                      child: Text("!"))
                ])
              ],
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pushNamed('/add_task');
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
