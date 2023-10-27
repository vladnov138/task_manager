import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:hive/hive.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task_manager/features/sign_in/view/sign_in_screen.dart';

import 'generated/l10n.dart';
import 'router/router.dart';
import 'theme/theme.dart';

class TaskManagerApp extends StatefulWidget {
  const TaskManagerApp({super.key});

  @override
  State<TaskManagerApp> createState() => _TaskManagerAppState();
}

class _TaskManagerAppState extends State<TaskManagerApp> {
  final _appRouter = AppRouter();

  @override
  void dispose() async {
    Hive.close();
    super.dispose();
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Task manager',
      localizationsDelegates: const [
        S.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: S.delegate.supportedLocales,
      theme: mainTheme,
      routerConfig: _appRouter.config(),
    );
  }
}