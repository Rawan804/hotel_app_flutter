import 'package:dartz/dartz.dart';
import 'package:hotel_app/core/error/failures.dart';
import 'package:hotel_app/features/complaints_request/domain/repositories/complaints_repositories.dart';

class AddComplaintsUseCase {
final ComplaintsRepositories complaintsRepositories;
AddComplaintsUseCase(this.complaintsRepositories);
Future<Either<Failure,Unit>>call(String title,String description)async{
  return complaintsRepositories.addComplaint(title, description);
}
}