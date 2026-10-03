class ResponsePlaceDetails {
  Result? result;
  String? status;
  String? message;

  ResponsePlaceDetails({this.result, this.status});

  ResponsePlaceDetails.fromJson(Map<String, dynamic> json) {
    result =
        json['result'] != null ? new Result.fromJson(json['result']) : null;
    status = json['status'];
  }
}

class Result {
  String? formattedAddress;
  Geometry? geometry;
  String? icon;
  String? name;
  String? placeId;
  List<String>? types;
  String? url;
  int? utcOffset;

  Result(
      {this.formattedAddress,
      this.geometry,
      this.icon,
      this.name,
      this.placeId,
      this.types,
      this.url,
      this.utcOffset});

  Result.fromJson(Map<String, dynamic> json) {
    formattedAddress = json['formatted_address'];
    geometry = json['geometry'] != null
        ? new Geometry.fromJson(json['geometry'])
        : null;
    icon = json['icon'];
    name = json['name'];
    placeId = json['place_id'];
    types = json['types'].cast<String>();
    url = json['url'];
    utcOffset = json['utc_offset'];
  }
}

class Geometry {
  LocationModel? location;
  Viewport? viewport;

  Geometry({this.location, this.viewport});

  Geometry.fromJson(Map<String, dynamic> json) {
    location = json['location'] != null
        ? LocationModel.fromJson(json['location'])
        : null;
    viewport =
        json['viewport'] != null ? Viewport.fromJson(json['viewport']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.location != null) {
      data['location'] = this.location!.toJson();
    }
    if (this.viewport != null) {
      data['viewport'] = this.viewport!.toJson();
    }
    return data;
  }
}

class LocationModel {
  double? lat;
  double? lng;

  LocationModel({this.lat, this.lng});

  LocationModel.fromJson(Map<String, dynamic> json) {
    lat = json['lat'];
    lng = json['lng'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['lat'] = this.lat;
    data['lng'] = this.lng;
    return data;
  }
}

class Viewport {
  LocationModel? northeast;
  LocationModel? southwest;

  Viewport({this.northeast, this.southwest});

  Viewport.fromJson(Map<String, dynamic> json) {
    northeast = json['northeast'] != null
        ? new LocationModel.fromJson(json['northeast'])
        : null;
    southwest = json['southwest'] != null
        ? new LocationModel.fromJson(json['southwest'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.northeast != null) {
      data['northeast'] = this.northeast!.toJson();
    }
    if (this.southwest != null) {
      data['southwest'] = this.southwest!.toJson();
    }
    return data;
  }
}

class Northeast {
  double? lat;
  double? lng;

  Northeast({this.lat, this.lng});

  Northeast.fromJson(Map<String, dynamic> json) {
    lat = json['lat'];
    lng = json['lng'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['lat'] = this.lat;
    data['lng'] = this.lng;
    return data;
  }
}
