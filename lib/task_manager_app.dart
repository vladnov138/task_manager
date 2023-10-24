import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import 'router/router.dart';
import 'theme/theme.dart';

class TaskManagerApp extends StatefulWidget {
  const TaskManagerApp({super.key});

  @override
  State<TaskManagerApp> createState() => _TaskManagerAppState();
}

class _TaskManagerAppState extends State<TaskManagerApp> {
  @override
  void dispose() async {
    Hive.close();
    super.dispose();
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Task manager',
      theme: mainTheme,
      routes: routes,
    );
  }
}