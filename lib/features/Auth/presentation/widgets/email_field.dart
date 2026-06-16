import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';

class EmailField extends StatelessWidget {
  final TextEditingController controller;

  const EmailField({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
        fillColor: Color(0xFFF7e2d3),
        labelText: "Email",
        hintText: "Enter Email",
        labelStyle:  Theme.of(context).textTheme.labelMedium,
        hintStyle:  Theme.of(context).textTheme.bodyLarge,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
        ),

        // مهم: شكل عند التركيز
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: const BorderSide(
            color: Color(0xFFD4AF7F),
            width: 2,
          ),
        ),

        // شكل افتراضي
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: const BorderSide(
              color:AppColors.primaryDark
          ),
        ),
      ),
    );
  }
}