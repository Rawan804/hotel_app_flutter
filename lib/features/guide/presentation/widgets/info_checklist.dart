import 'package:flutter/material.dart';
import 'package:hotel_app/core/util/L10nkeylookup.dart';
import '../../../../l10n/app_localizations.dart';
import '../../models/guide_models.dart';
import 'checklist_row.dart';


class InfoChecklist extends StatelessWidget {
  final InfoSection section;
  final Color accent;
  final AnimationController controller;

  const InfoChecklist({
    super.key,
    required this.section,
    required this.accent,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;
    final t = AppLocalizations.of(context)!;

    final title = t.byKey(section.titleKey);
    final subtitle = t.byKey(section.subtitleKey);
    final items = t.byKeyList(section.itemsKey);

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: accent.withOpacity(0.05),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: accent.withOpacity(0.15)),
      ),
      padding: const EdgeInsets.all(18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      textAlign: TextAlign.right,
                      style: theme.textTheme.titleSmall
                          ?.copyWith(color: colors.onSurface, fontWeight: FontWeight.w800),
                    ),
                    Text(
                      subtitle,
                      style: theme.textTheme.bodySmall
                          ?.copyWith(color: colors.onSurface.withOpacity(0.55)),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 10),
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(color: accent.withOpacity(0.14), shape: BoxShape.circle),
                child: Icon(section.icon, color: accent, size: 16),
              ),
            ],
          ),
          const SizedBox(height: 16),
          for (int i = 0; i < items.length; i++)
            ChecklistRow(
              index: i,
              text: items[i],
              controller: controller,
              theme: theme,
              colors: colors,
              isLast: i == items.length - 1,
            ),
        ],
      ),
    );
  }
}