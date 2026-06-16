import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hotel_app/features/Auth/presentation/cubit/forget_password_cubit.dart';
import 'package:hotel_app/features/Auth/presentation/cubit/otp_cubit.dart';
import 'package:hotel_app/features/Auth/presentation/pages/otp_page.dart';
import 'package:hotel_app/features/Auth/presentation/widgets/email_field.dart';
import 'package:hotel_app/features/Auth/presentation/widgets/auth_button.dart';

import '../../../../core/constants/app_colors.dart';

class Forgetpassword extends StatelessWidget {
  Forgetpassword({super.key});

  final TextEditingController emailcontroller =
  TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ForgetPasswordCubit, ForgetPasswordState>(
      listener: (context, state) {
        if (state is ForgetPasswordSuccess) {
          context.read<OtpCubit>().startTimer();
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => OtpPage(
                email: emailcontroller.text,
              ),
            ),
          );
        }

        if (state is ForgetPasswordFail) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("Failed to send OTP"),
            ),
          );
        }
      },
      builder: (context, state) {
        return Scaffold(
          resizeToAvoidBottomInset: false,
          body: Stack(
            children: [
              SizedBox.expand(
                child: Image.asset(
                  "images/lopi.jpg",
                  fit: BoxFit.fill,
                ),
              ),

              Container(
                color: Colors.black.withOpacity(0.4),
              ),

              Container(
                padding: const EdgeInsets.only(
                  top: 300,
                  left: 10,
                  right: 10,
                  bottom: 40,
                ),
                child: SingleChildScrollView(
                  padding: EdgeInsets.only( bottom: MediaQuery.of(context).viewInsets.bottom + 40,),
                  child: Card(
                    color: Color(0xFFF7e2d3),
                    elevation: 10,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(
                        top: 40,
                        bottom: 80,
                        left: 25,
                        right: 25,
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            "Please enter your email",
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium
                          ),
                          const SizedBox(height: 7),
                          Text(
                            "to send OTP",
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium
                          ),

                          const SizedBox(height: 30),

                          EmailField(
                            controller: emailcontroller,
                          ),

                          const SizedBox(height: 30),

                         CustomButton(
                           textStyle: Theme.of(context).textTheme.displayMedium?.copyWith(fontSize: 20),
                            text: 'Send OTP',
                            onPressed: () {
                              final email =
                              emailcontroller.text.trim();
                              context.read<ForgetPasswordCubit>().forgetpassword(email);
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}