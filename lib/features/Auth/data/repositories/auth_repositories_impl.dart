import 'package:dartz/dartz.dart';
import 'package:hotel_app/core/error/failures.dart';
import 'package:hotel_app/features/Auth/data/datasource/auth_local_datasource.dart';
import 'package:hotel_app/features/Auth/data/datasource/auth_remote_datasource.dart';
import 'package:hotel_app/features/Auth/domain/entities/User.dart';
import 'package:hotel_app/features/Auth/domain/repositories/auth_repositories.dart';

import '../../../../core/error/ exceptions.dart';

class AuthRepositoryImpl implements AuthRepositories{
final AuthRemoteDataSource authRemoteDataSource;
final AuthLocalDataSource authLocalDataSource;
AuthRepositoryImpl({
  required this.authRemoteDataSource,
  required this.authLocalDataSource
});

@override
Future<Either<Failure,User>> login(String email, String password)async {
try{
  final userModel=await authRemoteDataSource.login(email, password);


  await authLocalDataSource.saveToken(
    userModel.token,
  );
  return Right(userModel);
}on ServerException {
  return left(ServerFailure());
}
}
@override
Future<Either<Failure, Unit>> forgetPassword(String email)async {
try{
  final result=await authRemoteDataSource.forgetPassword(email);
  return Right(result);
}on ServerException{
  return left(ServerFailure());
}
}
@override
Future<Either<Failure, Unit>> resend_OTP(String email)async {
  try{
    final result=await authRemoteDataSource.forgetPassword(email);
    return Right(result);
  }on ServerException{
    return left(ServerFailure());
  }
}
@override
Future<Either<Failure, bool>> verifyOtp(String email, String otp)async {
try{
  final result =await authRemoteDataSource.verifyOtp(email, otp);
  return Right(result);
}on ServerException{
  return left(ServerFailure());
}
}

  @override
  Future<Either<Failure, User>> createNewPassword(String email, String otp, String password )async {
    try{
      final userModel=await authRemoteDataSource.createNewPassword(email, otp,password);
      await authLocalDataSource.saveToken(
        userModel.token,
      );
      return Right(userModel);
    }on ServerException {
      return left(ServerFailure());
    }
  }

}