import '../../domain/entites/task.dart';


class TaskItemModel extends TaskItemEntity {
  TaskItemModel({
    required super.id,
    required super.title,
    required super.isDone,
  });

  factory TaskItemModel.fromJson(Map<String, dynamic> json) {

    return TaskItemModel(
      id: json['id'],
      title: json['item']?['name'] ?? '',
      isDone: json['is_done'] == 1,
    );
  }
}