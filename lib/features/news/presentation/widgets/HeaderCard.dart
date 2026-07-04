import 'package:flutter/material.dart';
import 'package:hotel_app/features/tasks/domain/entites/task.dart';

import '../../../../l10n/app_localizations.dart';

class HeaderCard extends StatelessWidget {
  final String name;
  final String imageUrl;
  final int totalItems;
  final int completedItems;

  const HeaderCard(
      {
    super.key,
        this.totalItems = 0,
        this.completedItems = 0,
    required this.name,
    required this.imageUrl,

  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l = AppLocalizations.of(context)!;
    return Container(
      padding: const EdgeInsets.all(40),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface.withAlpha(200),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                  l.goodluckwithyourtasks ,
                    style: theme.textTheme.bodyMedium?.copyWith(fontSize: 12),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    name,
                    style: theme.textTheme.displayMedium?.copyWith(fontSize: 18),
                  ),
                ],
              ),
              Stack(
                children: [
                  CircleAvatar(
                    radius: 25,
                    backgroundImage: NetworkImage(imageUrl),
                  ),
                  Positioned(
                    right: 0,
                    child: Container(
                      width: 10,
                      height: 10,
                      decoration: const BoxDecoration(
                        color: Colors.red,
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),

          const SizedBox(height: 20),

          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: theme.colorScheme.onSecondaryContainer.withOpacity(0.15),
              borderRadius: BorderRadius.circular(15),
              border: Border.all(
                color: theme.colorScheme.onSecondaryContainer.withOpacity(0.2),
                width: 1,
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _StatItem(title: l.tasks, value: totalItems),
                _Divider(),
                _StatItem(title: l.pending, value: totalItems - completedItems),
                _Divider(),
                _StatItem(title: l.done, value: completedItems),

              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _Divider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 1,
      height: 30,
      color: Theme.of(context).colorScheme.primary.withOpacity(0.25),
    );
  }
}

class _StatItem extends StatelessWidget {
  final String title;
  final int value;

  const _StatItem({
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      children: [
        Text(
          value.toString(),
          style: theme.textTheme.titleLarge?.copyWith(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: theme.colorScheme.onSecondaryContainer,
          ),
        ),
        const SizedBox(height: 5),
        Text(
          title,
          style: theme.textTheme.bodyMedium?.copyWith(fontSize: 12),
        ),
      ],
    );
  }
}