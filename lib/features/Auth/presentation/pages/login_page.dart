import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hotel_app/features/Auth/presentation/cubit/login_cubit.dart';
import 'package:hotel_app/features/Auth/presentation/pages/forgetpassword.dart';
import 'package:hotel_app/features/Auth/presentation/widgets/email_field.dart';
import 'package:hotel_app/features/Auth/presentation/widgets/password_field.dart';
import 'package:hotel_app/features/Auth/presentation/widgets/auth_button.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../news/presentation/cubit/news_cubit.dart';
import '../../../news/presentation/screen/HomePage.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  final TextEditingController emailcontroller = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final theme=Theme.of(context);
    return BlocConsumer<LoginCubit, LoginState>(
      listener: (context, state) async {
        if (state is LoginSuccess) {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (_) => const Homepage(),
            ),
                (route) => false,
          );
        }

        if (state is LoginFailure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message)),
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
                  top: 270,
                  left: 10,
                  right: 10,
                  bottom: 20,
                ),

                child: SingleChildScrollView(
                  padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).viewInsets.top,
                  ),
                  child: Card(
                    color: Color(0xFFF7e2d3),
                    elevation: 10,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),

                    child: Padding(
                      padding: const EdgeInsets.all(25),

                      child: Column(
                        children: [
                          Text(
                            "Welcome",
                            style: Theme.of(context).textTheme.displayMedium,
                          ),

                          const SizedBox(height: 20),

                          EmailField(controller: emailcontroller),
                          const SizedBox(height: 20),
                          PasswordField(controller: passwordController),

                          const SizedBox(height: 10),

                          Align(
                            alignment: Alignment.centerRight,
                            child: TextButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => Forgetpassword(),
                                  ),
                                );
                              },
                              child: const Text(
                                "Forget password?",style: TextStyle(color: Colors.black),
                              ),
                            ),
                          ),

                          const SizedBox(height: 20),

                          state is LoginLoading
                              ? const CircularProgressIndicator()
                              : CustomButton(
                            text: 'Login',
                            textStyle:
                            Theme.of(context).textTheme.displayMedium?.copyWith(fontSize: 20,color: Colors.black),

                            onPressed: () {
                              context.read<LoginCubit>().login(
                                emailcontroller.text.trim(),
                                passwordController.text.trim(),
                              );
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