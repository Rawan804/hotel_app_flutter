import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:hotel_app/core/error/failures.dart';
import 'package:hotel_app/features/Auth/data/datasource/auth_local_datasource.dart';
import 'package:hotel_app/features/language/data/datasources/language_local_datasource.dart';
import 'package:hotel_app/features/news/data/models/news.dart';
import 'package:hotel_app/features/news/domain/entities/news.dart';
import 'package:http/http.dart' as http;

import '../../../../core/api/api.dart';
import '../../../../core/error/ exceptions.dart';
import '../../../../l10n/app_localizations.dart';

abstract class NewsRemoteDataSources{
  Future<List<NewsModel>>getAllNews();
  Future<NewsModel> getAllDetailsNews(int id);

}
const BASE_URL= ApiConstants.baseUrl;
class NewsRemoteDataSourcesImp implements NewsRemoteDataSources{
  final AuthLocalDataSource authLocalDataSource;
  final http.Client client;
  final LanguageLocalDataSource localDataSource;
NewsRemoteDataSourcesImp({required this.client,required this.authLocalDataSource,required this.localDataSource});
  @override
  Future<List<NewsModel>> getAllNews() async {
    final locale = await localDataSource.getLanguage();
    final token = await authLocalDataSource.getToken();

    final response = await client.get(
      Uri.parse('$BASE_URL/news'),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
        'Accept-language':locale
      },
    );
    print("NEWS STATUS = ${response.statusCode}");
    print("NEWS BODY = ${response.body}");
    if (response.statusCode == 200) {
      final List decodedJson = json.decode(response.body) as List;

      return (decodedJson as List)
          .map((e) => NewsModel.fromJson(e))
          .toList();
    }

    throw ServerException();
  }
  @override
  Future<NewsModel> getAllDetailsNews(int id) async {
    final token = await authLocalDataSource.getToken();

    final response = await client.get(
      Uri.parse('$BASE_URL/news/$id'),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      final decodedJson = json.decode(response.body);

      return NewsModel.fromDetailsJson(decodedJson);
    }

    throw ServerException();
  }

}