import 'dart:convert';
import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:hotel_app/features/services/data/data_sources/services_locale_data_sources.dart';
import 'package:hotel_app/features/services/data/model/services_model.dart';
import 'package:hotel_app/features/services/domain/entites/services.dart';
import 'package:hotel_app/features/tasks/data/data_sources/task_locale_data_sources.dart';
import 'package:hotel_app/features/tasks/domain/entites/task.dart';
import 'package:hotel_app/features/tasks/presentation/cubit/task_details_state.dart';
import 'package:http/http.dart' as http;

import '../../../../core/api/api.dart';
import '../../../../core/error/ exceptions.dart';
import '../../../Auth/data/datasource/auth_local_datasource.dart';
import '../../../language/data/datasources/language_local_datasource.dart';


abstract class ServicesRemoteDataSources{
  Future<List<ServiceEntity>>getAllServices();
  Future<ServiceEntity>StartService(int id);
  Future<ServiceEntity>EndService(int id);
}
const BASE_URL= ApiConstants.baseUrl;
class ServicesRemoteDataSourcesImpl implements ServicesRemoteDataSources{
  final AuthLocalDataSource authLocalDataSource;
  final http.Client client;
  final LanguageLocalDataSource localDataSource;
  final ServicesLocaleDataSources servicesLocaleDataSources;
  ServicesRemoteDataSourcesImpl({required this.client,required this.authLocalDataSource,required this.localDataSource,required this.servicesLocaleDataSources});
  @override
  Future<List<ServicesModel>> getAllServices() async{
    final token =await authLocalDataSource.getToken();
    final locale = await localDataSource.getLanguage();
    final response=await client.get(Uri.parse('$BASE_URL/service-requests'),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
          'Accept-language':locale
        });
    if (response.statusCode == 200) {
      final Map<String, dynamic> decodedJson = json.decode(response.body);

      final List<dynamic> data = decodedJson['data'];
      return data.map((e) => ServicesModel.fromJson(e)).toList();
    }
    else{
      throw ServerException();
    }
  }

  @override
  Future<ServicesModel> StartService(int id) async{
    final token= await authLocalDataSource.getToken();
    final locale=await localDataSource.getLanguage();
    final response=await client.patch(Uri.parse("$BASE_URL/service-requests/$id/start"),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
          'Accept-language':locale
        },
     );
    print(response.body);

    if (response.statusCode == 200) {
      final decodedJson = json.decode(response.body);
      final data = decodedJson['data'];
      return ServicesModel.fromJson(decodedJson['data']);
    }
    else{
      throw ServerException();
    }

  }
  @override
  Future<ServicesModel> EndService(int id) async {
    final token = await authLocalDataSource.getToken();
    final locale = await localDataSource.getLanguage();

    final response = await client.patch(
      Uri.parse("$BASE_URL/service-requests/$id/complete"),
      headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
        'Accept-language': locale
      },

    );

    print("Status: ${response.statusCode}");
    print("Body: ${response.body}");

    if (response.statusCode == 200) {
      final decodedJson = json.decode(response.body);
      final data = decodedJson['data'];
      return ServicesModel.fromJson(decodedJson['data']);
    } else {
      throw ServerException();
    }
  }




}