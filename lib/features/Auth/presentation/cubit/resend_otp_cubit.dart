import 'package:bloc/bloc.dart';
import 'package:hotel_app/features/Auth/domain/usecases/resend_otp_use_case.dart';
import 'package:hotel_app/features/Auth/presentation/cubit/resend_otp_state.dart';
class ResendOtpCubit extends Cubit<ResendOtpState> {
  final ResendOtpUseCase resendOtpUseCase;
  ResendOtpCubit(this.resendOtpUseCase)
      : super(ResendOTPLoading());

  Future<void>resendOtp(String email)async{
    emit(ResendOTPLoading());
    final result=await resendOtpUseCase(email);
    result.fold(
          (failure) {
        emit(ResendOTPFail(failure.message));
      },
          (success) {
        emit(ResendOTPSuccess());
      },
    );
  }
}
