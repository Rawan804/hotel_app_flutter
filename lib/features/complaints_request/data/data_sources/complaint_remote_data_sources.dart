import 'dart:convert';
import 'package:dartz/dartz.dart';
import 'package:hotel_app/features/Auth/data/datasource/auth_local_datasource.dart';
import 'package:http/http.dart' as http;
import '../../../../core/api/api.dart';
import '../../../../core/error/Apierrorhandler.dart';
import '../../../language/data/datasources/language_local_datasource.dart';


abstract class ComplaintsRemoteDataSources {
  Future<Unit> addComplaint(String title, String description);
}

const BASE_URL = ApiConstants.baseUrl;

class ComplaintsRemoteDataSourcesImpl implements ComplaintsRemoteDataSources {
  final AuthLocalDataSource authLocalDataSource;
  final http.Client client;
  final LanguageLocalDataSource localDataSource;
  ComplaintsRemoteDataSourcesImpl({
    required this.client,
    required this.authLocalDataSource,
    required this.localDataSource
  });

  @override
  Future<Unit> addComplaint(String title, String description) async {
    final token = await authLocalDataSource.getToken();
    final locale = await localDataSource.getLanguage();
    final response = await runHttpCall(
          () => client.post(
        Uri.parse("$BASE_URL/complaints"),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Accept-language': locale,
        },
        body: jsonEncode({
          "title": title,
          "description": description,
        }),
      ),
    );

    if (response.statusCode == 201 || response.statusCode == 200) {
      return Future.value(unit);
    } else {
      throwApiException(response);
    }
  }
}
