import 'package:dartz/dartz.dart';
import 'package:hotel_app/core/error/failures.dart';
import 'package:hotel_app/features/tasks/data/models/tasks.dart';
import 'package:hotel_app/features/tasks/domain/entites/task.dart';
abstract class TaskRepositories{
Future<Either<Failure,List<TaskEntity>>>getTask();
Future<Either<Failure,TaskEntity>>toggleTask(int id);
Future<Either<Failure,void>>EndTask(int id);
}
