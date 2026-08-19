import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hotel_app/core/constants/app_colors.dart';
import 'package:hotel_app/features/complaints_request/presentation/cubit/complaints_request_cubit.dart';
import 'package:hotel_app/l10n/app_localizations.dart';

import '../../../Auth/presentation/widgets/auth_button.dart';
import '../cubit/complaints_request_state.dart';

class ComplaintForm extends StatelessWidget {
  const ComplaintForm({super.key});

  String _getErrorMessage(
      BuildContext context,
      String key,
      ) {
    final l = AppLocalizations.of(context)!;

    switch (key) {
      case 'complaintTitleRequired':
        return l.complaintTitleRequired;

      case 'complaintDescriptionRequired':
        return l.complaintDescriptionRequired;

      default:
        return key;
    }
  }

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<ComplaintsRequestCubit>();
    final theme = Theme.of(context);
    final l = AppLocalizations.of(context)!;

    return Container(
      padding: const EdgeInsets.only(
        top: 50,
        right: 20,
        left: 20,
        bottom: 100,
      ),
      decoration: BoxDecoration(
        color: theme.scaffoldBackgroundColor,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(35),
          topRight: Radius.circular(35),
        ),
      ),
      child: BlocConsumer<ComplaintsRequestCubit, ComplaintsRequestState>(
        listener: (context, state) {
          if (state is ComplaintsRequestSuccess) {
            context.read<ComplaintsRequestCubit>().clearFields();

            Navigator.pop(
              context,
              l.complaintSubmittedSuccess,
            );
          }

          if (state is ComplaintsRequestFailure) {
            final message = _getErrorMessage(
              context,
              state.message,
            );

            Navigator.pop(
              context,
              message,
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
                Align(
                  alignment: Alignment.topCenter,
                  child: Text(
                    l.sendComplaint,
                    style: Theme.of(context)
                        .textTheme
                        .displayMedium
                        ?.copyWith(fontSize: 20),
                  ),
                ),

                const SizedBox(height: 30),

                TextField(
                  controller: cubit.titleController,
                  decoration: InputDecoration(
                    fillColor: theme.hoverColor,
                    labelText: l.complainttitle,
                    prefixIcon: const Icon(Icons.title_outlined),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                ),

                const SizedBox(height: 25),

                TextField(
                  controller: cubit.descController,
                  maxLines: 4,
                  decoration: InputDecoration(
                    fillColor: theme.hoverColor,
                    labelText: l.complaintdescription,
                    prefixIcon: const Icon(Icons.description),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                ),

                const SizedBox(height: 40),

                Row(
                  children: [
                    SizedBox(
                      width: 120,
                      height: 50,
                      child: state is ComplaintsRequestLoading
                          ? const Center(
                        child: CircularProgressIndicator(),
                      )
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
                        child: Text(
                          l.cancel,
                          style: TextStyle(
                            color: AppColors.primaryDark,
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(width: 70),

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
                            context
                                .read<ComplaintsRequestCubit>()
                                .addComplaints();
                          },
                        ),
                      ),
                    ),
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