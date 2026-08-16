import 'package:hotel_app/core/api/api.dart';
import 'package:hotel_app/features/Auth/domain/entities/Staff.dart';

class StaffModel extends Staff {
  StaffModel({
    required super.staff_id,
    required super.name,
    required super.email,
    required super.phone,
    required super.role,
    required super.dep_id,
    required super.image,
  });
  factory StaffModel.fromJson(Map<String, dynamic> json) {
    final rawImage = json['image'] as String? ?? '';
    return StaffModel(
      staff_id: json['staff_id'],
      name: json['name'],
      email: json['email'],
      phone: json['phone'],
      role: json['role'],
      dep_id: json['dep_id'],
      image: _normalizeImagePath(rawImage),
    );
  }
  static String _normalizeImagePath(String raw) {
    if (raw.isEmpty) return raw;

    if (raw.startsWith('http://') || raw.startsWith('https://')) {
      final uri = Uri.tryParse(raw);
      if (uri != null && uri.path.isNotEmpty) {
        return uri.path.startsWith('/') ? uri.path.substring(1) : uri.path;
      }
      return raw;
    }
    return raw.startsWith('storage/') ? raw : 'storage/$raw';
  }
}