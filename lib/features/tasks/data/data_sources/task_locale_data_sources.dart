import 'package:shared_preferences/shared_preferences.dart';

abstract class TasksLocaleDataSource{
  Future<void> saveId(int id);
  Future<int?> getId();
}
class TasksLocaleDataSourcesImpl implements TasksLocaleDataSource{
  final SharedPreferences prefs;
  TasksLocaleDataSourcesImpl(this.prefs);

  @override
  Future<void> saveId(int id)async {
    await prefs.setInt('id', id);
  }


  @override
  Future<int?> getId() async{
    return prefs.getInt('id');

  }

}