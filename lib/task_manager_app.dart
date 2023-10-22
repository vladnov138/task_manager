import 'package:flutter/material.dart';

import 'router/router.dart';
import 'theme/theme.dart';

class TaskManagerApp extends StatelessWidget {
  const TaskManagerApp({super.key});

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