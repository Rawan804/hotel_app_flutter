import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hotel_app/core/constants/app_colors.dart';
import 'package:hotel_app/features/Auth/presentation/widgets/auth_button.dart';
import 'package:hotel_app/features/leave_request/presentation/cubit/leave_request_cubit.dart';
import 'package:hotel_app/features/leave_request/presentation/cubit/leave_request_state.dart';
import 'package:hotel_app/l10n/app_localizations.dart';

import '../../../../core/constants/text_field.dart';

class LeaveRequestPage extends StatelessWidget {
  LeaveRequestPage({super.key});

  // ⭐ جديد — دالة فتح التقويم وتعبئة الحقل بصيغة yyyy-MM-dd
  Future<void> _pickDate(
      BuildContext context, TextEditingController controller) async {
    final now = DateTime.now();

    DateTime initialDate = now;
    if (controller.text.isNotEmpty) {
      final parsed = DateTime.tryParse(controller.text);
      if (parsed != null) initialDate = parsed;
    }

    final pickedDate = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: DateTime(now.year - 1),
      lastDate: DateTime(now.year + 5),
    );

    if (pickedDate != null) {
      final formatted = '${pickedDate.year.toString().padLeft(4, '0')}-'
          '${pickedDate.month.toString().padLeft(2, '0')}-'
          '${pickedDate.day.toString().padLeft(2, '0')}';

      controller.text = formatted;
    }
  }

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    final cubit = context.read<LeaveRequestCubit>();
    final theme = Theme.of(context);
    return Container(
      padding: EdgeInsets.only(top: 50, right: 20, left: 20, bottom: 100),
      decoration: BoxDecoration(
        color: theme.scaffoldBackgroundColor,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(35),
          topRight: Radius.circular(35),
        ),
      ),
      child: BlocConsumer<LeaveRequestCubit, LeaveRequestState>(
        listener: (context, state) {
          if (state is LeaveRequestSuccess) {
            context.read<LeaveRequestCubit>().clearFields();
            Navigator.pop(context);
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
          }

          if (state is LeaveRequestFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
          }
        },
        builder: (context, state) {
          return SingleChildScrollView(
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom + 20,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  l!.sendLeaveRequest,
                  style: Theme.of(context)
                      .textTheme
                      .displayMedium
                      ?.copyWith(fontSize: 20),
                ),

                const SizedBox(height: 30),

                // ⭐ حقل تاريخ البداية — أصبح قابل للنقر فقط، يفتح التقويم
                CustomTextField(
                  controller: cubit.startDate,
                  labelText: l.startDate,
                  hintText: "yyyy-mm-dd",
                  readOnly: true,
                  onTap: () => _pickDate(context, cubit.startDate),
                  suffixIcon: const Icon(Icons.calendar_month_outlined),
                ),

                const SizedBox(height: 20),


                CustomTextField(
                  controller: cubit.endDate,
                  labelText: l.endDate,
                  hintText: "yyyy-mm-dd",
                  readOnly: true,
                  onTap: () => _pickDate(context, cubit.endDate),
                  suffixIcon: const Icon(Icons.calendar_month_outlined),
                ),

                const SizedBox(height: 20),

                CustomTextField(
                  controller: cubit.reason,
                  labelText: l.reason,
                  maxLines: 3,
                  hintText: l.whyyouareneedaleave,
                ),

                const SizedBox(height: 20),

                CustomTextField(
                  controller: cubit.leaveType,
                  labelText: l.type,
                  hintText: l.ex,
                ),

                const SizedBox(height: 40),
                Row(
                  children: [
                    Expanded(
                      child: SizedBox(
                        height: 50,
                        child: OutlinedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.background,
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                              side: BorderSide(
                                color: AppColors.primaryDark,
                                width: 0.5,
                              ),
                            ),
                          ),
                          onPressed: () => Navigator.pop(context),
                          child: Text(
                            l.cancel,
                            style: TextStyle(color: AppColors.primaryDark),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 12),
                    Expanded(
                      child: SizedBox(
                        height: 50,
                        child: CustomButton(
                          text: l.send,
                          textStyle: Theme.of(context)
                              .textTheme
                              .displayMedium
                              ?.copyWith(fontSize: 18),
                          onPressed: () {
                            context.read<LeaveRequestCubit>().addLeaveRequest(
                              DateTime.parse(cubit.startDate.text),
                              DateTime.parse(cubit.endDate.text),
                              cubit.reason.text,
                              cubit.leaveType.text,
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          );
        },
      ),
    );
  }
}