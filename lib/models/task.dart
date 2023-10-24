import 'package:hive/hive.dart';

part 'task.g.dart';

@HiveType(typeId: 0)
class Task extends HiveObject {
  @HiveField(0)
  String task;
  @HiveField(1)
  String details;
  @HiveField(2)
  DateTime deadline;
  @HiveField(3)
  bool important;
  @HiveField(4)
  bool complete;
  @HiveField(5)
  DateTime updated_at;

  Task({required this.task, required this.details, required this.deadline,
    required this.important, required this.complete, required this.updated_at});
}