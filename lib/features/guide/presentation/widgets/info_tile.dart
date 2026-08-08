import 'package:flutter/material.dart';
import 'package:hotel_app/core/util/L10nkeylookup.dart';
import '../../../../l10n/app_localizations.dart';
import '../../models/guide_models.dart';

class InfoTile extends StatelessWidget {
  final InfoSection section;
  final bool isOpen;
  final VoidCallback onTap;

  const InfoTile({
    super.key,
    required this.section,
    required this.isOpen,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;
    final accent = section.accent;
    final t = AppLocalizations.of(context)!;
    final title = t.byKey(section.titleKey);

    return AspectRatio(
      aspectRatio: 1.05,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeOutCubic,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isOpen ? accent.withOpacity(0.5) : colors.onSurface.withOpacity(0.08),
            width: isOpen ? 1.6 : 1,
          ),
          boxShadow: [
            BoxShadow(
              color: accent.withOpacity(isOpen ? 0.16 : 0.08),
              blurRadius: isOpen ? 18 : 10,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: Material(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(20),
          child: InkWell(
            borderRadius: BorderRadius.circular(20),
            onTap: onTap,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(color: accent.withOpacity(0.12), shape: BoxShape.circle),
                    child: Icon(section.icon, color: accent, size: 26),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    title,
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: theme.textTheme.labelLarge
                        ?.copyWith(color: colors.onSurface, fontWeight: FontWeight.w700),
                  ),
                  const SizedBox(height: 6),
                  AnimatedRotation(
                    turns: isOpen ? 0.5 : 0,
                    duration: const Duration(milliseconds: 250),
                    child: Icon(
                      Icons.keyboard_arrow_down_rounded,
                      size: 18,
                      color: isOpen ? accent : colors.onSurface.withOpacity(0.35),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}