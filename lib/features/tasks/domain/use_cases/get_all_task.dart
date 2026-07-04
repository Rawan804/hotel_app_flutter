import 'package:dartz/dartz.dart';
import 'package:hotel_app/core/error/failures.dart';
import 'package:hotel_app/features/tasks/domain/entites/task.dart';
import 'package:hotel_app/features/tasks/domain/repositories/task_repositories.dart';

class GetAllTaskUseCase{
  final TaskRepositories taskRepositories;
  GetAllTaskUseCase(this.taskRepositories);
  Future<Either<Failure,List<TaskEntity>>>call()async{
    return await taskRepositories.getTask();
  }
}