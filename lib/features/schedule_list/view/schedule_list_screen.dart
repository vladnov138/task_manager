import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get_it/get_it.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';
import 'package:task_manager/features/schedule_list/schedule_list.dart';
import 'package:task_manager/services/NotificationService.dart';

import '../../../client/hive_names.dart';
import '../../../models/task.dart';

@RoutePage()
class ScheduleListScreen extends StatefulWidget {
  const ScheduleListScreen({super.key});

  @override
  State<ScheduleListScreen> createState() => _ScheduleListScreenState();
}

class _ScheduleListScreenState extends State<ScheduleListScreen> {
  List<String> categories = [
    'All',
    'Study',
    'Job',
    'Rest',
    'Hobby',
    'Others',
  ];

  List<String> types = ['All', 'Completed', 'Overdue'];

  String category = '';
  String type = '';

  @override
  Widget build(BuildContext context) {
    category = category == '' ? categories[0] : category;
    type = type == '' ? types[0] : type;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Tasks"),
      ),
      body: Column(
        children: [
          Row(
            children: [
              DropdownButton(
                padding:
                    const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                value: category,
                icon: category == categories[0]
                    ? const Icon(Icons.filter_list_rounded)
                    : const Icon(Icons.filter_alt),
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
              DropdownButton(
                padding:
                    const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                value: type,
                icon: type == types[0]
                    ? const Icon(Icons.filter_list_rounded)
                    : const Icon(Icons.filter_alt),
                items: types.map((String items) {
                  return DropdownMenuItem(
                    value: items,
                    child: Text(items),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    type = newValue!;
                  });
                },
              ),
            ],
          ),
          ValueListenableBuilder(
              valueListenable: Hive.box<Task>(HiveBoxes.task).listenable(),
              builder: (context, Box<Task> box, _) {
                List<Task> sortered = box.values.toList();
                sortered.sort((a, b) => a.deadline.compareTo(b.deadline));
                if (category != categories[0]) {
                  sortered = sortered
                      .where((element) => element.category == category)
                      .toList();
                }
                if (type == types[1]) {
                  sortered =
                      sortered.where((element) => element.complete).toList();
                  print(type);
                } else if (type == types[2]) {
                  sortered = sortered
                      .where((element) =>
                          element.notificationDateTime != null &&
                          element.notificationDateTime!
                                  .compareTo(DateTime.now()) ==
                              -1)
                      .toList();
                }
                if (sortered.isEmpty) {
                  return const Center(
                    child: Text("Todo list is empty"),
                  );
                }
                return ListView.builder(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemCount: sortered.length,
                  itemBuilder: (context, index) {
                    Task? res = sortered[index];
                    return Dismissible(
                      background: Container(color: Colors.red),
                      key: UniqueKey(),
                      onDismissed: (direction) {
                        if (res.notificationId != null) {
                          GetIt.I<NotificationService>()
                              .cancelNotification(res.notificationId!);
                        }
                        res.delete();
                      },
                      child: ListTile(
                        title: Text(res.task ?? ''),
                        subtitle: Text(res.category),
                        leading: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(DateFormat('EEE, d').format(res.deadline) ??
                                  ''),
                              Text(DateFormat("hh:mm").format(res.deadline))
                            ]),
                        trailing: res.important
                            ? SvgPicture.asset(
                                "assets/important_icon.svg",
                                width: 25,
                                height: 25,
                              )
                            : null,
                        onTap: () {
                          Navigator.of(context)
                              .pushNamed("/task", arguments: res);
                        },
                      ),
                    );
                  },
                );
              }),
        ],
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
