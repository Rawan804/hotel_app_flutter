import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hotel_app/core/constants/app_colors.dart';
import 'package:hotel_app/features/complaints_request/presentation/cubit/complaints_request_cubit.dart';
import '../../../Auth/presentation/widgets/auth_button.dart';
import '../cubit/complaints_request_state.dart';
class ComplaintForm extends   StatelessWidget{

  @override
  Widget build(BuildContext context) {
    final cubit=context.read<ComplaintsRequestCubit>();
    final theme=Theme.of(context);
    return Container(
      padding:  EdgeInsets.only(top: 50,right: 20,left: 20,bottom: 100),
      decoration:  BoxDecoration(
        color: theme.scaffoldBackgroundColor,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(35),
          topRight: Radius.circular(35),
        ),
      ),
      child: BlocConsumer<ComplaintsRequestCubit, ComplaintsRequestState>(
        listener: (context, state) {
          if (state is ComplaintsRequestSuccess) {
            context.read<ComplaintsRequestCubit>().clearFields();
            Navigator.pop(context);
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
          }

          if (state is ComplaintsRequestFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
          }
        },
        builder: (context, state) {
          return SingleChildScrollView(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,

              children: [

                // 🔵 Title
                 Align(
                   alignment: Alignment.topCenter,
                   child: Text(
                    "Send Complaint",
                    style:Theme.of(context).textTheme.displayMedium?.copyWith(fontSize: 20)
                                 ),
                 ),

                const SizedBox(height: 30),

                // 🔵 Title Field
                TextField(
                  controller: cubit.titleController,
                  decoration: InputDecoration(
                    fillColor: theme.hoverColor,
                    labelText: " Complaint title",
                    prefixIcon: const Icon(Icons.title_outlined),

                    border: OutlineInputBorder(

                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                ),

                const SizedBox(height: 25),

                // 🔵 Description Field
                TextField(
                  controller: cubit.descController,
                  maxLines: 4,
                  decoration: InputDecoration(
                    fillColor: theme.hoverColor,
                    labelText: " complaint description",
                    prefixIcon: const Icon(Icons.description),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                ),

                const SizedBox(height: 40),

                // 🔵 Button
                Row(
                  children: [

                    SizedBox(
                   width: 100,
                      height: 50,
                      child: state is ComplaintsRequestLoading
                          ? const Center(child: CircularProgressIndicator())
                          : ElevatedButton(
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
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child:  Text(
                          "cancel ",
                          style: TextStyle(color:AppColors.primaryDark),
                        ),
                      ),
                    ),SizedBox(width: 70,),
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
                                context.read<ComplaintsRequestCubit>().addComplaints(
                            cubit.titleController.text,cubit.descController.text
                                );
                              },
                            ))),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}