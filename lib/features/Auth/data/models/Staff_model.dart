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
      // هون التغيير الأساسي: نخزن مسار نسبي فقط (بدون IP)
      image: _normalizeImagePath(rawImage),
    );
  }

  /// يرجع مسار نسبي دايماً، بغض النظر شو شكل القيمة الجاية:
  /// - لو الباك اند رجع مسار خام زي "staff_images/xxx.jpg"           -> يرجعه متل ما هو (مع تأكد إنه يبدأ بـ storage/)
  /// - لو الباك اند رجع رابط كامل زي "http://1.2.3.4:8000/storage/x" -> يقص منه IP والبروتوكول ويخلي بس المسار
  /// - لو فيه بيانات قديمة متخزنة (من قبل هالتعديل) فيها IP قديم ميت -> نفس المعالجة، ما بتنكسر
  static String _normalizeImagePath(String raw) {
    if (raw.isEmpty) return raw;

    if (raw.startsWith('http://') || raw.startsWith('https://')) {
      final uri = Uri.tryParse(raw);
      if (uri != null && uri.path.isNotEmpty) {
        // uri.path بيكون مثلاً "/storage/staff_images/xxx.jpg"
        return uri.path.startsWith('/') ? uri.path.substring(1) : uri.path;
      }
      return raw; // احتياط لو فشل الـ parsing لأي سبب
    }

    // مسار خام بدون بروتوكول أصلاً
    return raw.startsWith('storage/') ? raw : 'storage/$raw';
  }
}