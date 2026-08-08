import 'dart:convert';
import 'package:dartz/dartz.dart';
import 'package:hotel_app/core/error/%20exceptions.dart';
import 'package:hotel_app/features/Auth/data/models/User_model.dart';
import 'package:hotel_app/features/Auth/domain/entities/User.dart';
import 'package:http/http.dart'as http;

import '../../../../core/api/api.dart';
abstract class AuthRemoteDataSource{
  Future<UserModel>login(String email,String password);
  Future<Unit>forgetPassword(String email);
  Future<bool>verifyOtp(String email, String otp);
  Future<UserModel> createNewPassword(String email, String password, String otp);
  Future<Unit> resend_OTP(String email);
}
const BASE_URL= ApiConstants.baseUrl;
class AuthRemoteDataSourceImpl implements AuthRemoteDataSource{
  final http.Client client;
  AuthRemoteDataSourceImpl({required this.client});

  @override
  Future<UserModel> login(String email, String password)async {
   final response=await client.post(Uri.parse("$BASE_URL/auth/login"),

     headers: {
       "Content-Type": "application/json",
     },body: jsonEncode({
         "email":email,"password":password
       })
   );
   print(response.statusCode);
   print(response.body);
   if(response.statusCode==200||response.statusCode==201){
     final decodejson=json.decode(response.body);
     return UserModel.fromjson(decodejson);
   }
   else{

     throw ServerException();
   }
  }
  @override
  Future<Unit>forgetPassword(String email) async{
final response=await client.post(Uri.parse("$BASE_URL/auth/send-otp"),
  headers: {
    "Content-Type": "application/json",
  },
  body: jsonEncode({"email":email})
);
if(response.statusCode!=200){
  throw ServerException();
}
else{
  return Future.value(unit);
}

  }
  @override
  Future<Unit>resend_OTP(String email) async{
    final response=await client.post(Uri.parse("$BASE_URL/auth/resend-otp"),
        headers: {
          "Content-Type": "application/json",
        },
        body: jsonEncode({"email":email})
    );
    if(response.statusCode!=200){
      throw ServerException();
    }
    else{
      return Future.value(unit);
    }

  }
  @override
  Future<bool> verifyOtp(String email, String otp)async {

  final response=await client.post(Uri.parse("$BASE_URL/auth/verify-otp")
  ,headers: {
        "Content-Type": "application/json",
      },
      body: jsonEncode({"email":email,"otp":otp})
  );
  if(response.statusCode==200){
    return true;
  }
  else{

    return false;
  }

  }
  @override
  Future<UserModel> createNewPassword(String email, String otp, String password,) async {
    print("EMAIL = $email");
    print("OTP = $otp");
    print("PASSWORD = $password");

    final body = {
      "email": email,
      "otp": otp,
      "password": password,
    };

    print(body);
    final response = await client.post(
      Uri.parse("$BASE_URL/auth/reset-password"),
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json',
        },
      body: jsonEncode({
        "email": email,
        "otp": otp,
        "password": password,

      }),

    );
    print(response.statusCode);
    print(response.request?.url);
    print(response.headers);
    print(response.body);
    if (response.statusCode == 200 || response.statusCode == 201) {
      final decodejson = json.decode(response.body);
      return UserModel.fromjson(decodejson);

    }
    else {
      throw ServerException();
    }

  }

}