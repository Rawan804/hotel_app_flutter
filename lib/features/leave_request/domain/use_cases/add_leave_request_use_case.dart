import 'package:dartz/dartz.dart';
import 'package:hotel_app/core/error/failures.dart';

import '../repositories/leave_request_repositories.dart';

class AddLeaveRequestUseCase{
  final LeaveRequestRepositories leaveRequestRepositories;
  AddLeaveRequestUseCase( this.leaveRequestRepositories);
  Future<Either<Failure,String>>call(DateTime start_date,DateTime end_date,String reason,String type)async{
    return leaveRequestRepositories.addLeaveRequest(start_date, end_date, reason, type);
  }
}