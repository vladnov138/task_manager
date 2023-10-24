import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:task_manager/models/task.dart';

import 'client/hive_names.dart';
import 'task_manager_app.dart';

Future<void> main() async {
  await Hive.initFlutter();
  await Hive.openBox<Task>(HiveBoxes.task);
  Hive.registerAdapter(TaskAdapter());
  runApp(const TaskManagerApp());
}


