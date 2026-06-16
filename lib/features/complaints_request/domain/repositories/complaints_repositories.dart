import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';

abstract class ComplaintsRepositories{
  Future<Either<Failure,Unit>>addComplaint(String title,String description);
}