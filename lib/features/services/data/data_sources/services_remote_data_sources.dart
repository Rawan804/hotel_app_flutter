import 'dart:convert';

import 'package:hotel_app/features/services/data/data_sources/services_locale_data_sources.dart';
import 'package:hotel_app/features/services/data/model/services_model.dart';
import 'package:hotel_app/features/services/domain/entites/services.dart';
import 'package:http/http.dart' as http;

import '../../../../core/api/api.dart';
import '../../../../core/error/Apierrorhandler.dart';
import '../../../../core/error/exceptions.dart';

import '../../../Auth/data/datasource/auth_local_datasource.dart';
import '../../../language/data/datasources/language_local_datasource.dart';

abstract class ServicesRemoteDataSources {
  Future<List<ServiceEntity>> getAllServices();
  Future<ServiceEntity> StartService(int id);
  Future<ServiceEntity> EndService(int id);
}

const BASE_URL = ApiConstants.baseUrl;

class ServicesRemoteDataSourcesImpl implements ServicesRemoteDataSources {
  final AuthLocalDataSource authLocalDataSource;
  final http.Client client;
  final LanguageLocalDataSource localDataSource;
  final ServicesLocaleDataSources servicesLocaleDataSources;
  ServicesRemoteDataSourcesImpl({
    required this.client,
    required this.authLocalDataSource,
    required this.localDataSource,
    required this.servicesLocaleDataSources,
  });

  @override
  Future<List<ServicesModel>> getAllServices() async {
    final token = await authLocalDataSource.getToken();
    final locale = await localDataSource.getLanguage();
    final response = await runHttpCall(
          () => client.get(
        Uri.parse('$BASE_URL/service-requests'),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
          'Accept-language': locale,
        },
      ),
    );

    if (response.statusCode == 200) {
      try {
        final Map<String, dynamic> decodedJson = json.decode(response.body);
        final List<dynamic> data = decodedJson['data'];
        return data.map((e) => ServicesModel.fromJson(e)).toList();
      } catch (_) {
        throw ServerException(message: 'تعذر قراءة بيانات الخدمات، حاول لاحقًا');
      }
    } else {
      throwApiException(response);
    }
  }

  @override
  Future<ServicesModel> StartService(int id) async {
    final token = await authLocalDataSource.getToken();
    final locale = await localDataSource.getLanguage();
    final response = await runHttpCall(
          () => client.patch(
        Uri.parse("$BASE_URL/service-requests/$id/start"),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
          'Accept-language': locale,
        },
      ),
    );

    if (response.statusCode == 200) {
      final decodedJson = json.decode(response.body);
      return ServicesModel.fromJson(decodedJson['data']);
    } else {
      throwApiException(response);
    }
  }

  @override
  Future<ServicesModel> EndService(int id) async {
    final token = await authLocalDataSource.getToken();
    final locale = await localDataSource.getLanguage();

    final response = await runHttpCall(
          () => client.patch(
        Uri.parse("$BASE_URL/service-requests/$id/complete"),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
          'Accept-language': locale,
        },
      ),
    );

    if (response.statusCode == 200) {
      final decodedJson = json.decode(response.body);
      return ServicesModel.fromJson(decodedJson['data']);
    } else {
      throwApiException(response);
    }
  }
}
