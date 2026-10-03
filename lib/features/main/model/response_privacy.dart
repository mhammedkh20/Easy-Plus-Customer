class ResponsePrivacy {
  bool? status;
  int? code;
  String? message;
  String? data;

  ResponsePrivacy({this.status, this.code, this.message, this.data});

  ResponsePrivacy.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    code = json['code'];
    message = json['message'];
    data = json['data'];
  }
}
