part of 'news_cubit.dart';

@immutable

sealed class NewsState {}

final class NewsInitial extends NewsState {}
final class NewsLoading extends NewsState{

}
class NewsSuccess extends NewsState {
  final List<News> news;
  final int currentIndex;

  NewsSuccess({
    required this.news,
    this.currentIndex = 0,
  });

  NewsSuccess copyWith({
    List<News>? news,
    int? currentIndex,
  }) {
    return NewsSuccess(
      news: news ?? this.news,
      currentIndex: currentIndex ?? this.currentIndex,
    );
  }
}
final class NewsFail extends NewsState{
  final String message;
  NewsFail({required this.message});
}
class NewsSelected extends NewsState{
final int index;
  NewsSelected(this.index);
}
