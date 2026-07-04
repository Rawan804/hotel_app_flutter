import 'package:dartz/dartz.dart';
import 'package:hotel_app/core/error/failures.dart';
import 'package:hotel_app/features/news/domain/entities/news.dart';
import 'package:hotel_app/features/news/domain/repositories/news_repositories.dart';

class GetAllNewsUseCase{
  final NewsRepositories newsRepositories;
  GetAllNewsUseCase(this.newsRepositories);
  Future<Either<Failure,List<News>>>call()async{
  return  await newsRepositories.getAllNews();
}
}