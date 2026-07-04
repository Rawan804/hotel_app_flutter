import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hotel_app/l10n/app_localizations.dart';
import '../Theme/theme_cubit.dart';
import 'core/theme/app_theme.dart';   // عدّل المسار
        // عدّل المسار

class ThemePage extends StatelessWidget {
  const ThemePage({super.key});

  @override
  Widget build(BuildContext context) {
    final l=AppLocalizations.of(context);
    final currentType = context.watch<ThemeCubit>().state.themeType;
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title:  Text(l!.appearance),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 28),
        children: [
          // ── Header ────────────────────────────
          Text(
           l.chooseYourTheme,
            style: theme.textTheme.displayMedium,
          ),
          const SizedBox(height: 6),
          Text(
         l.selectapalettethatfitsyourmood,
            style: theme.textTheme.bodyMedium,
          ),
          const SizedBox(height: 32),

          // ── Theme Cards ───────────────────────
          ...AppThemeType.values.map((type) {
            final meta = themeMeta[type]!;
            final isSelected = type == currentType;

            return Padding(
              padding: const EdgeInsets.only(bottom: 14),
              child: _ThemeCard(
                meta: meta,
                isSelected: isSelected,
                onTap: () => context.read<ThemeCubit>().setTheme(type),
              ),
            );
          }),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────
//  Theme Card Widget
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
            )
          ]
              : [],
        ),
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
        child: Row(
          children: [
            // Color dots preview
            _ColorDots(primary: meta.previewColor, accent: meta.previewAccent),
            const SizedBox(width: 16),

            // Label
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(meta.emoji, style: const TextStyle(fontSize: 18)),
                      const SizedBox(width: 8),
                      Text(
                        meta.label,
                        style: theme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Selected check
            AnimatedOpacity(
              opacity: isSelected ? 1 : 0,
              duration: const Duration(milliseconds: 200),
              child: Container(
                width: 26,
                height: 26,
                decoration: BoxDecoration(
                  color: meta.previewAccent,
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.check, size: 16, color: Colors.black),
              ),
            ),
          ],
        ),
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
          Positioned(
            left: 0,
            top: 0,
            child: _dot(primary, 38),
          ),
          Positioned(
            right: 0,
            bottom: 0,
            child: _dot(accent, 28),
          ),
        ],
      ),
    );
  }

  Widget _dot(Color color, double size) => Container(
    width: size,
    height: size,
    decoration: BoxDecoration(
      color: color,
      shape: BoxShape.circle,
      border: Border.all(color: Colors.white.withOpacity(0.15), width: 1),
    ),
  );
}