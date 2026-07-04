import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../l10n/app_localizations.dart';
import '../cubit/task_details_cubit.dart';

class Filterbar extends StatelessWidget {
  String currentFilter;
   Filterbar({super.key,required this.currentFilter});

  @override
  Widget build(BuildContext context) {
    final l=AppLocalizations.of(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _chip(context, l!.all, l.all, currentFilter),
        const SizedBox(width: 22),
        _chip(context, l.done, l.done, currentFilter),
        const SizedBox(width: 22),
        _chip(context, l.pending,l.pending, currentFilter),
      ],
    );
  }

  Widget _chip(BuildContext context, String title, String value, String currentFilter,) {
    final isSelected = currentFilter == value;

    return GestureDetector(
      onTap: () {
        context.read<TaskDetailsCubit>().changeFilter(value);
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected
              ? Theme.of(context).colorScheme.surface
              : Theme.of(context).hoverColor,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          title,
          style: TextStyle(
            color: isSelected ? Colors.white : Colors.black,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ),
    );
  }

}
