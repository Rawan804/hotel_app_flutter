import '../repositories/language_repository.dart';

class GetLanguageUseCase {
  final LanguageRepository repository;
  GetLanguageUseCase(this.repository);

  Future<String> call() => repository.getSavedLanguage();
}