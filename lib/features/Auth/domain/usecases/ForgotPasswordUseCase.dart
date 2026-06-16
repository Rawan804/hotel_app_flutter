import 'package:dartz/dartz.dart';
import 'package:hotel_app/features/Auth/domain/repositories/auth_repositories.dart';

import '../../../../core/error/failures.dart';

class ForgetPasswordUseCase{
  final AuthRepositories authRepositories;
  ForgetPasswordUseCase(this.authRepositories);
  Future<Either<Failure, Unit>>call(String email){
    return authRepositories.forgetPassword(email);
  }
}