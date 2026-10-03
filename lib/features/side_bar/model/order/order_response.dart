import 'package:easy_plus_customer/features/side_bar/model/order/order_object.dart';

class OrderResponse {
  bool? status;
  int? code;
  String? message;
  OrderObject? data;

  OrderResponse({this.status, this.code, this.message, this.data});

  OrderResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    code = json['code'];
    message = json['message'];
    data = json['data'] != null ? OrderObject.fromJson(json['data']) : null;
  }
}
