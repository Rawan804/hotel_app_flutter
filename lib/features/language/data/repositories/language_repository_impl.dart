import '../../domain/repositories/language_repository.dart';
import '../datasources/language_local_datasource.dart';

class LanguageRepositoryImpl implements LanguageRepository {
  final LanguageLocalDataSource dataSource;
  LanguageRepositoryImpl(this.dataSource);

  @override
  Future<String> getSavedLanguage() => dataSource.getLanguage();

  @override
  Future<void> saveLanguage(String languageCode) =>
      dataSource.saveLanguage(languageCode);
}