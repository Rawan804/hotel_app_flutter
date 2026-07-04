import '../../domain/entities/onboarding_entity.dart';


class OnboardingState {
  final int currentPage;
  final List<OnboardingPageEntity> pages;

  const OnboardingState({
    required this.currentPage,
    required this.pages,
  });

  factory OnboardingState.initial() {
    return const OnboardingState(
      currentPage: 0,
      pages: [],
    );
  }

  OnboardingState copyWith({
    int? currentPage,
    List<OnboardingPageEntity>? pages,
  }) {
    return OnboardingState(
      currentPage: currentPage ?? this.currentPage,
      pages: pages ?? this.pages,
    );
  }
}