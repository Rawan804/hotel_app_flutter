import '../../domain/entities/onboarding_entity.dart';
import '../../domain/repositories/onboarding_repository.dart';
import '../datasource/onboarding_local_data.dart';

class OnboardingRepositoryImpl
    implements OnboardingRepository {

  final OnboardingLocalDataSource localDataSource;

  OnboardingRepositoryImpl(this.localDataSource);

  @override
  Future<List<OnboardingPageEntity>> getPages() {
    return localDataSource.getPages();
  }
}