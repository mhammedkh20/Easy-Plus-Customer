class ResponsePredictions {
  List<Predictions>? predictions;
  String? status;
  String? message;

  ResponsePredictions({this.predictions, this.status});

  ResponsePredictions.fromJson(Map<String, dynamic> json) {
    if (json['predictions'] != null) {
      predictions = <Predictions>[];
      json['predictions'].forEach((v) {
        predictions!.add(new Predictions.fromJson(v));
      });
    }
    status = json['status'];
  }
}

class Predictions {
  String? description;
  String? placeId;
  String? reference;
  List<Terms>? terms;
  List<String>? types;

  Predictions(
      {this.description, this.placeId, this.reference, this.terms, this.types});

  Predictions.fromJson(Map<String, dynamic> json) {
    description = json['description'];

    placeId = json['place_id'];
    reference = json['reference'];

    if (json['terms'] != null) {
      terms = <Terms>[];
      json['terms'].forEach((v) {
        terms!.add(Terms.fromJson(v));
      });
    }
    types = json['types'].cast<String>();
  }
}

class Terms {
  int? offset;
  String? value;

  Terms({this.offset, this.value});

  Terms.fromJson(Map<String, dynamic> json) {
    offset = json['offset'];
    value = json['value'];
  }
}
