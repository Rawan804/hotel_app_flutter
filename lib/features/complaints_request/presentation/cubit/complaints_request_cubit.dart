import 'package:bloc/bloc.dart';
import 'package:hotel_app/core/error/failures.dart';
import 'package:hotel_app/features/complaints_request/domain/use_cases/add_compliants_use_case.dart';
import 'package:meta/meta.dart';

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
  ComplaintsRequestCubit(this.addComplaintsUseCase) : super(ComplaintsRequestInitial());
  Future<void>addComplaints(String title,String description)async{
    emit(ComplaintsRequestLoading());
    final result =await addComplaintsUseCase(title,description);
    result.fold(
            (failure) {
          emit(ComplaintsRequestFailure(failure.toString()));
        },
          (_) {
        emit(ComplaintsRequestSuccess("تم إرسال الشكوى بنجاح"));
      },
    );
  }
}
