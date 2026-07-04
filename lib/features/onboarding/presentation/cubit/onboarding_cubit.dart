import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/usecases/get_onboarding_pages.dart';
import 'onboarding_state.dart';

class OnboardingCubit extends Cubit<OnboardingState> {
  final GetOnboardingPages getOnboardingPages;

  OnboardingCubit(this.getOnboardingPages)
      : super(OnboardingState.initial());

  Future<void> loadPages() async {
    final pages = await getOnboardingPages();

    emit(
      state.copyWith(
        pages: pages,
      ),
    );
  }

  void changePage(int index) {
    emit(
      state.copyWith(
        currentPage: index,
      ),
    );
  }
}