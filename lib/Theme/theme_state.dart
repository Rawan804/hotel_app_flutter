import 'package:flutter/material.dart' show ThemeData;

import '../core/theme/app_theme.dart';

class ThemeState {
 final AppThemeType themeType;
 final ThemeData themeData;

 const ThemeState({required this.themeType, required this.themeData});
}