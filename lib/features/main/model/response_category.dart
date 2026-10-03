import 'package:easy_plus_customer/features/main/model/category_model.dart';

class ResponseCategory {
  bool? status;
  int? code;
  String? message;
  List<CategoryModel>? data;
  List<String>? slider;

  ResponseCategory({
    this.status,
    this.code,
    this.message,
    this.data,
    this.slider,
  });

  ResponseCategory.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    code = json['code'];
    message = json['message'];
    if (json['data'] != null) {
      data = <CategoryModel>[];
      json['data'].forEach((v) {
        data!.add(CategoryModel.fromJson(v));
      });
    }
  }

  ResponseCategory.fromJsonSliders(Map<String, dynamic> json) {
    status = json['status'];
    code = json['code'];
    message = json['message'];
    if (json['data'] != null) {
      slider = [];
      json['data'].forEach((v) {
        slider!.add(v['image']);
      });
    }
  }
}
