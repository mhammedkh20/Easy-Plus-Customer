class ResponseAppConfig {
  App? app;
  bool? status;
  String? message;
  List<Categories>? categories;
  List<CustomClass>? ordersTypes;
  List<CustomClass>? revisionTypes;
  List<CustomClass>? shoppingTypes;
  List<CustomClass>? paymentTypes;
  List<CustomClass>? navRangeTypes;
  List<CustomClass>? carTypes;
  List<CustomClass>? tourTypes;
  List<CustomClass>? mishwarTypes;
  List<CustomClass>? banks;

  ResponseAppConfig({
    this.app,
    this.categories,
    this.ordersTypes,
    this.revisionTypes,
    this.shoppingTypes,
    this.paymentTypes,
    this.navRangeTypes,
    this.carTypes,
    this.tourTypes,
    this.mishwarTypes,
    this.banks,
    this.status,
    this.message,
  });

  ResponseAppConfig.fromJson(Map<String, dynamic> json) {
    app = json['app'] != null ? App.fromJson(json['app']) : null;

    print('json[categories] ${json['categories']}');
    if (json['categories'] != null) {
      categories = <Categories>[];
      json['categories'].forEach((v) {
        categories!.add(Categories.fromJson(v));
      });
    }
    if (json['orders_types'] != null) {
      ordersTypes = <CustomClass>[];
      json['orders_types'].forEach((v) {
        ordersTypes!.add(CustomClass.fromJson(v));
      });
    }

    if (json['revision_types'] != null) {
      revisionTypes = <CustomClass>[];
      json['revision_types'].forEach((v) {
        revisionTypes!.add(CustomClass.fromJson(v));
      });
    }
    if (json['shopping_types'] != null) {
      shoppingTypes = <CustomClass>[];
      json['shopping_types'].forEach((v) {
        shoppingTypes!.add(CustomClass.fromJson(v));
      });
    }
    if (json['payment_types'] != null) {
      paymentTypes = <CustomClass>[];
      json['payment_types'].forEach((v) {
        paymentTypes!.add(CustomClass.fromJson(v));
      });
    }
    if (json['nav_range_types'] != null) {
      navRangeTypes = <CustomClass>[];
      json['nav_range_types'].forEach((v) {
        navRangeTypes!.add(CustomClass.fromJson(v));
      });
    }
    if (json['car_types'] != null) {
      carTypes = <CustomClass>[];
      json['car_types'].forEach((v) {
        carTypes!.add(CustomClass.fromJson(v));
      });
    }
    if (json['tour_types'] != null) {
      tourTypes = <CustomClass>[];
      json['tour_types'].forEach((v) {
        tourTypes!.add(CustomClass.fromJson(v));
      });
    }
    if (json['mishwar_types'] != null) {
      mishwarTypes = <CustomClass>[];
      json['mishwar_types'].forEach((v) {
        mishwarTypes!.add(CustomClass.fromJson(v));
      });
    }
    if (json['banks'] != null) {
      banks = <CustomClass>[];
      json['banks'].forEach((v) {
        banks!.add(CustomClass.fromJson(v));
      });
    }
  }
}

class App {
  String? title;
  String? subTitle;
  String? logo;
  String? splash;
  String? orderDuration;
  // String? cancelOrderTax;
  String? maxAddBalance;
  String? minAddBalance;
  String? paymentGatewayCommission;

  String? androidVersionCode;
  String? iosVersionCode;
  bool? isUploadAppAndroid;
  bool? isUploadAppIos;

  App({
    this.title,
    this.subTitle,
    this.logo,
    this.splash,
    this.orderDuration,
    // this.cancelOrderTax,
    this.maxAddBalance,
    this.minAddBalance,
    this.paymentGatewayCommission,
  });

  App.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    subTitle = json['sub_title'];
    logo = json['logo'];
    splash = json['user_splash'];
    orderDuration = json['order_duration'];
    // cancelOrderTax = json['cancel_order_tax'];
    maxAddBalance = json['max_withdrawal'];
    minAddBalance = json['min_withdrawal'];
    paymentGatewayCommission = json['payment_gateway_commission'];
    androidVersionCode = json['android_version_code'];
    iosVersionCode = json['ios_version_code'];

    isUploadAppAndroid = json['is_upload_app_android'];
    isUploadAppIos = json['is_upload_app_ios'];
  }
}

class Categories {
  int? id;
  String? name;
  String? icon;
  bool? status;
  String? cancellationDriver;
  String? cancellationUser;
  Categories.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    icon = json['icon'];
    status = json['status'] ?? true;
    cancellationDriver = json['cancellation_driver'];
    cancellationUser = json['cancellation_user'];
  }
}

class CustomClass {
  int? id;
  String? name;
  String? title;
  String? driverGender;
  String? iban;
  String? navRangeId;
  String? navRange;
  String? accountNumber;
  String? type;
  int? reservationTypeId;
  List<CustomClass>? navRanges;
  List<CustomClass>? driverGender2;

  List<CustomClass>? reservationTypes;

  CustomClass.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    iban = json['iban'];
    navRangeId = json['nav_range_id'];
    type = json['type'];
    title = json['title'];
    driverGender = json['driver_gender'];
    accountNumber = json['account_number'];
    reservationTypeId = json['reservation_type_id'];
    navRange = json['nav_range'];
    if (json['nav_ranges'] != null) {
      navRanges = <CustomClass>[];
      json['nav_ranges'].forEach((v) {
        navRanges!.add(CustomClass.fromJson(v));
      });
    }

    if (json['driverGender'] != null) {
      driverGender2 = <CustomClass>[];
      json['driverGender'].forEach((v) {
        driverGender2!.add(CustomClass.fromJson(v));
      });
    }

    if (json['reservation_types'] != null) {
      reservationTypes = <CustomClass>[];
      json['reservation_types'].forEach((v) {
        reservationTypes!.add(CustomClass.fromJson(v));
      });
    }
  }
}
