import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hotel_app/Theme/theme_state.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../core/theme/app_theme.dart';

class ThemeCubit extends Cubit<ThemeState> {
  static const _prefsKey = 'selected_theme';

  ThemeCubit()
      : super(ThemeState(
    themeType: AppThemeType.warmLinen,
    themeData: AppThemes.build(AppThemeType.warmLinen),
  )) {
    _loadSavedTheme();
  }

  Future<void> _loadSavedTheme() async {
    final prefs = await SharedPreferences.getInstance();
    final savedName = prefs.getString(_prefsKey);

    if (savedName != null) {
      final matchedType = AppThemeType.values.firstWhere(
            (type) => type.name == savedName,
        orElse: () => AppThemeType.warmLinen,
      );

      emit(ThemeState(
        themeType: matchedType,
        themeData: AppThemes.build(matchedType),
      ));
    }
  }

  Future<void> setTheme(AppThemeType type) async {
    emit(ThemeState(
      themeType: type,
      themeData: AppThemes.build(type),
    ));

    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_prefsKey, type.name);
  }
}