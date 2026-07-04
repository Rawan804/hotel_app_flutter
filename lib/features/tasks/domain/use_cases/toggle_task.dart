import 'package:dartz/dartz.dart';
import 'package:hotel_app/core/error/failures.dart';
import 'package:hotel_app/features/tasks/domain/entites/task.dart';
import 'package:hotel_app/features/tasks/domain/repositories/task_repositories.dart';

class ToggleTaskUseCase{
  final TaskRepositories taskRepositories;
  ToggleTaskUseCase(this.taskRepositories);
  Future<Either<Failure,TaskEntity>>call(int id)async{
    return await taskRepositories.toggleTask(id);
  }
}