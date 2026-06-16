import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hotel_app/core/constants/app_colors.dart';
import 'package:hotel_app/features/Auth/presentation/widgets/auth_button.dart';
import 'package:hotel_app/features/leave_request/presentation/cubit/leave_request_cubit.dart';
import 'package:hotel_app/features/leave_request/presentation/cubit/leave_request_state.dart';


import '../../../../core/constants/text_field.dart';

class LeaveRequestPage extends StatelessWidget {

  LeaveRequestPage({super.key});
  @override
  Widget build(BuildContext context) {
    final cubit = context.read<LeaveRequestCubit>();
    final theme=Theme.of(context);
    return Container(
      padding:  EdgeInsets.only(top: 50, right: 20, left: 20, bottom: 100),
      decoration:  BoxDecoration(
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
                  "Send Leave Request",
                  style: Theme.of(context)
                      .textTheme
                      .displayMedium
                      ?.copyWith(fontSize: 20),
                ),
            
                const SizedBox(height: 30),
                CustomTextField(
                  controller: cubit.startDate,
                  labelText: "Start Date",
                  hintText: "yyyy-mm-dd",
                ),
            
                const SizedBox(height: 20),
            
                CustomTextField(
                  controller: cubit.endDate,
                  labelText: "End Date",
                  hintText: "yyyy-mm-dd",
                ),
            
                const SizedBox(height: 20),
            
                CustomTextField(
                  controller: cubit.reason,
                  labelText: "Reason",
                  maxLines: 3,
                  hintText: "why you are need a leave",
                ),
            
                const SizedBox(height: 20),
            
                CustomTextField(
                  controller: cubit.leaveType,
                  labelText: "Type",
                  hintText: "ex: sick , travel",
                ),
            
                const SizedBox(height: 40),
                Row(
                  children: [
                    Expanded(
                      child: SizedBox(
                        height: 50,
                        child: OutlinedButton(
                          onPressed: () => Navigator.pop(context),
                          child: const Text("Cancel"),
                        ),
                      ),
                    ),

                    const SizedBox(width: 12),

                    Expanded(
                      child: SizedBox(
                        height: 50,
                        child: CustomButton(
                          text: "Send",
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