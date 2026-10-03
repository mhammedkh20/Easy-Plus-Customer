import 'package:easy_plus_customer/features/side_bar/model/order/image_model.dart';

class Driver {
  int? id;
  String? name;
  String? image;
  num? rate;
  String? gender;
  String? carModel;
  String? carColor;
  String? carMake;
  String? plateNumber;
  String? carYear;
  List<ImageModel>? carImages;

  Driver(
      {this.id,
      this.name,
      this.image,
      this.rate,
      this.gender,
      this.carModel,
      this.carColor,
      this.carMake,
      this.plateNumber,
      this.carYear,
      this.carImages});

  Driver.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    image = json['image'];
    rate = json['rate'];
    gender = json['gender'];
    carModel = json['car_model'];
    carColor = json['car_color'];
    carMake = json['car_make'];
    plateNumber = json['plate_number'];
    carYear = json['car_year'];
    if (json['car_images'] != null) {
      carImages = <ImageModel>[];
      json['car_images'].forEach((v) {
        carImages!.add(ImageModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = id;
    data['name'] = name;
    data['image'] = image;
    data['rate'] = rate;
    data['gender'] = gender;
    data['car_model'] = carModel;
    data['car_color'] = carColor;
    data['car_make'] = carMake;
    data['plate_number'] = plateNumber;
    data['car_year'] = carYear;
    if (carImages != null) {
      data['car_images'] = carImages!.map((v) => v).toList();
    }
    return data;
  }
}
