class ImageModel {
  int? id;
  String? image;
  bool? isDevice;

  ImageModel({this.id, this.image, this.isDevice});

  ImageModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    image = json['image'];
    isDevice = false;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = id;
    data['image'] = image;
    return data;
  }
}
