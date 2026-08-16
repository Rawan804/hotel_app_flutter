import 'package:dartz/dartz.dart';
import 'package:hotel_app/core/error/failures.dart';
import 'package:hotel_app/features/leave_request/data/data_sources/leave_remote_data_sources.dart';
import 'package:hotel_app/features/leave_request/domain/repositories/leave_request_repositories.dart';

import '../../../../core/error/exceptions.dart';

class LeaveRequestRepositoriesImpl implements LeaveRequestRepositories {
  final Leave_Remote_Data_Sources leave_remote_data_sources;
  LeaveRequestRepositoriesImpl({required this.leave_remote_data_sources});

  @override
  Future<Either<Failure, String>> addLeaveRequest(DateTime start_date,
      DateTime end_date, String reason, String type) async {
    try {
      final result = await leave_remote_data_sources.addLeaveRequest(
          start_date, end_date, reason, type);
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
