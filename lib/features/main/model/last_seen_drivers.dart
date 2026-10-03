import 'package:easy_plus_customer/features/main/model/last_seen.dart';

class LastSeenDrivers {
  bool? status;
  int? code;
  String? message;
  List<LastSeen>? data;

  LastSeenDrivers({
    this.status,
    this.code,
    this.message,
    this.data,
  });

  LastSeenDrivers.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    code = json['code'];
    message = json['message'];

    if (json['data'] != null) {
      data = <LastSeen>[];
      json['data'].forEach((v) {
        data!.add(LastSeen.fromJson(v));
      });
    }
  }
}
