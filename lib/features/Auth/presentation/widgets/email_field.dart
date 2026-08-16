import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../l10n/app_localizations.dart';

class EmailField extends StatelessWidget {
  final TextEditingController controller;

  const EmailField({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    final l=AppLocalizations.of(context);
    return TextFormField(
      controller: controller,
      keyboardType: TextInputType.text,
      style: const TextStyle(
        color: Colors.black,
        fontSize: 16,
      ),
      decoration: InputDecoration(
        fillColor: Color(0xFFF7e2d3),
        filled: true,
        labelText: l!.email,
        hintText: l.enteremail,
        labelStyle:  Theme.of(context).textTheme.labelMedium?.copyWith(color: Colors.black),
        hintStyle:  Theme.of(context).textTheme.titleMedium?.copyWith(color: Colors.black),

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