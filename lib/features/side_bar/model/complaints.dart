class Complaints {
  int? id;
  String? orderNum;
  String? desc;
  String? status;

  Complaints({this.id, this.orderNum, this.desc, this.status});

  Complaints.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    orderNum = json['order_num'];
    desc = json['desc'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = id;
    data['order_num'] = orderNum;
    data['desc'] = desc;
    data['status'] = status;
    return data;
  }
}
