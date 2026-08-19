import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:hotel_app/features/leave_request/domain/use_cases/add_leave_request_use_case.dart';

import 'leave_request_state.dart';

class LeaveRequestCubit extends Cubit<LeaveRequestState> {
  final AddLeaveRequestUseCase addLeaveRequestUseCase;

  final TextEditingController startDate = TextEditingController();
  final TextEditingController endDate = TextEditingController();
  final TextEditingController reason = TextEditingController();
  final TextEditingController leaveType = TextEditingController();

  LeaveRequestCubit(this.addLeaveRequestUseCase)
      : super(LeaveRequestStateInitial());

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

  Future<void> addLeaveRequest() async {
    // تحقق محلي من الحقول قبل إرسال الطلب للسيرفر
    if (startDate.text.isEmpty || endDate.text.isEmpty) {
      emit(LeaveRequestFailure('leaveDatesRequired'));
      return;
    }

    if (reason.text.trim().isEmpty) {
      emit(LeaveRequestFailure('leaveReasonRequired'));
      return;
    }

    if (leaveType.text.trim().isEmpty) {
      emit(LeaveRequestFailure('leaveTypeRequired'));
      return;
    }

    final DateTime? start = DateTime.tryParse(startDate.text);
    final DateTime? end = DateTime.tryParse(endDate.text);

    if (start == null || end == null) {
      emit(LeaveRequestFailure('invalidDateFormat'));
      return;
    }

    if (end.isBefore(start)) {
      emit(LeaveRequestFailure('endDateAfterStartDate'));
      return;
    }

    emit(LeaveRequestLoading());

    final result = await addLeaveRequestUseCase(
      start,
      end,
      reason.text,
      leaveType.text,
    );

    result.fold(
          (failure) {
        emit(LeaveRequestFailure(failure.message));
      },
          (message) {
        emit(LeaveRequestSuccess(message));
      },
    );
  }
}