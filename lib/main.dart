import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:task_manager/repository/abstract_repository.dart';
import 'package:task_manager/services/NotificationService.dart';

import 'client/hive_names.dart';
import 'models/task.dart';
import 'models/user/user.dart';
import 'repository/repository.dart';
import 'task_manager_app.dart';

Future<void> main() async {
  await Hive.initFlutter();
  Hive.registerAdapter<Task>(TaskAdapter());
  await Hive.openBox<Task>(HiveBoxes.task);
  GetIt.I.registerLazySingleton<NotificationService>(
          () => NotificationService());
  GetIt.I<NotificationService>().initilizeNotifications();
  GetIt.I.registerLazySingleton<AbstractRepository>(
          () => Repository(dio: Dio()));
  runApp(const TaskManagerApp());
}




