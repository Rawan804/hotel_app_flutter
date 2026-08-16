import 'package:bloc/bloc.dart';
import 'package:hotel_app/features/leave_request/domain/use_cases/add_leave_request_use_case.dart';
import 'package:flutter/material.dart';

import 'leave_request_state.dart';

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
  LeaveRequestCubit(this.addLeaveRequestUseCase)
      : super(LeaveRequestStateInitial());

  Future<void> addLeaveRequest() async {
    // تحقق محلي من الحقول قبل إرسال أي طلب للسيرفر
    if (startDate.text.isEmpty || endDate.text.isEmpty) {
      emit(LeaveRequestFailure('يرجى اختيار تاريخ البداية والنهاية'));
      return;
    }
    if (reason.text.trim().isEmpty) {
      emit(LeaveRequestFailure('يرجى كتابة سبب الإجازة'));
      return;
    }
    if (leaveType.text.trim().isEmpty) {
      emit(LeaveRequestFailure('يرجى تحديد نوع الإجازة'));
      return;
    }

    final DateTime? start = DateTime.tryParse(startDate.text);
    final DateTime? end = DateTime.tryParse(endDate.text);

    if (start == null || end == null) {
      emit(LeaveRequestFailure('صيغة التاريخ غير صحيحة'));
      return;
    }
    if (end.isBefore(start)) {
      emit(LeaveRequestFailure('تاريخ النهاية يجب أن يكون بعد تاريخ البداية'));
      return;
    }

    emit(LeaveRequestLoading());
    final result =
    await addLeaveRequestUseCase(start, end, reason.text, leaveType.text);
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
