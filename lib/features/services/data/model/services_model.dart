import 'package:hotel_app/features/services/domain/entites/services.dart';
import 'package:hotel_app/features/tasks/data/models/task_item_model.dart';

class ServicesModel extends ServiceEntity {
  ServicesModel({
    required super.id,
    required super.service_name,
    required super.service_location,
    required super.details,
    required super.status,

  });

  factory ServicesModel.fromJson(Map<String, dynamic> json) {
    return ServicesModel(
      id: json['id'] is int ? json['id'] : int.tryParse('${json['id']}') ?? 0,
      service_name: json['service_name']?.toString() ?? '',
      service_location: json['service_location']?.toString() ?? '',
      details: json['details']?.toString() ?? '',
      status: json['status']?.toString() ?? '',
    );
  }
}