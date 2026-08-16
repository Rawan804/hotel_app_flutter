import 'package:flutter/foundation.dart';
import '../../../../l10n/app_localizations.dart';
extension AppLocalizationsKeyLookup on AppLocalizations {
  static final Map<String, String Function(AppLocalizations)> _singleKeys = {
    'reception_title': (t) => t.reception_title,
    'reception_subtitle': (t) => t.reception_subtitle,

    'housekeeping_title': (t) => t.housekeeping_title,
    'housekeeping_subtitle': (t) => t.housekeeping_subtitle,

    'kitchen_title': (t) => t.kitchen_title,
    'kitchen_subtitle': (t) => t.kitchen_subtitle,

    'guest_services_title': (t) => t.guest_services_title,
    'guest_services_subtitle': (t) => t.guest_services_subtitle,

    'emergency_title': (t) => t.emergency_title,
    'emergency_subtitle': (t) => t.emergency_subtitle,

    'ethics_title': (t) => t.ethics_title,
    'ethics_subtitle': (t) => t.ethics_subtitle,
  };
  static final Map<String, List<String Function(AppLocalizations)>>
  _listKeys = {
    'reception_details': [
          (t) => t.reception_details_0,
          (t) => t.reception_details_1,
          (t) => t.reception_details_2,
          (t) => t.reception_details_3,
          (t) => t.reception_details_4,
          (t) => t.reception_details_5,
          (t) => t.reception_details_6,
    ],
    'housekeeping_details': [
          (t) => t.housekeeping_details_0,
          (t) => t.housekeeping_details_1,
          (t) => t.housekeeping_details_2,
          (t) => t.housekeeping_details_3,
          (t) => t.housekeeping_details_4,
          (t) => t.housekeeping_details_5,
          (t) => t.housekeeping_details_6,
    ],
    'kitchen_details': [
          (t) => t.kitchen_details_0,
          (t) => t.kitchen_details_1,
          (t) => t.kitchen_details_2,
          (t) => t.kitchen_details_3,
          (t) => t.kitchen_details_4,
          (t) => t.kitchen_details_5,
          (t) => t.kitchen_details_6,
    ],
    'guest_services_details': [
          (t) => t.guest_services_details_0,
          (t) => t.guest_services_details_1,
          (t) => t.guest_services_details_2,
          (t) => t.guest_services_details_3,
          (t) => t.guest_services_details_4,
          (t) => t.guest_services_details_5,
          (t) => t.guest_services_details_6,
    ],
    'emergency_items': [
          (t) => t.emergency_items_0,
          (t) => t.emergency_items_1,
          (t) => t.emergency_items_2,
          (t) => t.emergency_items_3,
          (t) => t.emergency_items_4,
          (t) => t.emergency_items_5,
          (t) => t.emergency_items_6,
    ],
    'ethics_items': [
          (t) => t.ethics_items_0,
          (t) => t.ethics_items_1,
          (t) => t.ethics_items_2,
          (t) => t.ethics_items_3,
          (t) => t.ethics_items_4,
          (t) => t.ethics_items_5,
          (t) => t.ethics_items_6,
    ],
  };
  String byKey(String key) {
    final getter = _singleKeys[key];
    if (getter == null) {
      if (kDebugMode) {
        debugPrint('⚠️ [L10n] missing single key: "$key"');
      }
      return key;
    }
    return getter(this);
  }
  List<String> byKeyList(String baseKey) {
    final getters = _listKeys[baseKey];
    if (getters == null) {
      if (kDebugMode) {
        debugPrint('⚠️ [L10n] missing list key: "$baseKey"');
      }
      return const [];
    }
    return [for (final getter in getters) getter(this)];
  }
}