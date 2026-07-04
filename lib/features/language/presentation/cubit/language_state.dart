import 'package:flutter/material.dart';

class LanguageState {
  final Locale locale;
  const LanguageState(this.locale);

  @override
  bool operator ==(Object other) =>
     identical(this, other) ||
          other is LanguageState &&
              locale.languageCode == other.locale.languageCode;

  @override
  int get hashCode => locale.languageCode.hashCode;
}