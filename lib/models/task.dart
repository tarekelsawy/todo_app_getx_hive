import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';

@HiveType(typeId: 0)
class Task extends Equatable {
  @HiveField(0)
  final String title;
  @HiveField(1)
  final DateTime time;
  @HiveField(2)
  final DateTime date;
  @HiveField(3)
  final Status taskStatus;

  const Task({
    required this.title,
    required this.time,
    required this.date,
    required this.taskStatus,
  });

  @override
  List<Object> get props => [title, time, date, taskStatus];
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
