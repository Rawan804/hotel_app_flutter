import 'package:flutter/material.dart';

import 'app_colors.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String? hintText;
  final String labelText;
  final IconData? icon;
  final int maxLines;

  const CustomTextField({
    super.key,
    required this.controller,
     this.hintText,
    this.icon,
    this.maxLines = 1,
    required this.labelText
  });

  @override
  Widget build(BuildContext context) {
    final theme=Theme.of(context);
    return TextFormField(
      controller: controller,
      maxLines: maxLines,
      decoration: InputDecoration(
        labelText: labelText,
        hintText: hintText,
        fillColor: theme.hoverColor,
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