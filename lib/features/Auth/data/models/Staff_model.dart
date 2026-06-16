import 'package:hotel_app/features/Auth/domain/entities/Staff.dart';

class StaffModel extends Staff{
  StaffModel({
    required super.staff_id,
    required super.name,
    required super.email,
    required super.phone,
    required super.role,
    required super.dep_id,

});
  factory StaffModel.fromJson(Map<String,dynamic>json){
    return StaffModel(
        staff_id: json['staff_id'],
        name: json['name'],
        email: json['email'],
        phone: json['phone'],
        role: json['role'],
        dep_id: json['dep_id']
       );
  }
}