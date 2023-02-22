import 'package:hive/hive.dart';
part 'task.g.dart';

@HiveType(typeId: 0)
class Task extends HiveObject {
  @HiveField(0)
  final String title;
  @HiveField(1)
  final String time;
  @HiveField(2)
  final String date;
  @HiveField(3)
  Status taskStatus;
  @HiveField(4)
  final String id;

  Task({
    required this.title,
    required this.time,
    required this.date,
    required this.taskStatus,
    required this.id,
  });
}

@HiveType(typeId: 1)
enum Status {
  @HiveField(0)
  done,
  @HiveField(1)
  todo,
  @HiveField(2)
  archived,
}
