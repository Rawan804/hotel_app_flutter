abstract class LanguageRepository {
  Future<String> getSavedLanguage();
  Future<void> saveLanguage(String languageCode);
}