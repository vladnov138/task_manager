import 'package:hive/hive.dart';
import 'package:intl/intl.dart';

import '../client/hive_names.dart';
import '../models/task.dart';

class JsonSerializerService {
  List<Map<String, String>> toJson() {
    Box<Task> box = Hive.box<Task>(HiveBoxes.task);
    Map<String, dynamic> json;
    List<Map<String, String>> data =
        List.generate(box.values.length, (index) => {});
    List<Task> values = box.values.toList();
    for (Task task in values) {
      data.add({
        "title": task.task,
        "details": task.details,
        "category": task.category,
        "deadline": task.deadline.toString(),
        "complete": task.complete.toString(),
        "updated_at": task.updated_at.toString(),
        "notification_id": task.notificationId.toString(),
        "notification_datetime": task.notificationDateTime.toString(),
      });
    }
    return data;
  }

  void fromJson(List<dynamic> data) {
    Box<Task> box = Hive.box<Task>(HiveBoxes.task);
    for (Map<String, dynamic> task in data) {
      print(task['title']);
      if (task['title'] != null) {
        box.add(Task(
            task: task['title']!,
            details: task['details']!,
            category: task['category']!,
            deadline: DateTime.parse(task['deadline']!),
            important: false,
            complete: bool.parse(task['complete']!),
            updated_at: DateTime.now().toLocal(),
            notificationId: null,
            notificationDateTime: null));
      }
    }
  }
}
