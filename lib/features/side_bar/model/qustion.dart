class Qustion {
  int? id;
  String? name;
  String? desc;

  Qustion({this.id, this.name, this.desc});

  Qustion.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['title'];
    desc = json['desc'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = id;
    data['title'] = name;
    data['desc'] = desc;
    return data;
  }
}
