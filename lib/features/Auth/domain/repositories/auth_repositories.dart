import 'package:dartz/dartz.dart';
import 'package:hotel_app/core/error/failures.dart';
import 'package:hotel_app/features/Auth/domain/entities/User.dart';

abstract class AuthRepositories {
  Future<Either<Failure, User>> login(String email, String password);

  Future<Either<Failure, Unit>> forgetPassword(String email);
  Future<Either<Failure, Unit>> resend_OTP(String email);
  Future<Either<Failure, bool>> verifyOtp(String email, String otp);

  Future<Either<Failure, User>>createNewPassword(
      String email, String otp , String password);
}