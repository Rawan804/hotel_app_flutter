import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:hotel_app/features/news/domain/entities/news.dart';
import 'package:meta/meta.dart';

import '../../../language/presentation/cubit/language_cubit.dart';
import '../../domain/use_cases/get_all_news.dart';

part 'news_state.dart';
class NewsCubit extends Cubit<NewsState> {
  final GetAllNewsUseCase getAllNewsUseCase;

  NewsCubit(this.getAllNewsUseCase,this.languageCubit) : super(NewsInitial()){

    _languageSub = languageCubit.stream.listen((_) {
      getAllNews();
    }

    );
  }
  final LanguageCubit languageCubit;
  late final StreamSubscription _languageSub;

  @override
  Future<void> close() {
    _languageSub.cancel();
    return super.close();
  }

  Future<void> getAllNews() async {
    emit(NewsLoading());

    final result = await getAllNewsUseCase();

    result.fold(
          (failure) {
        emit(NewsFail(message: failure.message));
      },
          (newsList) {
        emit(NewsSuccess(news: newsList));
      },
    );
  }
  void changeIndex(int newIndex) {
    final currentState = state;
    if (currentState is NewsSuccess) {
      emit(currentState.copyWith(currentIndex: newIndex));
    }
  }
}