class ResponseLoginMethod {
  bool? status;
  int? code;
  String? message;
  List<LoginMethod>? data;

  ResponseLoginMethod({this.status, this.code, this.message, this.data});

  ResponseLoginMethod.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    code = json['code'];
    message = json['message'];
    if (json['data'] != null) {
      data = <LoginMethod>[];
      json['data'].forEach((v) {
        if (v['type'] == 'user' && v['status']) {
          data!.insert(0, LoginMethod.fromJson(v));
        }
      });
    }
  }
}

class LoginMethod {
  int? id;
  String? name;
  String? type;
  bool? status;
  String? icon;

  LoginMethod({this.id, this.name, this.type, this.status, this.icon});

  LoginMethod.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    type = json['type'];
    status = json['status'] ?? true;
    icon = json['icon'];
  }
}
