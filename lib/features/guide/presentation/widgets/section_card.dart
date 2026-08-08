import 'package:flutter/material.dart';
import 'package:hotel_app/core/util/L10nkeylookup.dart';
import '../../../../l10n/app_localizations.dart';
import '../../models/guide_models.dart';
import 'numbered_detail_item.dart';

class SectionCard extends StatefulWidget {
  final GuideSection section;
  const SectionCard({super.key, required this.section});

  @override
  State<SectionCard> createState() => _SectionCardState();
}

class _SectionCardState extends State<SectionCard>
    with SingleTickerProviderStateMixin {
  bool _expanded = false;
  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 800),
  );

  void _toggle() {
    setState(() {
      _expanded = !_expanded;
      _expanded ? _controller.forward(from: 0) : _controller.reverse();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;
    final t = AppLocalizations.of(context)!;
    final section = widget.section;

    final title = t.byKey(section.titleKey);
    final subtitle = t.byKey(section.subtitleKey);
    final details = t.byKeyList(section.detailsKey);

    return AnimatedContainer(
      duration: const Duration(milliseconds: 280),
      curve: Curves.easeOutCubic,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: _expanded ? colors.primary.withOpacity(0.45) : colors.surface,
          width: _expanded ? 1.4 : 1,
        ),
        boxShadow: [
          BoxShadow(
            color: colors.primary.withOpacity(_expanded ? 0.14 : 0.06),
            blurRadius: _expanded ? 20 : 10,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      clipBehavior: Clip.antiAlias,
      child: Material(
        color: Colors.transparent,
        child: Column(
          children: [
            InkWell(
              onTap: _toggle,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 14, 16, 14),
                child: Row(
                  children: [
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 280),
                      padding: const EdgeInsets.all(6),
                      decoration: BoxDecoration(
                        color: _expanded
                            ? colors.primary.withOpacity(0.12)
                            : colors.onSurface.withOpacity(0.05),
                        shape: BoxShape.circle,
                      ),
                      child: AnimatedRotation(
                        turns: _expanded ? 0.5 : 0,
                        duration: const Duration(milliseconds: 280),
                        child: Icon(
                          Icons.keyboard_arrow_down_rounded,
                          color: _expanded
                              ? colors.primary
                              : colors.onSurface.withOpacity(0.5),
                          size: 20,
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            title,
                            textAlign: TextAlign.start,
                            style: theme.textTheme.titleLarge?.copyWith(
                              fontSize: 15,
                              color: colors.onSurface,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            subtitle,
                            textAlign: TextAlign.start,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: theme.textTheme.bodySmall?.copyWith(
                              color: colors.onSurface.withOpacity(0.55),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 14),
                    Stack(
                      clipBehavior: Clip.none,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(2.5),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            gradient: LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: [colors.primary, colors.secondary],
                            ),
                          ),
                          child: CircleAvatar(
                            radius: 26,
                            backgroundColor: colors.surface,
                            child: ClipOval(
                              child: Image.asset(
                                section.imagePath,
                                width: 52,
                                height: 52,
                                fit: BoxFit.cover,
                                errorBuilder: (_, __, ___) => Container(
                                  width: 52,
                                  height: 52,
                                  color: colors.primary.withOpacity(0.15),
                                  child: Icon(section.icon,
                                      color: colors.primary, size: 22),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: -3,
                          left: -3,
                          child: Container(
                            padding: const EdgeInsets.all(5),
                            decoration: BoxDecoration(
                              color: colors.secondary,
                              shape: BoxShape.circle,
                              border: Border.all(color: colors.surface, width: 2),
                            ),
                            child: Icon(
                              section.icon,
                              color: colors.onSecondary,
                              size: 12,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            ClipRect(
              child: AnimatedBuilder(
                animation: _controller,
                builder: (context, child) {
                  return Align(
                    alignment: Alignment.topCenter,
                    heightFactor: Curves.easeOutCubic.transform(_controller.value),
                    child: Opacity(opacity: _controller.value, child: child),
                  );
                },
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.fromLTRB(14, 4, 14, 16),
                  decoration: BoxDecoration(
                    border: Border(
                      top: BorderSide(color: colors.onSurface.withOpacity(0.08)),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(top: 12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        for (int i = 0; i < details.length; i++)
                          NumberedDetailItem(
                            index: i,
                            text: details[i],
                            controller: _controller,
                            colors: colors,
                            theme: theme,
                            isLast: i == details.length - 1,
                          ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}