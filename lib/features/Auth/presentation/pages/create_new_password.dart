import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hotel_app/core/constants/app_colors.dart';
import 'package:hotel_app/features/Auth/presentation/cubit/create_new_password_cubit.dart';
import 'package:hotel_app/features/Auth/presentation/cubit/create_new_password_state.dart';
import 'package:hotel_app/features/Auth/presentation/widgets/auth_button.dart';
import 'package:hotel_app/features/Auth/presentation/widgets/password_field.dart';
import 'package:hotel_app/l10n/app_localizations.dart';

import '../../../news/presentation/screen/HomePage.dart';
import '../widgets/ruleitem.dart';
class CreateNewPassword extends StatelessWidget {
  final String email;
  final String otp;

  CreateNewPassword({
    super.key,
    required this.email,
    required this.otp,
  });

  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    return Scaffold(
      backgroundColor: Colors.white,
      body: BlocConsumer<PasswordCubit, PasswordState>(
        listener: (context, state) {
          if (state is NewPasswordSuccess) {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (_) => const Homepage(),
              ),
                  (route) => false,
            );
            ScaffoldMessenger.of(context).showSnackBar(
               SnackBar(
                content: Text(l!.passwordresetsuccessful),
              ),
            );
          }

          if (state is NewPasswordFail) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
          }
        },
        builder: (context, state) {
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 30),

                  Center(
                    child: Container(

                      height: 130,
                      width: 130,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.primary.withOpacity(.3),
                            blurRadius: 20,
                          ),
                        ],
                        image:  DecorationImage(
                          image: AssetImage("images/99.jpg"),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 25),

                  Center(
                    child: Text(
                     l!.createNewPassword,
                      style: Theme.of(context).textTheme.displayMedium?.copyWith(fontSize: 20,fontWeight: FontWeight.w600),
                    ),
                  ),

                  const SizedBox(height: 40),

                  /// PASSWORD
                  Theme(
                    data: Theme.of(context).copyWith(
                      inputDecorationTheme: InputDecorationTheme(
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.green),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.green,
                            width: 2,
                          ),
                        ),
                      ),
                    ),
                    child: PasswordField(
                      controller: passwordController,
                      onChanged: (value) {
                        context.read<PasswordCubit>().passwordChanged(value);
                      },
                    ),
                  ),

                  SizedBox(height: 10), Column( crossAxisAlignment: CrossAxisAlignment.start, children: [
                    const SizedBox(height: 10),
                    Text( l.passwordStrength, style: Theme.of(context).textTheme.displayMedium?.copyWith(fontSize: 14), ),
                    const SizedBox(height: 12),
                    TweenAnimationBuilder<double>( tween: Tween( begin: 0, end: state.strength, ),
                      duration: const Duration(milliseconds: 500),
                       builder: (context, value, child) {
                      return ClipRRect( borderRadius: BorderRadius.circular(10),
                    child: LinearProgressIndicator( value: value, minHeight: 10,
                      backgroundColor: Colors.grey.shade300,
                      valueColor: AlwaysStoppedAnimation<Color>( value < 0.3 ? Colors.red : value < 0.7 ? Colors.orange : Colors.green, ), ), ); }, ), ], ),
                  SizedBox(height: 15),

                  /// CONFIRM PASSWORD
                  Theme(
                    data: Theme.of(context).copyWith(
                      inputDecorationTheme: InputDecorationTheme(
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.green),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.green,
                            width: 2,
                          ),
                        ),
                      ),
                    ),
                    child: PasswordField(
                      controller: confirmController,
                      onChanged: (value) {
                        context.read<PasswordCubit>().confirmPasswordChanged(value);
                      },
                    ),
                  ),

                  const SizedBox(height: 10),

                  /// MATCH STATUS
                  Row(
                    children: [
                      Icon(
                        state.isMatch
                            ? Icons.check_circle
                            : Icons.cancel,
                        color:
                        state.isMatch ? Colors.green : Colors.red,
                        size: 20,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        state.isMatch
                            ? l.passwordsmatch
                            : l.passwordsdontmatch,
                      ),
                    ],
                  ),

                  const SizedBox(height: 20),

                  Text(
                    l.passwordmustcontain,
                    style:     Theme.of(context).textTheme.displayMedium?.copyWith(fontSize: 20),
                    ),


                  const SizedBox(height: 10),

                  RuleItem(
                      text:l.atleastoneuppercaseletter,
                      value: state.hasUpper),
                  SizedBox(height: 7,),
                  RuleItem(
                      text: l.atleastonelowercaseletter,
                      value: state.hasLower),
                  SizedBox(height: 7,),
                  RuleItem(
                      text: l.atleastonenumber,
                      value: state.hasNumber),
                  SizedBox(height: 7,),
                  RuleItem(
                      text: l.atleastonespecialcharacter,
                      value: state.hasSpecial),
                  SizedBox(height: 7,),
                  RuleItem(
                      text: l.minimum,
                      value: state.hasLength),

                  const SizedBox(height: 30),

                  /// BUTTON
                  CustomButton(
                    text: state is NewPasswordLoading
                        ?l.loading
                        : l.confirm,
                    onPressed: state.isMatch
                        ? () {
                      context
                          .read<PasswordCubit>().resetpassword(email, otp,passwordController.text,

                      );
                    }
                        : null,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}









