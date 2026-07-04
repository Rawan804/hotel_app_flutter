import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hotel_app/features/tasks/presentation/cubit/task_details_cubit.dart';
import 'package:hotel_app/features/tasks/presentation/cubit/task_details_state.dart';
import 'package:hotel_app/features/tasks/presentation/widget/TaskCard.dart';
import 'package:hotel_app/features/tasks/presentation/widget/TaskHeader.dart';
import 'package:hotel_app/features/tasks/presentation/widget/filterbar.dart';
import '../../../../core/util/date_formatter.dart';
import '../../../../l10n/app_localizations.dart';
import '../../domain/entites/task.dart';

class Taskdetails extends StatelessWidget {
  final TaskEntity task;
  const Taskdetails({super.key, required this.task,});
  @override
  Widget build(BuildContext context) {
    final l=AppLocalizations.of(context);
    return BlocBuilder<TaskDetailsCubit, TaskState>(
      builder: (context, state) {
        if (state is TaskSuccses || state is TaskToggle) {
          late TaskEntity currentTask;
          late String currentFilter;
          if (state is TaskSuccses) {
            currentTask = state.tasks.firstWhere((e) => e.id == task.id);
            currentFilter = state.filter;
          } else {
            currentTask = (state as TaskToggle).taskEntity;
            currentFilter = context.read<TaskDetailsCubit>().currentFilter;
          }
          final filteredItems = currentTask.items.where((item) {
            if (currentFilter == l!.done) return item.isDone;
            if (currentFilter == l.pending) return !item.isDone;
            return true;
          }).toList();

          return Scaffold(
            body: Column(
              children: [
                Taskheader(currentTask: currentTask,),
                const SizedBox(height: 20),
                Filterbar(currentFilter: currentFilter),
                const SizedBox(height: 20),
                Expanded(
                  child: ListView.separated(
                    padding: const EdgeInsets.all(16),
                    itemCount: filteredItems.length,
                    separatorBuilder: (_, __) => const SizedBox(height: 10),
                    itemBuilder: (context, index) {
                      final item = filteredItems[index];
                      return Taskcard(task:item, currentTask: currentTask);
                    },
                  ),
                ),
              ],
            ),
          );
        }
        return const SizedBox();
      },
    );
  }
}