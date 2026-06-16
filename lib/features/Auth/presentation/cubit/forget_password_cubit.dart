import 'package:bloc/bloc.dart';
import 'package:hotel_app/features/Auth/domain/repositories/auth_repositories.dart';

import 'package:hotel_app/features/Auth/domain/usecases/ForgotPasswordUseCase.dart';
import 'package:meta/meta.dart';

part 'forget_password_state.dart';

class ForgetPasswordCubit extends Cubit<ForgetPasswordState> {
  final ForgetPasswordUseCase forgetPasswordUseCase;
  ForgetPasswordCubit(this.forgetPasswordUseCase)
      : super(ForgetPasswordLoading());

  Future<void>forgetpassword(String email)async{
    emit(ForgetPasswordLoading());
    final result=await forgetPasswordUseCase(email);
    result.fold(
          (failure) {
        emit(ForgetPasswordFail());
      },
          (success) {
        emit(ForgetPasswordSuccess());
      },
    );
  }
}
