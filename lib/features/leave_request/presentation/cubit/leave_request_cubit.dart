import 'package:bloc/bloc.dart';
import 'package:hotel_app/core/error/failures.dart';
import 'package:hotel_app/features/complaints_request/domain/use_cases/add_compliants_use_case.dart';
import 'package:hotel_app/features/leave_request/domain/use_cases/add_leave_request_use_case.dart';
import 'package:meta/meta.dart';

import 'leave_request_state.dart';
import 'package:flutter/material.dart';



class LeaveRequestCubit extends Cubit<LeaveRequestState> {

  final TextEditingController startDate = TextEditingController();
  final TextEditingController endDate = TextEditingController();
  final TextEditingController reason = TextEditingController();
  final TextEditingController leaveType = TextEditingController();

  @override
  Future<void> close() {
    startDate.dispose();
    endDate.dispose();
    reason.dispose();
    leaveType.dispose();
    return super.close();
  }
  void clearFields() {
    startDate.clear();
    endDate.clear();
    reason.clear();
    leaveType.clear();
  }
  final AddLeaveRequestUseCase addLeaveRequestUseCase;
  LeaveRequestCubit(this.addLeaveRequestUseCase) : super(LeaveRequestStateInitial());
  Future<void>addLeaveRequest(DateTime start_date, DateTime end_date, String reason, String type)async{
    emit(LeaveRequestLoading());
    final result =await addLeaveRequestUseCase(start_date,end_date,reason,type);
    result.fold(
          (failure) {
        emit(LeaveRequestFailure(failure.toString()));
      },
          (message) {  // ← بدل _ خليها تستقبل القيمة
        emit(LeaveRequestSuccess(message));
      },
    );
  }
}
