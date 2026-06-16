import 'package:dartz/dartz.dart';
import 'package:hotel_app/core/error/failures.dart';
import 'package:hotel_app/features/Auth/domain/repositories/auth_repositories.dart';

class VerifyOtpUseCase{
  final AuthRepositories authRepositories;
  VerifyOtpUseCase(this.authRepositories);
  Future<Either<Failure, bool>>call(String email,String otp){
    return authRepositories.verifyOtp(email,otp);
  }
}