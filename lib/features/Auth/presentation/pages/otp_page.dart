import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hotel_app/features/Auth/presentation/cubit/otp_cubit.dart';
import 'package:hotel_app/features/Auth/presentation/cubit/otp_state.dart';
import 'package:hotel_app/features/Auth/presentation/cubit/resend_otp_cubit.dart';
import 'package:hotel_app/features/Auth/presentation/pages/create_new_password.dart';
import 'package:hotel_app/features/Auth/presentation/widgets/auth_button.dart';
import 'package:hotel_app/features/Auth/presentation/widgets/otp_field.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../l10n/app_localizations.dart';

class OtpPage extends StatelessWidget {
  final String email;
  OtpPage({super.key, required this.email});
  final TextEditingController otpController=TextEditingController();
  @override
  Widget build(BuildContext context) {
    final l=AppLocalizations.of(context);
    return BlocListener<OtpCubit, OtpState>(
      listener: (context, state) {
        if (state is OtpVerified) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => CreateNewPassword(
                email: email,
                otp: context.read<OtpCubit>().currentOtp,
              ),
            ),
          );
        }

        if (state is OtpError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message)),
          );
        }
        if (state is OtpResent) {
          ScaffoldMessenger.of(context).showSnackBar(
             SnackBar(content: Text(l!.oTPsentagain)),
          );
        }
      },
      child: Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Image.asset(
                  "images/22.jpg",
                  fit: BoxFit.cover,
                  height: 300,
                  width: double.infinity,
                ),

                const SizedBox(height: 40),

                Text(
                  l!.enterOTP,
                  style:
                  Theme.of(context).textTheme.displayMedium,
                ),

                const SizedBox(height: 20),

                Padding(
                  padding:
                  const EdgeInsets.symmetric(horizontal: 20),
                  child: Text(
                    l.wehave,
                    textAlign: TextAlign.center,
                    style:
                    Theme.of(context).textTheme.bodyMedium,
                  ),
                ),
                const SizedBox(height: 20),
                /// OTP FIELD
                OtpField(
                  onChanged: (otp) {
                    context.read<OtpCubit>().currentOtp = otp;
                  },
                ),
                const SizedBox(height: 10),
                /// TIMER
                BlocBuilder<OtpCubit, OtpState>(
                  builder: (context, state) {
                    int secondsRemaining = 100;
                    if (state is OtpTimerRunning) {
                      secondsRemaining = state.secondsRemaining;
                    }
                    final minutes = secondsRemaining ~/ 60;
                    final seconds = secondsRemaining % 60;
                    final timerText =
                        "${minutes.toString().padLeft(2, '0')}:"
                        "${seconds.toString().padLeft(2, '0')}";
                    return Text(
                      timerText,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: AppColors.primaryDark,
                      ),
                    );
                  },
                ),
                const SizedBox(height: 30),
                /// VERIFY BUTTON
                BlocBuilder<OtpCubit, OtpState>(
                  builder: (context, state) {
                    return SizedBox(
                      width: 300,
                      child: CustomButton(
                        text: state is OtpLoading
                            ? l.loading
                            : l.confirm,
                        onPressed: state is OtpLoading
                            ? null
                            : () {
                          context.read<OtpCubit>().verifyOtp(context.read<OtpCubit>().currentOtp,email,
                          );
                        },
                      ),
                    );
                  },
                ),

                const SizedBox(height: 40),
                /// RESEND
                BlocBuilder<OtpCubit, OtpState>(
                  builder: (context, state) {
                    bool canResend =
                    state is OtpTimerFinished;

                    String timerText = "";

                    if (state is OtpTimerRunning) {
                      final minutes =
                          state.secondsRemaining ~/ 60;
                      final seconds =
                          state.secondsRemaining % 60;

                      timerText =
                      "${minutes.toString().padLeft(2, '0')}:"
                          "${seconds.toString().padLeft(2, '0')}";
                    }

                    return Row(
                      mainAxisAlignment:
                      MainAxisAlignment.center,
                      children: [
                         Text(l.didntreceiveOTP),

                        const SizedBox(width: 5),

                        TextButton(
                          onPressed: canResend
                              ? () {
                            context.read<ResendOtpCubit>().resendOtp(email);
                            context.read<OtpCubit>().startTimer();
                          }
                              : null,
                          child: Text(
                            canResend
                                ? l.resendit
                                : "wait  $timerText",
                            style: TextStyle(
                              color: canResend
                                  ? AppColors.primaryDark
                                  : AppColors.primary,
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}