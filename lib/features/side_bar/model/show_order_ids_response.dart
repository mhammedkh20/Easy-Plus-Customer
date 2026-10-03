class ShowOrderIdsResponse {
  bool? status;
  int? code;
  String? message;
  List<int>? data;

  ShowOrderIdsResponse({this.status, this.code, this.message, this.data});

  ShowOrderIdsResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    code = json['code'];
    message = json['message'];
    data = json['data'].cast<int>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['status'] = status;
    data['code'] = code;
    data['message'] = message;
    data['data'] = this.data;
    return data;
  }
}
