import 'package:dartz/dartz.dart';
import 'package:hotel_app/core/error/failures.dart';
import 'package:hotel_app/features/Auth/domain/repositories/auth_repositories.dart';

import '../entities/User.dart';

class ResetPasswordUseCase{
  final AuthRepositories authRepositories;
  ResetPasswordUseCase(this.authRepositories);
  Future<Either<Failure,User>>call(String email,String otp ,String password){
    return authRepositories.createNewPassword(email,otp, password);
  }
}