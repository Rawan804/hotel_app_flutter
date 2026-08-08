import 'package:shared_preferences/shared_preferences.dart';

abstract class ServicesLocaleDataSources{
  Future<void> saveId(int id);
  Future<int?> getId();
}
class ServiceLocaleDataSourcesImpl implements ServicesLocaleDataSources{
  final SharedPreferences prefs;
  ServiceLocaleDataSourcesImpl(this.prefs);
  @override
  Future<void> saveId(int id)async {
    await prefs.setInt('id', id);
  }
  @override
  Future<int?> getId() async{
    return prefs.getInt('id');

  }

}