import 'package:easy_plus_customer/features/auth/model/user.dart';

class ResponseAuth {
  bool? status;
  int? code;
  bool? unauthorized;

  String? message;
  User? user;

  ResponseAuth({
    this.status,
    this.code,
    this.message,
    this.user,
    this.unauthorized = false,
  });

  ResponseAuth.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    code = json['code'];
    message = json['message'];
    unauthorized = false;

    user = json['user'] != null ? User.fromJson(json['user']) : null;
  }

  ResponseAuth.fromJsonData(Map<String, dynamic> json) {
    status = json['status'];
    code = json['code'];
    unauthorized = false;
    message = json['message'];
    user = json['data'] != null ? User.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['status'] = status;
    data['code'] = code;
    data['message'] = message;
    if (user != null) {
      data['user'] = user!.toJson();
    }
    return data;
  }
}
