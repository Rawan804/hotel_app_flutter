import 'package:flutter/material.dart';
import '../../../../l10n/app_localizations.dart';
import '../../domain/entites/task.dart';
import '../../../../core/util/date_formatter.dart';

class Taskheader extends StatelessWidget {
  final TaskEntity currentTask;
  const Taskheader({super.key, required this.currentTask});
  @override
  Widget build(BuildContext context) {
    final l=AppLocalizations.of(context);
    final statusColor = getStatusColor(currentTask.status);
    return Container(
      height: 300,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Theme.of(context).colorScheme.surface,
            Theme.of(context).colorScheme.secondary,
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(36),
          bottomRight: Radius.circular(36),
        ),
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CircleAvatar(
                backgroundColor: Colors.white24,
                child: IconButton(
                  icon: const Icon(Icons.arrow_back, color: Colors.white),
                  onPressed: () => Navigator.pop(context),
                ),
              ),
              const SizedBox(height: 20),
              Text(
                currentTask.title,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              Text(
                "${currentTask.completedItems}${l!.done}  |   ${currentTask.totalItems - currentTask.completedItems} ${l!.left} ",
                style: const TextStyle(color: Colors.white70),
              ),
              const Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: LinearProgressIndicator(
                        value: currentTask.progress,
                        minHeight: 8,
                        backgroundColor: Colors.white24,
                        valueColor: AlwaysStoppedAnimation(statusColor),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  SizedBox(
                    width: 48,
                    height: 38,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        CircularProgressIndicator(
                          value: currentTask.progress,
                          strokeWidth: 5,
                          backgroundColor: Colors.white24,
                          valueColor: AlwaysStoppedAnimation(statusColor),
                        ),
                        Text(
                          "${(currentTask.progress * 100).toInt()}%",
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 11,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}