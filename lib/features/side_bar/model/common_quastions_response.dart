import 'package:easy_plus_customer/features/side_bar/model/my_orders_response.dart';
import 'package:easy_plus_customer/features/side_bar/model/qustion.dart';

class CommonQuastionsResponse {
  bool? status;
  int? code;
  String? message;
  List<Qustion>? data;
  Meta? meta;

  CommonQuastionsResponse({
    this.status,
    this.code,
    this.message,
    this.data,
    this.meta,
  });

  CommonQuastionsResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    code = json['code'];
    message = json['message'];
    if (json['data'] != null) {
      data = <Qustion>[];
      json['data'].forEach((v) {
        data!.add(Qustion.fromJson(v));
      });
    }
    meta = json['meta'] != null ? new Meta.fromJson(json['meta']) : null;
  }
}
