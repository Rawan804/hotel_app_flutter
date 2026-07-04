import '../repositories/language_repository.dart';

class SaveLanguageUseCase {
  final LanguageRepository repository;
  SaveLanguageUseCase(this.repository);

  Future<void> call(String languageCode) => repository.saveLanguage(languageCode);
}