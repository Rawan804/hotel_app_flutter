
import 'package:dartz/dartz.dart';
import 'package:hotel_app/core/error/exceptions.dart';
import 'package:hotel_app/core/error/failures.dart';
import 'package:hotel_app/features/services/data/data_sources/services_locale_data_sources.dart';
import 'package:hotel_app/features/services/data/data_sources/services_remote_data_sources.dart';
import 'package:hotel_app/features/services/domain/entites/services.dart';
import 'package:hotel_app/features/services/domain/repositories/services_repositories.dart';


class ServicesRepositoriesImpl implements ServicesRepositories {
  final ServicesRemoteDataSources servicesRemoteDataSources;
  final ServicesLocaleDataSources servicesLocaleDataSources;

  ServicesRepositoriesImpl({
    required this.servicesRemoteDataSources,
    required this.servicesLocaleDataSources,
  });

  @override
  Future<Either<Failure, List<ServiceEntity>>> getService() async {
    try {
      final remoteservice = await servicesRemoteDataSources.getAllServices();
      return Right(remoteservice);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } on NetworkException catch (e) {
      return Left(NetworkFailure(e.message));
    } on UnauthorizedException catch (e) {
      return Left(UnauthorizedFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, ServiceEntity>> StartService(int id) async {
    try {
      final remoteservice = await servicesRemoteDataSources.StartService(id);
      return Right(remoteservice);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } on NetworkException catch (e) {
      return Left(NetworkFailure(e.message));
    } on UnauthorizedException catch (e) {
      return Left(UnauthorizedFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, ServiceEntity>> EndService(int id) async {
    try {
      final remoteservice = await servicesRemoteDataSources.EndService(id);
      return Right(remoteservice);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } on NetworkException catch (e) {
      return Left(NetworkFailure(e.message));
    } on UnauthorizedException catch (e) {
      return Left(UnauthorizedFailure(e.message));
    }
  }
}
