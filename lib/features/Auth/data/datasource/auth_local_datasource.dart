import 'package:shared_preferences/shared_preferences.dart';
abstract class AuthLocalDataSource {
  Future<void> saveToken(String token);

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
}