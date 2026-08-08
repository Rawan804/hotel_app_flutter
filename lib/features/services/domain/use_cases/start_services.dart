import 'package:dartz/dartz.dart';
import 'package:hotel_app/core/error/failures.dart';
import 'package:hotel_app/features/services/domain/entites/services.dart';
import 'package:hotel_app/features/services/domain/repositories/services_repositories.dart';
import 'package:hotel_app/features/tasks/domain/entites/task.dart';
import 'package:hotel_app/features/tasks/domain/repositories/task_repositories.dart';

class StartServiceUseCase{
  final ServicesRepositories servicesRepositories;
  StartServiceUseCase(this.servicesRepositories);
  Future<Either<Failure,ServiceEntity>>call(int id)async{
    return await servicesRepositories.StartService(id);
  }
}