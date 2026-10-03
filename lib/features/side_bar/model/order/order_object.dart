import 'package:easy_plus_customer/features/side_bar/model/order/driver.dart';
import 'package:easy_plus_customer/features/side_bar/model/order/offer.dart';

class OrderObject {
  int? id;
  String? startLng;
  String? startLat;
  String? startAddress;
  String? endLng;
  String? endLat;
  String? endAddress;
  String? number;
  String? category;
  String? status;
  String? carType;
  String? pickType;
  String? paymentTypes;
  String? isCash;
  String? navRange;
  String? driverGender;
  String? tourTypeStatus;
  String? tourType;
  String? shoppingTypeId;
  int? shoppingTypeId2;
  String? revisionType;
  String? tourTime;
  String? seatsNumber;
  String? desc;
  String? initialPrice;
  Driver? driver;
  List<Offers>? offers;
  String? review;
  String? duration;
  String? showTime;
  int? categoryId;
  String? daysCount;
  String? startDate;
  String? driverGenderId;
  String? orderType;
  String? reviewer;
  String? shoppingDestination;
  String? reservationType;
  int? revisionTypeId;
  int? orderTypeId;
  int? navRangeId;
  int? tourTypeId;
  int? carTypeId;
  int? mishwarTypeId;
  int? reservationTypeid;

  OrderObject(
      {this.id,
      this.startLng,
      this.startLat,
      this.startAddress,
      this.endLng,
      this.endLat,
      this.endAddress,
      this.number,
      this.category,
      this.status,
      this.carType,
      this.pickType,
      this.paymentTypes,
      this.isCash,
      this.navRange,
      this.driverGender,
      this.tourTypeStatus,
      this.tourType,
      this.shoppingTypeId,
      this.revisionType,
      this.tourTime,
      this.seatsNumber,
      this.desc,
      this.initialPrice,
      this.driver,
      this.offers,
      this.review,
      this.duration,
      this.showTime,
      this.categoryId,
      this.daysCount,
      this.startDate,
      this.driverGenderId,
      this.orderType,
      this.reviewer,
      this.shoppingDestination,
      this.reservationType,
      this.revisionTypeId,
      this.orderTypeId,
      this.navRangeId,
      this.tourTypeId,
      this.carTypeId});

  OrderObject.fromJson(Map<String, dynamic> json) {
    print(json);
    id = json['id'];
    startLng = json['start_lng'];
    startLat = json['start_lat'];
    startAddress = json['start_address'];
    endLng = json['end_lng'];
    endLat = json['end_lat'];
    endAddress = json['end_address'];
    number = json['number'];
    category = json['category'];
    status = json['status'];
    carType = json['car_type'];
    pickType = json['pick_type'];
    paymentTypes = json['payment_types'];
    isCash = json['is_cash'];
    navRange = json['nav_range'];
    driverGender = json['driver_gender'];
    tourTypeStatus = json['tour_type_status'];
    tourType = json['tour_type'];
    shoppingTypeId = json['shopping_type_id'];
    revisionType = json['revision_type'];
    tourTime = json['tour_time'];
    seatsNumber = json['seats_number'];
    desc = json['desc'];
    initialPrice = json['initial_price'];
    duration = json['duration'];
    showTime = json['show_time'].toString();
    daysCount = json['days_count'].toString();
    startDate = json['start_date'].toString();
    driverGenderId = json['driver_gender_id'].toString();
    reservationType = json['reservation_type'].toString();
    orderType = json['order_type'].toString();
    reviewer = json['reviewer'].toString();

    if (json['revision_type_id'] != null) {
      revisionTypeId = int.parse(json['revision_type_id'].toString());
    }
    if (json['order_type_id'] != null) {
      orderTypeId = int.parse(json['order_type_id'].toString());
    }
    if (json['nav_range_id'] != null) {
      navRangeId = int.parse(json['nav_range_id'].toString());
    }
    if (json['tour_type_id'] != null) {
      tourTypeId = int.parse(json['tour_type_id'].toString());
    }
    if (json['car_type_id'] != null) {
      carTypeId = int.parse(json['car_type_id'].toString());
    }
    if (json['mishwar_type_id'] != null) {
      mishwarTypeId = int.parse(json['mishwar_type_id'].toString());
    }
    if (json['reservation_type_id'] != null) {
      reservationTypeid = int.parse(json['reservation_type_id'].toString());
    }
    if (json['shopping_type_id2'] != null) {
      shoppingTypeId2 = int.parse(json['shopping_type_id2'].toString());
    }

    shoppingDestination = json['shopping_destination'].toString();

    categoryId = int.parse(json['category_id'].toString());

    driver = json['driver'] != null ? Driver.fromJson(json['driver']) : null;
    if (json['offers'] != null) {
      offers = <Offers>[];
      json['offers'].forEach((v) {
        offers!.add(Offers.fromJson(v));
      });
    }
    review = json['review'];
  }
}
