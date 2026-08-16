import 'dart:ui';

import 'package:shared_preferences/shared_preferences.dart';
abstract class AuthLocalDataSource {
  Future<void> saveToken(String token);
  Future<void> saveImage(String image);


  Future<void> savename(String name);
  Future<String?> getImage();
  Future<String?> getName();
  Future<String?> getToken();

  Future<void> removeToken();
}
class AuthLocalDataSourceImpl implements AuthLocalDataSource {

  final SharedPreferences prefs;
  AuthLocalDataSourceImpl(this.prefs);

  @override
  Future<void> saveToken(String token) async {
    await prefs.setString('token', token);
  }

  @override
  Future<String?> getToken() async {
    return prefs.getString('token');
  }

  @override
  Future<void> removeToken() async {
    await prefs.remove('token');
  }

  @override
  Future<void> saveImage(String image)async {
    await prefs.setString('image', image);
  }

  @override
  Future<void> savename(String name)async {
    await prefs.setString('name', name);
  }

  @override
  Future<String?> getImage() async {
    return prefs.getString('image');
  }

  @override
  Future<String?> getName() async {
    return prefs.getString('name');
  }


}