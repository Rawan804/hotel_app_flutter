import 'package:hotel_app/features/Auth/data/models/Staff_model.dart';
import 'package:hotel_app/features/Auth/domain/entities/User.dart';

class UserModel extends User{
  UserModel({
    required super.token,
    required super.staff
});
  factory UserModel.fromjson(Map<String,dynamic>json){
    return UserModel(token: json['token'], staff: StaffModel.fromJson(json['staff']));
  }
}