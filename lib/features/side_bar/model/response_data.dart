class ResponseData {
  bool? status;
  int? code;
  String? message;

  ResponseData({this.status, this.code, this.message});

  ResponseData.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    code = json['code'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = status;
    data['code'] = code;
    data['message'] = message;
    return data;
  }
}
