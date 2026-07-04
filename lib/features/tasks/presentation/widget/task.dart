import 'package:flutter/material.dart';
import 'package:hotel_app/features/tasks/presentation/pages/taskDetails.dart';

import '../../../../core/util/date_formatter.dart';
import '../../domain/entites/task.dart';
class TaskCardPro extends StatelessWidget {

  final TaskEntity task;

  final String title;
  final String status;
  final int completedItems;
  final int totalItems;

  const TaskCardPro({
    super.key,
    required this.task,
    required this.title,
    required this.status,
    required this.completedItems,
    required this.totalItems,
  });

  @override
  Widget build(BuildContext context) {
    final statusColor = getStatusColor(status);
    final progress = totalItems == 0 ? 0 : completedItems / totalItems;
    return InkWell(
//       onTap: (){
      onTap: (){
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => Taskdetails(
              task: task,
            ),
          ),
        );
      },
//       },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 26, vertical: 10),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(18),

          border: Border(
            top: BorderSide(
              color: statusColor,
              width: 4,
            ),
          ),
          // ───────────────────
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 5),
            )
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            // ───── TOP ROW ─────
            Row(
              children: [
                Container(
                  width: 8,
                  height: 8,
                  decoration: BoxDecoration(
                    color: Colors.pinkAccent,
                    shape: BoxShape.circle,
                  ),
                ),

                const SizedBox(width: 6),

                Text(
                 title,
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                    color: Colors.black.withOpacity(0.5),
                    letterSpacing: 1,
                  ),
                ),

                const Spacer(),

                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: statusColor.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    status,
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                       color: statusColor,
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 8),



            // ───── SUBTASKS TEXT ─────
            Text(
              "$completedItems/$totalItems subtasks",
              style: TextStyle(
                fontSize: 12,
                color: Colors.black.withOpacity(0.5),
              ),
            ),

            const SizedBox(height: 8),

            // ───── PROGRESS ─────
            Row(
              children: [
                Expanded(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: LinearProgressIndicator(
                      value:progress.toDouble(),
                      minHeight: 6,
                      backgroundColor: Colors.grey.shade200,
                      valueColor: AlwaysStoppedAnimation(statusColor),
                    ),
                  ),
                ),

                const SizedBox(width: 10),

                Text(
                  "${(progress * 100).toInt()}%",
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: statusColor,
                  ),
                )
              ],
            ),

            const SizedBox(height: 14),

            // ───── BOTTOM ROW ─────
            Row(
              children: [





                const Spacer(),

                // Text(
                //   room,
                //   style: TextStyle(
                //     fontSize: 12,
                //     color: Colors.black.withOpacity(0.5),
                //   ),
                // ),

                const SizedBox(width: 8),



                const SizedBox(width: 4),

                const Icon(Icons.chevron_right, size: 18),
              ],
            ),
          ],
        ),
      ),
    );
  }
}