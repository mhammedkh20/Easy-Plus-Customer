import 'package:dio/dio.dart';

class User {
  int? id;
  String? name;
  String? birthDate;
  String? idNumber;
  String? image;
  String? phone;
  String? email;
  String? token;
  String? status;
  String? gender;
  String? walletBalance;

  User({
    this.id,
    this.name,
    this.birthDate,
    this.idNumber,
    this.image,
    this.phone,
    this.email,
    this.token,
    this.status,
    this.gender,
    this.walletBalance,
  });

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    birthDate = json['birth_date'];
    idNumber = json['id_number'];
    image = json['image'];
    phone = json['phone'];
    token = json['token'];
    email = json['email'];
    status = json['status'];
    gender = json['gender'];
    walletBalance = json['wallet_balance'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = id;
    data['name'] = name;
    data['birth_date'] = birthDate;
    data['id_number'] = idNumber;
    data['image'] = image;
    data['phone'] = phone;
    data['email'] = email;
    data['token'] = token;
    data['status'] = status;
    data['gender'] = gender;
    data['wallet_balance'] = walletBalance;
    return data;
  }

  Future<Map<String, dynamic>> toJsonUpdateUser() async {
    return {
      'name': name,
      'phone': phone,
      'id_number': idNumber.toString(),
      'gender': gender,
      'birth_date': birthDate,
      if (image != null)
        'image': await MultipartFile.fromFile(
          image!,
          filename: DateTime.now().toString(),
        ),
    };
  }
}
