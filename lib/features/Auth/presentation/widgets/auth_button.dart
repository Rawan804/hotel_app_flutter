import 'package:flutter/material.dart';
import 'package:hotel_app/core/theme/app_theme.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final bool isLoading;
  final TextStyle? textStyle;
  final double? width;
  final double? height;

  const CustomButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.isLoading = false,
    this.textStyle,
    this.width,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width ?? double.infinity,
      height: height ?? 50,
      child: ElevatedButton(
        onPressed: isLoading ? null : onPressed,
        style:
        ElevatedButton
            .styleFrom(
          backgroundColor:
          const Color(
            0xFFD4AF7F,
          ),

          foregroundColor:
          Colors.white,

          padding:
          const EdgeInsets
              .symmetric(
            vertical: 6,
          ),

          shape:
          RoundedRectangleBorder(
            borderRadius:
            BorderRadius
                .circular(
              16,
            ),
          ),

          elevation: 8,
        ),
        child: isLoading
            ? const CircularProgressIndicator(
          color: Colors.white,
        )
            : Text(
          text,
          style: textStyle,
        ),
      ),
    );
  }
}