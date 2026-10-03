class LastSeen {
  int? id;
  String? name;
  String? email;
  String? phone;
  String? gender;
  String? lat;
  String? lng;
  String? lastSeenAt;

  LastSeen({
    this.id,
    this.name,
    this.email,
    this.phone,
    this.gender,
    this.lat,
    this.lng,
    this.lastSeenAt,
  });

  LastSeen.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    gender = json['gender'];
    lat = json['lat'];
    lng = json['lng'];
    lastSeenAt = json['last_seen_at'];
  }
}
