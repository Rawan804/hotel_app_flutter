import 'package:dartz/dartz.dart';
import 'package:hotel_app/core/error/failures.dart';
import 'package:hotel_app/features/complaints_request/data/data_sources/complaint_remote_data_sources.dart';
import 'package:hotel_app/features/complaints_request/domain/repositories/complaints_repositories.dart';

import '../../../../core/error/exceptions.dart';

class ComplaintsRepositoriesImpl implements ComplaintsRepositories {
  final ComplaintsRemoteDataSources complaintsRemoteDataSources;
  ComplaintsRepositoriesImpl({required this.complaintsRemoteDataSources});

  @override
  Future<Either<Failure, Unit>> addComplaint(String title, String description) async {
    try {
      final result = await complaintsRemoteDataSources.addComplaint(title, description);
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } on NetworkException catch (e) {
      return Left(NetworkFailure(e.message));
    } on ValidationException catch (e) {
      return Left(ValidationFailure(e.message));
    } on UnauthorizedException catch (e) {
      return Left(UnauthorizedFailure(e.message));
    }
  }
}
