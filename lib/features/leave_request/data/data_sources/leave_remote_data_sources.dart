import 'dart:convert';
import 'package:hotel_app/core/error/%20exceptions.dart';
import 'package:http/http.dart' as http;
import '../../../Auth/data/datasource/auth_local_datasource.dart';
abstract class Leave_Remote_Data_Sources{
  Future<String>addLeaveRequest(DateTime start_date,DateTime end_date,String reason,String type);
}
const BASE_URL="http://192.168.1.7:8000/api";
class Leave_Remote_Data_Sources_Impl implements Leave_Remote_Data_Sources{
  final http.Client client;
  final AuthLocalDataSource authLocalDataSource;
  Leave_Remote_Data_Sources_Impl({required this.client,required this.authLocalDataSource});
  @override
  Future<String> addLeaveRequest(DateTime start_date, DateTime end_date, String reason, String type)async {
 final token = await authLocalDataSource.getToken();
 print("TOKEN: $token");
 final response=await client.post(Uri.parse("$BASE_URL/leaveRequests"),

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
   })

 );
 print("STATUS CODE: ${response.statusCode}");
 print("RESPONSE DATA: ${response.body}");
 if (response.statusCode == 201) {
   final data = jsonDecode(response.body);
   return data['message'];
 }
else{
 throw ServerException();
}
  }
  
}