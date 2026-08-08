import 'package:flutter/material.dart';


class NumberedDetailItem extends StatelessWidget {
  final int index;
  final String text;
  final AnimationController controller;
  final ColorScheme colors;
  final ThemeData theme;
  final bool isLast;

  const NumberedDetailItem({
    super.key,
    required this.index,
    required this.text,
    required this.controller,
    required this.colors,
    required this.theme,
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
          child: Transform.translate(
            offset: Offset(0, (1 - value) * 14),
            child: child,
          ),
        );
      },
      child: Padding(
        padding: EdgeInsets.only(bottom: isLast ? 0 : 12),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              margin: const EdgeInsets.only(top: 1),
              width: 24,
              height: 24,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [colors.primary, colors.secondary],
                ),
              ),
              child: Text(
                '${index + 1}',
                style: theme.textTheme.bodyLarge?.copyWith(
                  color: colors.onPrimary,
                  fontWeight: FontWeight.w800,
                  fontSize: 11,
                ),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                text,
                textAlign: TextAlign.start,
                style: theme.textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.w500,
                  fontSize: 14.5,
                  color: colors.onSurface.withOpacity(0.8),
                  height: 1.5,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}