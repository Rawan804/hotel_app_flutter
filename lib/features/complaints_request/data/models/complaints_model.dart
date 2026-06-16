import 'package:hotel_app/features/complaints_request/domain/entities/complaints.dart';


class ComplaintModel {
  final int id;
  final String title;
  final String description;
  final String status;

  ComplaintModel({
    required this.id,
    required this.title,
    required this.description,
    required this.status,
  });

  factory ComplaintModel.fromJson(Map<String, dynamic> json) {
    final data = json['data'];

    return ComplaintModel(
      id: data['com_id'],
      title: data['title'],
      description: data['description'],
      status: data['status'],
    );
  }

  Complaints toEntity() {
    return Complaints(
      id: id,
      title: title,
      description: description,
      status: status,
    );
  }
}