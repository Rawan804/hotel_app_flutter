import 'package:equatable/equatable.dart';

class TaskEntity {
  final int id;
  final String title;
  final String status;
  final int completedItems;
  final int totalItems;
  final List<TaskItemEntity> items;

  const TaskEntity({
    required this.id,
    required this.title,
    required this.status,
    required this.completedItems,
    required this.totalItems,
    required this.items,
  });
  double get progress =>
      totalItems == 0 ? 0 : completedItems / totalItems;
  @override
  List<Object?> get props => [id, title, status, completedItems, totalItems, items];
}
class TaskItemEntity extends Equatable {
  final int id;
  final String title;
  final bool isDone;

  const TaskItemEntity({
    required this.id,
    required this.title,
    required this.isDone,
  });

  @override
  List<Object?> get props => [id, title, isDone];
}