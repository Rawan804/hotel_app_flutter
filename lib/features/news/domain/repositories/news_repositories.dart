import 'package:dartz/dartz.dart';
import 'package:hotel_app/core/error/failures.dart';
import 'package:hotel_app/features/news/domain/entities/news.dart';
abstract class NewsRepositories {
  Future<Either<Failure, List<News>>> getAllNews();
  Future<Either<Failure,News>>getAllNewsDetails(int id);
}