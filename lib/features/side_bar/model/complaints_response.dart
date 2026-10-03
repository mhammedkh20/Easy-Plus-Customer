import 'package:easy_plus_customer/features/side_bar/model/complaints.dart';
import 'package:easy_plus_customer/features/side_bar/model/my_orders_response.dart';

class ComplaintsResponse {
  bool? status;
  int? code;
  String? message;
  List<Complaints>? complaints;
  Complaints? object;
  Meta? meta;

  ComplaintsResponse({
    this.status,
    this.code,
    this.message,
  });

  ComplaintsResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    code = json['code'];
    message = json['message'];

    if (json['data'] != null) {
      complaints = <Complaints>[];
      json['data'].forEach((v) {
        complaints!.add(Complaints.fromJson(v));
      });
    }
    meta = json['meta'] != null ? Meta.fromJson(json['meta']) : null;
  }
  ComplaintsResponse.fromJsonSend(Map<String, dynamic> json) {
    status = json['status'];
    code = json['code'];
    message = json['message'];
    object = json['data'] != null ? Complaints.fromJson(json['data']) : null;
  }
}
