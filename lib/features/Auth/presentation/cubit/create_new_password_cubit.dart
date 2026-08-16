import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hotel_app/core/services.dart';
import 'package:hotel_app/features/Auth/presentation/cubit/create_new_password_state.dart';

import '../../domain/usecases/ResetPasswordUseCase.dart';

class PasswordCubit extends Cubit<PasswordState> {
  final ResetPasswordUseCase resetPasswordUseCase;
  PasswordCubit(this.resetPasswordUseCase) : super(const PasswordState());

  Future<void> resetpassword(String email,String otp,String password)async{
    emit(NewPasswordLoading());
    final result =await resetPasswordUseCase(email,otp,password);
    result.fold(
          (failure) {
        emit(NewPasswordFail(failure.message));
      },
          (_) {
        emit(NewPasswordSuccess());
        NotificationService.sendCurrentTokenToBackend();
      },
    );
  }
  void passwordChanged(String value) {
    emit(
      state.copyWith(
        password: value,
        hasUpper: value.contains(RegExp(r'[A-Z]')),
        hasLower: value.contains(RegExp(r'[a-z]')),
        hasNumber: value.contains(RegExp(r'[0-9]')),
        hasSpecial:
        value.contains(RegExp(r'[!@#\$%^&*(),.?":{}|<>]')),
        hasLength: value.length >= 8,
        isMatch: value == state.confirmPassword,
      ),
    );
  }

  void confirmPasswordChanged(String value) {
    emit(
      state.copyWith(
        confirmPassword: value,
        isMatch: value == state.password,
      ),
    );
  }
}