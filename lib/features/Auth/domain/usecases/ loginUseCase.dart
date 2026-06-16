import 'package:dartz/dartz.dart';
import 'package:hotel_app/core/error/failures.dart';
import 'package:hotel_app/features/Auth/domain/entities/User.dart';
import 'package:hotel_app/features/Auth/domain/repositories/auth_repositories.dart';

class LoginUseCase{
  final AuthRepositories authRepositories;
  LoginUseCase(this.authRepositories);
  Future<Either<Failure, User>>call(String email,String password){
    return authRepositories.login(email, password);
  }
}