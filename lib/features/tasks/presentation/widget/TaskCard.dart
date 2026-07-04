import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/util/date_formatter.dart';
import '../../domain/entites/task.dart';
import '../cubit/task_details_cubit.dart';

class Taskcard extends StatelessWidget {
  final TaskEntity currentTask;
  final  TaskItemEntity task;
  const Taskcard({super.key,required this.task,required this.currentTask});

  @override
  Widget build(BuildContext context) {
    final statusColor = getStatusColor(currentTask.status);
    return GestureDetector(
      onTap: () {
        context.read<TaskDetailsCubit>().toggleTask(task.id);
      },
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(18),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(.05),
              blurRadius: 10,
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              width: 28,
              height: 28,
              decoration: BoxDecoration(
                color: task.isDone ? Colors.green : Colors.grey.shade200,
                shape: BoxShape.circle,
              ),
              child: task.isDone
                  ? const Icon(Icons.check, color: Colors.white, size: 16)
                  : null,
            ),
            const SizedBox(width: 15),
            Expanded(
              child: Text(
                task.title,
                style: TextStyle(
                  decoration:
                  task.isDone ? TextDecoration.lineThrough : null,
                  color: task.isDone ? Colors.grey : Colors.black,
                ),
              ),
            ),
            Text(
              "${task.id}",
              style: TextStyle(
                color: task.isDone?Colors.green:Colors.grey,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
