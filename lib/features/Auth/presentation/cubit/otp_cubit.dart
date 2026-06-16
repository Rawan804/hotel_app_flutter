import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecases/VerifyOtpUseCase.dart';
import 'otp_state.dart';

class OtpCubit extends Cubit<OtpState> {
  final VerifyOtpUseCase verifyOtpUseCase;
  OtpCubit(this.verifyOtpUseCase) : super(OtpInitial());
  Timer? timer;
  int secondsRemaining = 600;
  String currentOtp = "";
  void startTimer() {
    timer?.cancel();

    secondsRemaining = 600;

    emit(OtpTimerRunning(secondsRemaining));

    timer = Timer.periodic(
      const Duration(seconds: 1),
          (_) {
        if (secondsRemaining > 0) {
          secondsRemaining--;

          emit(OtpTimerRunning(secondsRemaining));
        } else {
          timer?.cancel();

          emit(OtpTimerFinished());
        }
      },
    );
  }

  Future<void> verifyOtp(String otp, String email) async {
    emit(OtpLoading());

    final result = await verifyOtpUseCase(email, otp);

    result.fold(
          (failure) {
        emit(OtpError("Server error"));
      },
          (isValid) {
        if (isValid == true) {
          emit(OtpVerified());
        } else {
          emit(OtpError("Invalid OTP"));
        }
      },
    );
  }

  Future<void> resendOtp() async {
    try {
      emit(OtpLoading());

      // API Resend OTP

      emit(OtpResent());

      startTimer();
    } catch (e) {
      emit(OtpError("Failed to resend OTP"));
    }
  }

  @override
  Future<void> close() {
    timer?.cancel();
    return super.close();
  }
}