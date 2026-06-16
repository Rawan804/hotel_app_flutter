import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hotel_app/core/constants/app_colors.dart';

class OtpField extends StatelessWidget {
  final Function(String otp) onChanged;

  OtpField({
    super.key,
    required this.onChanged,
  });

  final List<TextEditingController> controllers =
  List.generate(6, (_) => TextEditingController());

  void _sendOtp() {
    final otp = controllers.map((c) => c.text).join();
    onChanged(otp);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: List.generate(6, (index) {
        return SizedBox(
          width: 45,
          height: 55,
          child: TextField(

            controller: controllers[index],
            textAlign: TextAlign.center,
            keyboardType: TextInputType.number,
            maxLength: 1,
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
            ],
            decoration: InputDecoration(
              fillColor: AppColors.background,
              counterText: "",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            onChanged: (value) {
              _sendOtp();

              if (value.isNotEmpty && index < 5) {
                FocusScope.of(context).nextFocus();
              }

              if (value.isEmpty && index > 0) {
                FocusScope.of(context).previousFocus();
              }
            },
          ),
        );
      }),
    );
  }
}