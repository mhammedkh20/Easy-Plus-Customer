class CategoryModel {
  int? id;
  String? name;
  String? icon;
  bool? status;

  CategoryModel({
    this.id,
    this.name,
    this.icon,
    this.status,
  });

  CategoryModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    icon = json['icon'];
    status = json['status'] ?? true;
  }
}
