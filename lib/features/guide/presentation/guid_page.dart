import 'package:flutter/material.dart';
import 'package:hotel_app/features/news/presentation/widgets/BottomBar/bottombar.dart';

import '../../../l10n/app_localizations.dart';
import '../data/guide_data.dart';
import 'widgets/info_tiles_row.dart';
import 'widgets/section_card.dart';

class GuidPage extends StatelessWidget {
  const GuidPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;
    final t = AppLocalizations.of(context)!;

    return Scaffold(
      bottomNavigationBar: const Bottombar(),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 24, 20, 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(height: 18),
                    Container(
                      padding: const EdgeInsetsDirectional.only(end: 30),
                      child: Text(
                        t.guide_page_title,
                        textAlign: TextAlign.start,
                        style: theme.textTheme.displayMedium?.copyWith(
                          color: colors.onSurface,
                          fontWeight: FontWeight.w800,
                          letterSpacing: -0.5,
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Container(
                      padding: const EdgeInsetsDirectional.only(end: 20),
                      child: Text(
                        t.guide_page_subtitle,
                        textAlign: TextAlign.start,
                        style: theme.textTheme.displayMedium?.copyWith(
                          fontSize: 12,
                          color: colors.onSurface.withOpacity(0.6),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Container(
                padding: const EdgeInsetsDirectional.only(start: 30),
                child: Text(
                  t.main_departments,
                  textAlign: TextAlign.start,
                  style: theme.textTheme.titleLarge
                      ?.copyWith(color: colors.onSurface, fontWeight: FontWeight.w700),
                ),
              ),
              const SizedBox(height: 20),

              Padding(
                padding: const EdgeInsets.fromLTRB(20, 4, 20, 0),
                child: Column(
                  children: [
                    for (final section in GuideData.sections)
                      Padding(
                        padding: const EdgeInsets.only(bottom: 20),
                        child: SectionCard(section: section),
                      ),
                  ],
                ),
              ),

              Padding(
                padding: const EdgeInsets.fromLTRB(20, 4, 20, 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      alignment: AlignmentDirectional.centerStart,
                      padding: const EdgeInsetsDirectional.only(start: 10, bottom: 20),
                      child: Text(
                        t.good_to_know,
                        textAlign: TextAlign.start,
                        style: theme.textTheme.titleSmall
                            ?.copyWith(color: colors.onSurface, fontWeight: FontWeight.w700),
                      ),
                    ),
                    InfoTilesRow(sections: GuideData.infoSections),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}