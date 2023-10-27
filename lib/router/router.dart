import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:task_manager/features/adding_task/adding_task.dart';
import 'package:task_manager/features/profile/view/profile_screen.dart';
import 'package:task_manager/features/schedule_list/schedule_list.dart';
import 'package:task_manager/features/sign_in/view/sign_in_screen.dart';
import 'package:task_manager/features/task/view/task_screen.dart';
import 'package:task_manager/router/guard/auth_guard.dart';

import '../features/sign_up/sign_up.dart';
import '../models/task.dart';

part 'router.gr.dart';

@AutoRouterConfig()
class AppRouter extends _$AppRouter {

  @override
  List<AutoRoute> get routes => [
    AutoRoute(page: SignInRoute.page),
    AutoRoute(page: SignUpRoute.page),
    AutoRoute(page: ProfileRoute.page, initial: true, guards: [AuthGuard()]),
    AutoRoute(page: ScheduleListRoute.page),
    AutoRoute(page: TaskRoute.page),
    AutoRoute(page: AddingTaskRoute.page),
  ];
}
