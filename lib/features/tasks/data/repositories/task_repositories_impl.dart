
import 'package:dartz/dartz.dart';
import 'package:hotel_app/core/error/exceptions.dart';
import 'package:hotel_app/core/error/failures.dart';
import 'package:hotel_app/features/tasks/data/data_sources/task_locale_data_sources.dart';
import 'package:hotel_app/features/tasks/data/data_sources/task_remote_data_sources.dart';
import 'package:hotel_app/features/tasks/domain/entites/task.dart';
import 'package:hotel_app/features/tasks/domain/repositories/task_repositories.dart';

class TaskRepositoriesImpl implements TaskRepositories {
  final TaskRemoteDataSource taskRemoteDataSource;
  final TasksLocaleDataSource tasksLocaleDataSource;

  TaskRepositoriesImpl({
    required this.taskRemoteDataSource,
    required this.tasksLocaleDataSource,
  });

  @override
  Future<Either<Failure, List<TaskEntity>>> getTask() async {
    try {
      final remotetaske = await taskRemoteDataSource.getTask();
      return Right(remotetaske);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } on NetworkException catch (e) {
      return Left(NetworkFailure(e.message));
    } on UnauthorizedException catch (e) {
      return Left(UnauthorizedFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, TaskEntity>> toggleTask(int id) async {
    try {
      final remotetaske = await taskRemoteDataSource.toggleTask(id);
      return Right(remotetaske);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } on NetworkException catch (e) {
      return Left(NetworkFailure(e.message));
    } on UnauthorizedException catch (e) {
      return Left(UnauthorizedFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, void>> EndTask(int id) async {
    try {
      await taskRemoteDataSource.endTask(id);
      return const Right(null);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } on NetworkException catch (e) {
      return Left(NetworkFailure(e.message));
    } on UnauthorizedException catch (e) {
      return Left(UnauthorizedFailure(e.message));
    }
  }
}
