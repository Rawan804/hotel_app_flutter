import 'package:flutter/material.dart';
import 'package:hotel_app/core/constants/app_colors.dart';

class PasswordField extends StatefulWidget {
  final TextEditingController controller;
  final Function(String)? onChanged;

  const PasswordField({
    super.key,
    required this.controller,
    this.onChanged,
  });

  @override
  State<PasswordField> createState() => _PasswordFieldState();
}

class _PasswordFieldState extends State<PasswordField> {
  bool obscure = true;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      onChanged: widget.onChanged,
      obscureText: obscure,
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
        fillColor: Color(0xFFF7e2d3),
        labelText: "Password",
        hintText: "Enter Password",
        labelStyle: Theme.of(context).textTheme.labelMedium,
        hintStyle: Theme.of(context).textTheme.bodyLarge,

        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
        ),

        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: const BorderSide(
            color: Color(0xFFD4AF7F),
            width: 2,
          ),
        ),

        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: const BorderSide(
            color: AppColors.primaryDark,
          ),
        ),

        // 👁️ ICON
        suffixIcon: IconButton(
          onPressed: () {
            setState(() {
              obscure = !obscure;
            });
          },
          icon: Icon(
            obscure ? Icons.visibility_off : Icons.visibility,
            color: Colors.grey,
          ),
        ),
      ),
    );
  }
}