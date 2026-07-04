import 'package:hotel_app/features/tasks/domain/entites/task.dart';
import 'package:equatable/equatable.dart';
sealed class TaskState {}

final class TaskInitial extends TaskState {}

final class TaskLoading extends TaskState {}



class TaskSuccses extends TaskState with EquatableMixin {
  final List<TaskEntity> tasks;
  final String filter;

  TaskSuccses({
    required this.tasks,
    this.filter = 'all',
  });

  @override
  List<Object?> get props => [tasks, filter];

  TaskSuccses copyWith({
    List<TaskEntity>? tasks,
    String? filter,
  }) {
    return TaskSuccses(
      tasks: tasks ?? this.tasks,
      filter: filter ?? this.filter,
    );
  }
}

class TaskToggle extends TaskState with EquatableMixin {
  final TaskEntity taskEntity;
  TaskToggle(this.taskEntity);

  @override
  List<Object?> get props => [taskEntity];
}

final class TaskFail extends TaskState {
  final String message;
  TaskFail({required this.message});
}

class TaskSelected extends TaskState {
  final int index;
  TaskSelected(this.index);
}

