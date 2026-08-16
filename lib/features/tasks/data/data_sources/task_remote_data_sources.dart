import 'dart:convert';
import 'package:hotel_app/features/tasks/data/data_sources/task_locale_data_sources.dart';
import 'package:hotel_app/features/tasks/domain/entites/task.dart';
import 'package:http/http.dart' as http;
import '../../../../core/api/api.dart';
import '../../../../core/error/Apierrorhandler.dart';
import '../../../Auth/data/datasource/auth_local_datasource.dart';
import '../../../language/data/datasources/language_local_datasource.dart';
import '../models/tasks.dart';

abstract class TaskRemoteDataSource {
  Future<List<TaskEntity>> getTask();
  Future<TaskEntity> toggleTask(int id);
  Future<void> endTask(int id);
}

const BASE_URL = ApiConstants.baseUrl;

class TaskRemoteDataSourceImpl implements TaskRemoteDataSource {
  final AuthLocalDataSource authLocalDataSource;
  final http.Client client;
  final LanguageLocalDataSource localDataSource;
  final TasksLocaleDataSource tasksLocaleDataSource;
  TaskRemoteDataSourceImpl({
    required this.client,
    required this.authLocalDataSource,
    required this.localDataSource,
    required this.tasksLocaleDataSource,
  });

  @override
  Future<List<TaskModel>> getTask() async {
    final token = await authLocalDataSource.getToken();
    final locale = await localDataSource.getLanguage();
    final response = await runHttpCall(
          () => client.get(
        Uri.parse('$BASE_URL/tasks/my'),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
          'Accept-language': locale,
        },
      ),
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> decodedJson = json.decode(response.body);
      final List<dynamic> data = decodedJson['data'];
      return data.map((e) => TaskModel.fromJson(e)).toList();
    } else {
      throwApiException(response);
    }
  }

  @override
  Future<TaskModel> toggleTask(int id) async {
    final token = await authLocalDataSource.getToken();
    final locale = await localDataSource.getLanguage();
    final response = await runHttpCall(
          () => client.post(
        Uri.parse("$BASE_URL/tasks/toggle-item"),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
          'Accept-language': locale,
        },
        body: jsonEncode({"task_item_id": id}),
      ),
    );

    if (response.statusCode == 200) {
      final decodedJson = json.decode(response.body);
      return TaskModel.fromJson(decodedJson['data']);
    } else {
      throwApiException(response);
    }
  }

  @override
  Future<void> endTask(int id) async {
    final token = await authLocalDataSource.getToken();
    final locale = await localDataSource.getLanguage();

    final response = await runHttpCall(
          () => client.post(
        Uri.parse("$BASE_URL/tasks/$id/complete"),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
          'Accept-language': locale,
        },
        body: jsonEncode({"id": id}),
      ),
    );

    if (response.statusCode == 200) {
      return; // ✅ نجح — ما نحتاج نحلل الـ response
    } else {
      throwApiException(response);
    }
  }
}
