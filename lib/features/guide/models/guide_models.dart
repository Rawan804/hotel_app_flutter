import 'package:flutter/material.dart';

@immutable
class GuideSection {
  final String titleKey;
  final String subtitleKey;
  final String detailsKey;
  final String imagePath;
  final IconData icon;

  const GuideSection({
    required this.titleKey,
    required this.subtitleKey,
    required this.detailsKey,
    required this.imagePath,
    required this.icon,
  });
}


@immutable
class InfoSection {
  final String titleKey;
  final String subtitleKey;
  final String itemsKey;
  final IconData icon;
  final Color accent;

  const InfoSection({
    required this.titleKey,
    required this.subtitleKey,
    required this.itemsKey,
    required this.icon,
    required this.accent,
  });
}
