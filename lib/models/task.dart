import 'package:hive/hive.dart';

part 'task.g.dart';

@HiveType(typeId: 0)
class Task extends HiveObject {
  @HiveField(0)
  String task;
  @HiveField(1)
  String details;
  @HiveField(2)
  String category;
  @HiveField(3)
  DateTime deadline;
  @HiveField(4)
  bool important;
  @HiveField(5)
  bool complete;
  @HiveField(6)
  DateTime updated_at;
  @HiveField(7)
  int notificationId;

  Task(
      {required this.task,
      required this.details,
      required this.category,
      required this.deadline,
      required this.important,
      required this.complete,
      required this.updated_at,
      required this.notificationId});
}
