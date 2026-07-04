import 'package:dartz/dartz.dart';
import 'package:hotel_app/core/error/failures.dart';
import 'package:hotel_app/features/tasks/domain/entites/task.dart';
import 'package:hotel_app/features/tasks/domain/repositories/task_repositories.dart';

class EndTaskUseCase{
  final  TaskRepositories taskRepositories;
  EndTaskUseCase(this.taskRepositories);
  Future<Either<Failure,void>>call(int id)async{
   return await taskRepositories.EndTask(id);
  }
}