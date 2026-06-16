import 'package:equatable/equatable.dart';

class Staff extends Equatable{
  final int staff_id;
  final String name;
  final String email;
  final String phone;
  final String role;
  final int dep_id;

  Staff({required this.staff_id,required this.name,required this.email,required this.phone,required this.role,required this.dep_id});

  @override
  // TODO: implement props
  List<Object?> get props => [staff_id,name,email,phone,role,dep_id];

}