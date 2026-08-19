import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hotel_app/features/tasks/presentation/cubit/task_details_cubit.dart';
import 'package:hotel_app/features/tasks/presentation/cubit/task_details_state.dart';
import '../../domain/entites/task.dart';
import '../widget/task.dart';

class TasksPage extends StatelessWidget {
  TasksPage({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TaskDetailsCubit, TaskState>(
      builder: (context, state) {
        if (state is TaskFail) {
          return Center(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.error_outline, size: 40, color: Colors.grey),
                  const SizedBox(height: 12),
                  Text(
                    state.message,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  const SizedBox(height: 12),
                  TextButton(
                    onPressed: () =>
                        context.read<TaskDetailsCubit>().getAllTask(),
                    child: const Text("إعادة المحاولة"),
                  ),
                ],
              ),
            ),
          );
        }

        List<TaskEntity> tasks = [];

        if (state is TaskSuccses) {
          tasks = state.tasks;
        } else if (state is TaskToggle) {
          // خذ الـ tasks من الـ cache في الـ cubit
          tasks = context.read<TaskDetailsCubit>().cachedTasks;
        }

        if (tasks.isEmpty) return const SizedBox.shrink();

        return ListView.builder(
          padding: const EdgeInsets.only(bottom: 20),
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: false,
          itemCount: tasks.length,
          itemBuilder: (context, index) {
            final t = tasks[index];
            return TaskCardPro(
              task: t,
              status: t.status,
              title: t.title,
              completedItems: t.completedItems,
              totalItems: t.totalItems,
            );
          },
        );
      },
    );
  }
}