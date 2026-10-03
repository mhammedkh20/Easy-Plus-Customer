class GeneralResponse {
  bool? status;
  int? code;
  String? message;

  GeneralResponse({this.status, this.code, this.message});

  GeneralResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    code = json['code'];
    message = json['message'];
  }
}
