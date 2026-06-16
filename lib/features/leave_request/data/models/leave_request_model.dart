import 'package:hotel_app/features/leave_request/domain/entities/leave_request.dart';

class LeaveRequestModel{
  final int staff_id;
  final DateTime start_date;
  final DateTime end_date;
  final String reason;
  final String type;
  final String status;
  final int leave_id;

  LeaveRequestModel({required this.staff_id,
    required this.start_date,required this.end_date,required this.reason,required this.type,
  required this.status,required this.leave_id});
  factory LeaveRequestModel.fromjson(Map<String,dynamic>json){
    final data = json['data'];

  return  LeaveRequestModel(
    staff_id: data['staff_id'],
      start_date: data['start_date'],
      end_date: data['end_date'],
      reason: data['reason'],
      type: data['type'],
      status: data['status'],
      leave_id: data['leave_id']);
  }
  LeaveRequest toEtity(){
 return LeaveRequest(
     staff_id: staff_id,
     start_date: start_date,
     end_date: end_date,
     reason: reason,
     type: type,
     status: status);
}
}