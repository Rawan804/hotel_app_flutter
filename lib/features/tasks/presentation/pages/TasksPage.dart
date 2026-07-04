import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hotel_app/features/tasks/presentation/cubit/task_details_cubit.dart';
import 'package:hotel_app/features/tasks/presentation/cubit/task_details_state.dart';
import '../../domain/entites/task.dart';
import '../widget/task.dart';

class TasksPage extends StatelessWidget {
  TasksPage({super.key});

  // final List<Map<String, dynamic>> tasks = [
  //   {
  //     "title": "Prepare Suite 412",
  //     "status": "In Progress",
  //     "color": Colors.orange,
  //     "done": 3,
  //     "total": 5,
  //   },
  //
  //   {
  //     "title": "Breakfast Service",
  //     "status": "Completed",
  //     "color": Colors.green,
  //     "done": 5,
  //     "total": 5,
  //   },
  //   {
  //     "title": "Conference Setup",
  //     "status": "Pending",
  //     "color": Colors.red,
  //     "done": 1,
  //     "total": 4,
  //   },
  // ];

  @override
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TaskDetailsCubit, TaskState>(
      builder: (context, state) {
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
          physics: const AlwaysScrollableScrollPhysics(),
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