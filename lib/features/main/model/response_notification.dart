import 'package:easy_plus_customer/features/main/model/notification_model.dart';

class ResponseNotification {
  bool? status;
  int? code;
  String? message;
  List<NotificationModel>? data;

  ResponseNotification({
    this.status,
    this.code,
    this.message,
    this.data,
  });

  ResponseNotification.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    code = json['code'];
    message = json['message'];
    if (json['data'] != null) {
      data = <NotificationModel>[];
      json['data'].forEach((v) {
        data!.add(NotificationModel.fromJson(v));
      });
    }
  }
}
