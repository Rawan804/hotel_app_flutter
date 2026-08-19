import 'package:flutter/material.dart';

import '../../../../core/api/api.dart';
import '../../../../l10n/app_localizations.dart';

class HeaderCard extends StatelessWidget {
  final String name;
  final String imageUrl;
  final int totalItems;
  final int completedItems;

  const HeaderCard({
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

    // ✅ نبني الرابط الكامل مرة وحدة هون، ونستخدمه بكل مكان بالودجت
    final fullImageUrl = ApiConstants.imageUrl(imageUrl);

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
                    l.goodluckwithyourtasks,
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
                  GestureDetector(
                    onTap: () => _showProfileImage(context, fullImageUrl),
                    child: Hero(
                      tag: 'profile_image',
                      child: CircleAvatar(
                        radius: 28,
                        backgroundImage: NetworkImage(fullImageUrl),
                        onBackgroundImageError: (_, __) {
                          // ما يكسر الواجهة لو الصورة فشلت بالتحميل
                        },
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
                _StatItem(title: l.in_progress, value: totalItems - completedItems),
                _Divider(),
                _StatItem(title: l!.done, value: completedItems),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// ملاحظة: صار اسمها _showProfileImage (private) لأنها مو مفروض تنستدعى
  /// من برا هالملف، وصار الرابط يوصلها جاهز (fullImageUrl) بدل ما تبنيه هي بنفسها.
  void _showProfileImage(BuildContext context, String fullImageUrl) {
    showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: '',
      barrierColor: Colors.black87,
      transitionDuration: const Duration(milliseconds: 250),
      pageBuilder: (context, anim1, anim2) => GestureDetector(
        onTap: () => Navigator.pop(context),
        child: Center(
          child: Hero(
            tag: 'profile_image',
            child: InteractiveViewer(
              minScale: 1.0,
              maxScale: 2.0,
              child: SizedBox(
                width: 230,
                height: 250,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(300),
                  child: Image.network(
                    fullImageUrl,
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) => Container(
                      width: 230,
                      height: 230,
                      color: Colors.grey.shade800,
                      child: const Icon(Icons.person, color: Colors.white54, size: 80),
                    ),
                  ),
                ),
              ),
            ),
          ),

        ),
      ),
      transitionBuilder: (context, anim, secondaryAnim, child) =>
          FadeTransition(opacity: anim, child: child),
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