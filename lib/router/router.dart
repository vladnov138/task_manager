import 'package:task_manager/features/adding_task/adding_task.dart';
import 'package:task_manager/features/schedule_list/schedule_list.dart';
import 'package:task_manager/features/sign_in/view/sign_in_screen.dart';
import 'package:task_manager/features/task/view/task_screen.dart';

import '../features/sign_up/sign_up.dart';

final routes = {
  '/': (context) => const ScheduleListScreen(),
  '/sign_in': (context) => const SignInScreen(),
  '/sign_up': (context) => const SignUpScreen(),
  '/task': (context) => TaskScreen(),
  '/add_task': (context) => const AddingTaskScreen(),
};