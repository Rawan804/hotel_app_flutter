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
      id: json['id'],
      service_name: json['service_name'],
      service_location: json['service_location'],
      details: json['details'],
      status: json['status'],
    );
  }
}