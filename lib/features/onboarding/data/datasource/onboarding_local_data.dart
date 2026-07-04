import 'package:shared_preferences/shared_preferences.dart';

import '../../../../l10n/app_localizations.dart';
import '../models/onboarding_model.dart';

abstract class OnboardingLocalDataSource {
  Future<List<OnboardingPageModel>> getPages();

  Future<bool> isOnboardingSeen();

  Future<void> saveOnboardingSeen();
}

class OnboardingLocalDataSourceImpl
    implements OnboardingLocalDataSource {

  final SharedPreferences prefs;

  OnboardingLocalDataSourceImpl(this.prefs);

  @override
  Future<bool> isOnboardingSeen() async {
    return prefs.getBool('onboarding_seen') ?? false;
  }

  @override
  Future<void> saveOnboardingSeen() async {
    await prefs.setBool(
      'onboarding_seen',
      true,
    );
  }
  @override
  Future<List<OnboardingPageModel>> getPages() async {
    return const [
      OnboardingPageModel(
        title: 'onboardingTitle1',
        description: 'onboardingDesc1',
        illustrationType: 'welcome',
      ),
      OnboardingPageModel(
        title: 'onboardingTitle2',
        description: 'onboardingDesc2',
        illustrationType: 'tasks',
      ),
      OnboardingPageModel(
        title: 'onboardingTitle3',
        description: 'onboardingDesc3',
        illustrationType: 'motivation',
      ),
      OnboardingPageModel(
        title: 'onboardingTitle4',
        description: 'onboardingDesc4',
        illustrationType: 'workflow',
      ),
    ];
  }
}