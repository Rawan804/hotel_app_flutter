import 'package:flutter/material.dart';


class ChecklistRow extends StatelessWidget {
  final int index;
  final String text;
  final AnimationController controller;
  final ThemeData theme;
  final ColorScheme colors;
  final bool isLast;

  const ChecklistRow({
    super.key,
    required this.index,
    required this.text,
    required this.controller,
    required this.theme,
    required this.colors,
    this.isLast = false,
  });

  @override
  Widget build(BuildContext context) {
    final start = (index * 0.08).clamp(0.0, 1.0);
    final end = (start + 0.45).clamp(0.0, 1.0);
    final interval = CurvedAnimation(
      parent: controller,
      curve: Interval(start, end, curve: Curves.easeOutCubic),
    );

    return AnimatedBuilder(
      animation: interval,
      builder: (context, child) {
        final value = interval.value;
        return Opacity(
          opacity: value,
          child: Transform.translate(offset: Offset((1 - value) * -10, 0), child: child),
        );
      },
      child: Padding(
        padding: EdgeInsets.only(bottom: isLast ? 0 : 14),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Text(
                text,
                textAlign: TextAlign.start,
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: colors.onSurface.withOpacity(0.78),
                  height: 1.5,
                ),
              ),
            ),
            const SizedBox(width: 12),
          ],
        ),
      ),
    );
  }
}
