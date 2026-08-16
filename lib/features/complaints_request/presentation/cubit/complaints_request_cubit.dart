import 'package:bloc/bloc.dart';
import 'package:hotel_app/features/complaints_request/domain/use_cases/add_compliants_use_case.dart';

import 'complaints_request_state.dart';
import 'package:flutter/material.dart';

class ComplaintsRequestCubit extends Cubit<ComplaintsRequestState> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descController = TextEditingController();

  @override
  Future<void> close() {
    titleController.dispose();
    descController.dispose();
    return super.close();
  }

  void clearFields() {
    titleController.clear();
    descController.clear();
  }

  final AddComplaintsUseCase addComplaintsUseCase;
  ComplaintsRequestCubit(this.addComplaintsUseCase)
      : super(ComplaintsRequestInitial());

  Future<void> addComplaints() async {
    if (titleController.text.trim().isEmpty) {
      emit(ComplaintsRequestFailure('يرجى كتابة عنوان الشكوى'));
      return;
    }
    if (descController.text.trim().isEmpty) {
      emit(ComplaintsRequestFailure('يرجى كتابة وصف الشكوى'));
      return;
    }

    emit(ComplaintsRequestLoading());
    final result = await addComplaintsUseCase(
      titleController.text.trim(),
      descController.text.trim(),
    );
    result.fold(
          (failure) {
        emit(ComplaintsRequestFailure(failure.message));
      },
          (_) {
        emit(ComplaintsRequestSuccess("تم إرسال الشكوى بنجاح"));
      },
    );
  }
}
