import 'dart:convert';
import 'package:dartz/dartz.dart';
import 'package:hotel_app/core/error/exceptions.dart';
import 'package:hotel_app/features/Auth/data/models/User_model.dart';
import 'package:hotel_app/features/Auth/domain/entities/User.dart';
import 'package:http/http.dart' as http;

import '../../../../core/api/api.dart';
import '../../../../core/error/Apierrorhandler.dart';
import 'auth_local_datasource.dart';

abstract class AuthRemoteDataSource {
  Future<UserModel> login(String email, String password);
  Future<Unit> forgetPassword(String email);
  Future<bool> verifyOtp(String email, String otp);
  Future<UserModel> createNewPassword(String email, String password, String otp);
  Future<Unit> resend_OTP(String email);
  Future<Unit> logout();
}

const BASE_URL = ApiConstants.baseUrl;

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final AuthLocalDataSource authLocalDataSource;
  final http.Client client;
  AuthRemoteDataSourceImpl({required this.client, required this.authLocalDataSource});

  @override
  Future<UserModel> login(String email, String password) async {
    final response = await runHttpCall(
          () => client.post(
        Uri.parse("$BASE_URL/auth/login"),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({"email": email, "password": password}),
      ),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      final decodejson = json.decode(response.body);
      return UserModel.fromjson(decodejson);
    } else if (response.statusCode == 401 || response.statusCode == 422) {
      // بيانات دخول خاطئة تحديدًا، رسالة أوضح من رسالة الخطأ العامة
      throw ServerException(
        message: 'البريد الإلكتروني أو كلمة المرور غير صحيحة',
        statusCode: response.statusCode,
      );
    } else {
      throwApiException(response);
    }
  }

  @override
  Future<Unit> forgetPassword(String email) async {
    final response = await runHttpCall(
          () => client.post(
        Uri.parse("$BASE_URL/auth/send-otp"),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({"email": email}),
      ),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      return Future.value(unit);
    } else if (response.statusCode == 404) {
      throw ServerException(
        message: 'لا يوجد حساب مرتبط بهذا البريد الإلكتروني',
        statusCode: response.statusCode,
      );
    } else {
      throwApiException(response);
    }
  }

  @override
  Future<Unit> resend_OTP(String email) async {
    final response = await runHttpCall(
          () => client.post(
        Uri.parse("$BASE_URL/auth/resend-otp"),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({"email": email}),
      ),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      return Future.value(unit);
    } else if (response.statusCode == 429) {
      throw ServerException(
        message: 'يرجى الانتظار قليلًا قبل طلب رمز جديد',
        statusCode: response.statusCode,
      );
    } else {
      throwApiException(response);
    }
  }

  @override
  Future<bool> verifyOtp(String email, String otp) async {
    final response = await runHttpCall(
          () => client.post(
        Uri.parse("$BASE_URL/auth/verify-otp"),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({"email": email, "otp": otp}),
      ),
    );

    if (response.statusCode == 200) {
      return true;
    } else if (response.statusCode == 401 || response.statusCode == 422) {
      throw ServerException(
        message: 'الرمز غير صحيح أو انتهت صلاحيته',
        statusCode: response.statusCode,
      );
    } else {
      throwApiException(response);
    }
  }

  @override
  Future<UserModel> createNewPassword(String email, String otp, String password) async {
    final response = await runHttpCall(
          () => client.post(
        Uri.parse("$BASE_URL/auth/reset-password"),
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json',
        },
        body: jsonEncode({"email": email, "otp": otp, "password": password}),
      ),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      final decodejson = json.decode(response.body);
      return UserModel.fromjson(decodejson);
    } else {
      throwApiException(response);
    }
  }

  @override
  Future<Unit> logout() async {
    final token = await authLocalDataSource.getToken();
    final response = await runHttpCall(
          () => client.post(
        Uri.parse("$BASE_URL/auth/logout"),
        headers: {
          "Content-Type": "application/json",
          'Authorization': 'Bearer $token',
        },
      ),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      return unit;
    } else {
      throwApiException(response);
    }
  }
}
