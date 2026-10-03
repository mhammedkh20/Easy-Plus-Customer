class OrderModel {
  int? categoryId;
  double? startLng;
  double? startLat;
  double? endLng;
  double? endLat;
  int? orderTypeId;
  num? initilPrice;
  int? revisionTypeId;
  int? navRangeId;
  int? shoppingTypeId;
  String? driverGender;
  int? pickType;
  int? seatsNumber;
  int? carTypeId;
  int? mishwarTypeId;
  int? tourTypeId;
  String? tourType;
  String? desc;
  String? startAddress;
  String? endAddress;
  int? tourTime;
  String? duration;
  DateTime? startDate;
  int? revisionType;
  int? reservationTypeId;
  String? daysCount;
  int? driverGenderId;
  String? reviewer;
  String? shoppingDestination;

  OrderModel({
    this.carTypeId,
    this.categoryId,
    this.desc,
    this.driverGender,
    this.endLat,
    this.endLng,
    this.initilPrice,
    this.mishwarTypeId,
    this.navRangeId,
    this.orderTypeId,
    this.pickType,
    this.revisionTypeId,
    this.seatsNumber,
    this.shoppingTypeId,
    this.startLat,
    this.startLng,
    this.tourType,
    this.tourTypeId,
    this.startAddress,
    this.endAddress,
    this.tourTime,
    this.duration,
    this.startDate,
    this.revisionType,
    this.reservationTypeId,
    this.daysCount,
    this.driverGenderId,
    this.reviewer,
    this.shoppingDestination,
  });

  Map<String, dynamic> toJsonRevision() {
    final Map<String, dynamic> data = {};
    data['category_id'] = categoryId.toString();
    data['start_lng'] = startLng.toString();
    data['start_lat'] = startLat.toString();
    data['revision_type_id'] = revisionTypeId.toString();
    data['desc'] = desc;
    data['initil_price'] = initilPrice.toString();
    data['start_address'] = startAddress.toString();
    data['days_count'] = daysCount.toString();
    data['start_date'] = startDate.toString();
    data['driver_gender_id'] = driverGenderId.toString();
    data['reviewer'] = reviewer.toString();

    return data;
  }

  Map<String, dynamic> toJsonShopper() {
    final Map<String, dynamic> data = {};
    data['category_id'] = categoryId.toString();
    data['start_lng'] = startLng.toString();
    data['start_lat'] = startLat.toString();
    data['end_lat'] = endLat.toString();
    data['end_lng'] = endLng.toString();
    data['shopping_type_id'] = shoppingTypeId.toString();
    data['desc'] = desc;
    data['initil_price'] = initilPrice.toString();
    data['start_address'] = startAddress.toString();
    data['end_address'] = endAddress.toString();
    data['shopping_destination'] = shoppingDestination.toString();
    data['days_count'] = daysCount.toString();
    data['start_date'] = startDate.toString();
    data['driver_gender_id'] = driverGenderId.toString();

    return data;
  }

  Map<String, dynamic> toJsonTour() {
    final Map<String, dynamic> data = {};
    data['category_id'] = categoryId.toString();
    data['start_lng'] = startLng.toString();
    data['start_lat'] = startLat.toString();
    data['tour_type_id'] = tourTypeId.toString();
    data['tour_type'] = tourType.toString();
    data['desc'] = desc ?? '';
    data['initil_price'] = initilPrice.toString();
    data['start_address'] = startAddress.toString();
    data['tour_time'] = tourTime.toString();
    data['start_date'] = startDate.toString();
    data['driver_gender_id'] = driverGenderId.toString();
    if (duration != null) data['duration'] = duration.toString();

    return data;
  }

  Map<String, dynamic> toJsonDelivry() {
    final Map<String, dynamic> data = {};
    data['category_id'] = categoryId.toString();
    data['start_lng'] = startLng.toString();
    data['start_lat'] = startLat.toString();
    data['end_lat'] = endLat.toString();
    data['end_lng'] = endLng.toString();
    data['order_type_id'] = orderTypeId.toString();
    data['nav_range_id'] = navRangeId.toString();
    data['desc'] = desc;
    data['initil_price'] = initilPrice.toString();
    data['start_address'] = startAddress.toString();
    data['end_address'] = endAddress.toString();
    data['driver_gender_id'] = driverGenderId.toString();
    data['days_count'] = daysCount.toString();
    data['duration'] = duration.toString();
    data['start_date'] = startDate.toString();

    return data;
  }

  Map<String, dynamic> toJsonMashwar() {
    final Map<String, dynamic> data = {};
    data['category_id'] = categoryId.toString();
    data['start_lng'] = startLng.toString();
    data['start_lat'] = startLat.toString();
    data['end_lat'] = endLat.toString();
    data['end_lng'] = endLng.toString();
    data['nav_range_id'] = navRangeId.toString();
    data['driver_gender'] = driverGender.toString();
    data['pick_type'] = pickType.toString();
    data['seats_number'] = seatsNumber.toString();
    data['car_type_id'] = carTypeId.toString();
    data['mishwar_type_id'] = mishwarTypeId.toString();
    data['desc'] = desc;
    data['initil_price'] = initilPrice.toString();
    data['start_address'] = startAddress.toString();
    data['end_address'] = endAddress.toString();
    data['start_date'] = startDate.toString();
    data['reservation_type_id'] = reservationTypeId.toString();

    if (duration != null) data['duration'] = duration.toString();
    return data;
  }
}
