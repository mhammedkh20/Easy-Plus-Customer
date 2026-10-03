import 'package:easy_plus_customer/features/main/model/response_app_config.dart';

class MyOrdersResponse {
  bool? status;
  int? code;
  String? message;
  List<Data>? data;
  Meta? meta;

  MyOrdersResponse({
    this.status,
    this.code,
    this.message,
    this.data,
    this.meta,
  });

  MyOrdersResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    code = json['code'];
    message = json['message'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(Data.fromJson(v));
      });
    }
    meta = json['meta'] != null ? Meta.fromJson(json['meta']) : null;
  }
}

class Data {
  int? id;
  String? number;
  int? offersCount;
  String? status;
  Categories? category;
  String? createdAt;

  Data(
      {this.id,
      this.number,
      this.offersCount,
      this.status,
      this.category,
      this.createdAt});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    number = json['number'];
    status = json['status'];
    offersCount = json['offers_count'];

    category =
        json['category'] != null ? Categories.fromJson(json['category']) : null;
    createdAt = json['created_at'];
  }
}

class Meta {
  int? currentPage;
  int? from;
  int? lastPage;
  String? path;
  int? perPage;
  int? to;
  int? total;

  Meta(
      {this.currentPage,
      this.from,
      this.lastPage,
      this.path,
      this.perPage,
      this.to,
      this.total});

  Meta.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    from = json['from'];
    lastPage = json['last_page'];
    path = json['path'];
    perPage = json['per_page'];
    to = json['to'];
    total = json['total'];
  }
}
