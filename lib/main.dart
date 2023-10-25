import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'client/hive_names.dart';
import 'models/task.dart';
import 'task_manager_app.dart';

Future<void> main() async {
  await Hive.initFlutter();
  Hive.registerAdapter<Task>(TaskAdapter());
  await Hive.openBox<Task>(HiveBoxes.task);
  runApp(const TaskManagerApp());
}


