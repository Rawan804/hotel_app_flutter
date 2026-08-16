import 'package:dartz/dartz.dart';
import 'package:hotel_app/core/error/exceptions.dart';
import 'package:hotel_app/features/news/data/data_sources/news_remote_datasource.dart';
import 'package:hotel_app/features/news/domain/repositories/news_repositories.dart';

import '../../../../core/error/failures.dart';
import '../../domain/entities/news.dart';

class NewsRepositoriesImpl implements NewsRepositories {
  final NewsRemoteDataSources newsRemoteDataSources;

  NewsRepositoriesImpl({
    required this.newsRemoteDataSources,
  });

  @override
  Future<Either<Failure, List<News>>> getAllNews() async {
    try {
      final remoteNews = await newsRemoteDataSources.getAllNews();
      return Right(remoteNews);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } on NetworkException catch (e) {
      return Left(NetworkFailure(e.message));
    } on UnauthorizedException catch (e) {
      return Left(UnauthorizedFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, News>> getAllNewsDetails(int id) async {
    try {
      final remoteNewsDetails = await newsRemoteDataSources.getAllDetailsNews(id);
      return Right(remoteNewsDetails);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } on NetworkException catch (e) {
      return Left(NetworkFailure(e.message));
    } on UnauthorizedException catch (e) {
      return Left(UnauthorizedFailure(e.message));
    }
  }
}
