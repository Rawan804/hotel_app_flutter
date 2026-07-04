

import '../../domain/entities/onboarding_entity.dart';

class OnboardingPageModel extends OnboardingPageEntity {
  const OnboardingPageModel({
    required super.title,
    required super.description,
    required super.illustrationType,
  });

  factory OnboardingPageModel.fromJson(
      Map<String, dynamic> json,
      ) {
    return OnboardingPageModel(
      title: json['title'],
      description: json['description'],
      illustrationType: json['illustrationType'],
    );
  }
}