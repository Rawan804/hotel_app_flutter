import 'package:dartz/dartz.dart';
import 'package:hotel_app/core/error/failures.dart';
import 'package:hotel_app/features/Auth/domain/entities/User.dart';
import 'package:hotel_app/features/Auth/domain/repositories/auth_repositories.dart';

class Logoutusecase{
  final AuthRepositories authRepositories;
  Logoutusecase(this.authRepositories);
  Future<Either<Failure, Unit>>call(){
    return authRepositories.logout();
  }
}