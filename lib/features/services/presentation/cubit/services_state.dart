import 'package:hotel_app/features/services/domain/entites/services.dart';
import 'package:hotel_app/features/tasks/domain/entites/task.dart';
import 'package:equatable/equatable.dart';
sealed class ServicesState {}

final class ServicesInitial extends ServicesState {}

final class ServicesLoading extends ServicesState {}



class ServiceSuccess extends ServicesState with EquatableMixin {
  final List<ServiceEntity> services;
  final String filter;
  final Set<int> loadingIds;

  ServiceSuccess({
    required this.services,
    this.filter = 'all',
    this.loadingIds = const {},
  });

  @override
  List<Object?> get props => [services, filter, loadingIds];

  ServiceSuccess copyWith({
    List<ServiceEntity>? services,
    String? filter,
    Set<int>? loadingIds,
  }) {
    return ServiceSuccess(
      services: services ?? this.services,
      filter: filter ?? this.filter,
      loadingIds: loadingIds ?? this.loadingIds,
    );
  }
}


final class ServiceFail extends ServicesState {
  final String message;
  ServiceFail({required this.message});
}



