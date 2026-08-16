import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../../../core/api/api.dart';
import '../../../../core/error/Apierrorhandler.dart';
import '../../../Auth/data/datasource/auth_local_datasource.dart';

abstract class Leave_Remote_Data_Sources {
  Future<String> addLeaveRequest(
      DateTime start_date, DateTime end_date, String reason, String type);
}

const BASE_URL = ApiConstants.baseUrl;

class Leave_Remote_Data_Sources_Impl implements Leave_Remote_Data_Sources {
  final http.Client client;
  final AuthLocalDataSource authLocalDataSource;
  Leave_Remote_Data_Sources_Impl(
      {required this.client, required this.authLocalDataSource});

  @override
  Future<String> addLeaveRequest(DateTime start_date, DateTime end_date,
      String reason, String type) async {
    final token = await authLocalDataSource.getToken();

    final response = await runHttpCall(
          () => client.post(
        Uri.parse("$BASE_URL/leaveRequests"),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: jsonEncode({
          "start_date": start_date.toIso8601String(),
          "end_date": end_date.toIso8601String(),
          "reason": reason,
          "type": type,
        }),
      ),
    );

    if (response.statusCode == 201 || response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data['message'] ?? 'تم إرسال طلب الإجازة بنجاح';
    } else {
      throwApiException(response);
    }
  }
}
