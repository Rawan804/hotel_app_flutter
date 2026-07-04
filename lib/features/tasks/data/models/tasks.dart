import 'package:hotel_app/features/tasks/data/models/task_item_model.dart';

import '../../domain/entites/task.dart';

class TaskModel extends TaskEntity {
  TaskModel({
    required super.id,
    required super.title,
    required super.status,
    required super.items,
    required super.completedItems,
    required super.totalItems,
  });

  factory TaskModel.fromJson(Map<String, dynamic> json) {
    final items = (json['items'] as List<dynamic>).map((e) => TaskItemModel.fromJson(e)).toList();

    return TaskModel(
      id: json['id'] as int,
      title: json['fixed_task']['name'] as String,
      status: json['status'], // من الـ backend مباشرة
      items: items,
      completedItems: items.where((i) => i.isDone).length,
      totalItems: items.length,
    );
  }
}