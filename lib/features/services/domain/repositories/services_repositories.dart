import 'package:dartz/dartz.dart';
import 'package:hotel_app/core/error/failures.dart';
import 'package:hotel_app/features/services/domain/entites/services.dart';
import 'package:hotel_app/features/tasks/data/models/tasks.dart';
import 'package:hotel_app/features/tasks/domain/entites/task.dart';
abstract class ServicesRepositories{
  Future<Either<Failure,List<ServiceEntity>>>getService();
  Future<Either<Failure,ServiceEntity>>StartService(int id);
  Future<Either<Failure,ServiceEntity>>EndService(int id);
}
