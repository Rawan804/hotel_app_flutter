import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hotel_app/Theme/theme_state.dart';

import '../core/theme/app_theme.dart';
class ThemeCubit extends Cubit<ThemeState> {
  ThemeCubit()
      : super(ThemeState(
    themeType: AppThemeType.warmLinen,
    themeData: AppThemes.build(AppThemeType.warmLinen),
  ));

  void setTheme(AppThemeType type) {
    emit(ThemeState(
      themeType: type,
      themeData: AppThemes.build(type),
    ));
  }
}