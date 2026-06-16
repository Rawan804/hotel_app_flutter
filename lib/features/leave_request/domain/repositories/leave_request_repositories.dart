import 'package:dartz/dartz.dart';
import 'package:hotel_app/core/error/failures.dart';

abstract class LeaveRequestRepositories{
  Future<Either<Failure,String>>addLeaveRequest(DateTime start_date,DateTime end_date,String reason,String type);
}