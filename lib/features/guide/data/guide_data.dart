import 'package:flutter/material.dart';
import '../models/guide_models.dart';

class GuideData {
  GuideData._();

  static const List<GuideSection> sections = [
    GuideSection(
      titleKey: 'reception_title',
      subtitleKey: 'reception_subtitle',
      detailsKey: 'reception_details',
      imagePath: 'images/9.jpg',
      icon: Icons.room_service_rounded,
    ),
    GuideSection(
      titleKey: 'housekeeping_title',
      subtitleKey: 'housekeeping_subtitle',
      detailsKey: 'housekeeping_details',
      imagePath: 'images/img_2.png',
      icon: Icons.cleaning_services_rounded,
    ),
    GuideSection(
      titleKey: 'kitchen_title',
      subtitleKey: 'kitchen_subtitle',
      detailsKey: 'kitchen_details',
      imagePath: 'images/2.jpg',
      icon: Icons.restaurant_rounded,
    ),
    GuideSection(
      titleKey: 'guest_services_title',
      subtitleKey: 'guest_services_subtitle',
      detailsKey: 'guest_services_details',
      imagePath: 'images/3.jpg',
      icon: Icons.support_agent_rounded,
    ),
  ];

  static const List<InfoSection> infoSections = [
    InfoSection(
      titleKey: 'emergency_title',
      subtitleKey: 'emergency_subtitle',
      itemsKey: 'emergency_items',
      icon: Icons.emergency_rounded,
      accent: Color(0xFFE63946),
    ),
    InfoSection(
      titleKey: 'ethics_title',
      subtitleKey: 'ethics_subtitle',
      itemsKey: 'ethics_items',
      icon: Icons.verified_user_rounded,
      accent: Color(0xFF4834D4),
    ),
  ];
}
