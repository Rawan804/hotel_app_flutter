import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hotel_app/l10n/app_localizations.dart';

import '../Theme/theme_cubit.dart';
import 'core/theme/app_theme.dart';

class ThemePage extends StatelessWidget {
  const ThemePage({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    final currentType = context.watch<ThemeCubit>().state.themeType;

    return Scaffold(
      appBar: _ThemePageAppBar(title: l10n.appearance),
      body: CustomScrollView(
        slivers: [
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 28),
            sliver: SliverToBoxAdapter(
              child: _ThemePageHeader(
                title: l10n.chooseYourTheme,
                subtitle: l10n.selectapalettethatfitsyourmood,
                theme: theme,
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            sliver: SliverList.separated(
              itemCount: AppThemeType.values.length,
              separatorBuilder: (_, __) => const SizedBox(height: 12),
              itemBuilder: (context, index) {
                final type = AppThemeType.values[index];
                final meta = themeMeta[type]!;

                return _ThemeCard(
                  meta: meta,
                  isSelected: type == currentType,
                  onTap: () => context.read<ThemeCubit>().setTheme(type),
                );
              },
            ),
          ),
          const SliverPadding(padding: EdgeInsets.only(bottom: 24)),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────
//  App Bar
// ─────────────────────────────────────────────
class _ThemePageAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;

  const _ThemePageAppBar({required this.title});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return AppBar(
      backgroundColor: theme.colorScheme.surface,
      title: Text(
        title,
        style: TextStyle(color: theme.colorScheme.primary),
      ),
    );
  }
}
class _ThemePageHeader extends StatelessWidget {
  final String title;
  final String subtitle;
  final ThemeData theme;

  const _ThemePageHeader({
    required this.title,
    required this.subtitle,
    required this.theme,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: theme.textTheme.displayMedium),
        const SizedBox(height: 8),
        Text(subtitle, style: theme.textTheme.bodyMedium),
      ],
    );
  }
}

// ─────────────────────────────────────────────
//  Theme Card
// ─────────────────────────────────────────────
class _ThemeCard extends StatelessWidget {
  final ThemeMeta meta;
  final bool isSelected;
  final VoidCallback onTap;

  const _ThemeCard({
    required this.meta,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 220),
        curve: Curves.easeInOut,
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
        decoration: BoxDecoration(
          color: theme.cardTheme.color,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isSelected
                ? meta.previewAccent
                : meta.previewColor.withOpacity(0.3),
            width: isSelected ? 2 : 1,
          ),
          boxShadow: isSelected
              ? [
            BoxShadow(
              color: meta.previewAccent.withOpacity(0.18),
              blurRadius: 16,
              offset: const Offset(0, 4),
            ),
          ]
              : const [],
        ),
        child: Row(
          children: [
            _ColorDots(primary: meta.previewColor, accent: meta.previewAccent),
            const SizedBox(width: 16),
            Expanded(
              child: Row(
                children: [
                  Text(meta.emoji, style: const TextStyle(fontSize: 18)),
                  const SizedBox(width: 8),
                  Flexible(
                    child: Text(
                      meta.label(context),
                      overflow: TextOverflow.ellipsis,
                      style: theme.textTheme.titleMedium
                          ?.copyWith(fontWeight: FontWeight.w600),
                    ),
                  ),
                ],
              ),
            ),
            _SelectedCheckMark(
              isSelected: isSelected,
              color: meta.previewAccent,
            ),
          ],
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────
//  Selected Check Mark
// ─────────────────────────────────────────────
class _SelectedCheckMark extends StatelessWidget {
  final bool isSelected;
  final Color color;

  const _SelectedCheckMark({required this.isSelected, required this.color});

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      opacity: isSelected ? 1 : 0,
      duration: const Duration(milliseconds: 200),
      child: Container(
        width: 26,
        height: 26,
        decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        child: const Icon(Icons.check, size: 16, color: Colors.black),
      ),
    );
  }
}

// ─────────────────────────────────────────────
//  Color Preview Dots
// ─────────────────────────────────────────────
class _ColorDots extends StatelessWidget {
  final Color primary;
  final Color accent;

  const _ColorDots({required this.primary, required this.accent});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 48,
      height: 48,
      child: Stack(
        children: [
          Positioned(left: 0, top: 0, child: _dot(primary, 38)),
          Positioned(right: 0, bottom: 0, child: _dot(accent, 28)),
        ],
      ),
    );
  }

  Widget _dot(Color color, double size) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
        border: Border.all(color: Colors.white.withOpacity(0.15), width: 1),
      ),
    );
  }
}