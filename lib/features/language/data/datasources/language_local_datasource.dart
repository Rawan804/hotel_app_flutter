import 'package:shared_preferences/shared_preferences.dart';

abstract class LanguageLocalDataSource {
  Future<String> getLanguage();
  Future<void> saveLanguage(String code);
}

class LanguageLocalDataSourceImpl implements LanguageLocalDataSource {
  static const _key = 'selected_language';
  @override
  Future<String> getLanguage() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_key) ?? 'en';
  }
  @override
  Future<void> saveLanguage(String code) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_key, code);
  }
}