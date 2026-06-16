import 'package:equatable/equatable.dart';
import 'package:hotel_app/features/Auth/domain/entities/Staff.dart';

class User extends Equatable{
  final String token;
  final Staff staff;
 User({required this.token,required this.staff});
  @override
  List<Object?> get props =>[token,staff];

}