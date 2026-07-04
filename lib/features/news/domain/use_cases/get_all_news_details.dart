import 'package:dartz/dartz.dart';
import 'package:hotel_app/core/error/failures.dart';
import 'package:hotel_app/features/news/domain/entities/news.dart';
import 'package:hotel_app/features/news/domain/repositories/news_repositories.dart';

class GetAllNewsDetailsUseCase{
  final NewsRepositories newsRepositories;
  GetAllNewsDetailsUseCase(this.newsRepositories);
  Future<Either<Failure,News>>call(int id)async{
    return await newsRepositories.getAllNewsDetails(id);
  }
}