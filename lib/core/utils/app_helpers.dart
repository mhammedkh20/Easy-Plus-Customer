import 'dart:developer';

import 'package:easy_plus_customer/features/request_services/views/manager/service_cubit/service_cubit.dart';
import 'package:easy_plus_customer/features/side_bar/views/manager/language_cubit/language_cubit.dart';
import 'package:easy_plus_customer/features/side_bar/views/manager/my_request_cubit/my_request_cubit.dart';
import 'package:easy_plus_customer/features/side_bar/views/manager/side_bar_cubit/side_bar_cubit.dart';
import 'package:flutter_clickpay_bridge/PaymentSdkLocale.dart';
import 'package:flutter_clickpay_bridge/flutter_clickpay_bridge.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:custom_refresh_indicator/custom_refresh_indicator.dart';
import 'package:easy_plus_customer/core/storage/pref/shared_pref_controller.dart';
import 'package:easy_plus_customer/core/utils/app_colors.dart';
import 'package:easy_plus_customer/core/widgets/my_text.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_clickpay_bridge/BaseBillingShippingInfo.dart';
import 'package:flutter_clickpay_bridge/IOSThemeConfiguration.dart';
import 'package:flutter_clickpay_bridge/PaymentSdkConfigurationDetails.dart';
import 'package:geocoding/geocoding.dart';

class AppHelpers {
  static void navigationReplacementToPage(BuildContext context, Widget screen) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => screen,
      ),
    );
  }

  static void navigationToPageAndExitAll(BuildContext context, Widget screen) {
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => screen),
        (Route<dynamic> route) => false);
  }

  static void navigationToPageAndExitAllWithoutFirst(BuildContext context) {
    Navigator.popUntil(context, (route) => route.isFirst);
  }

  static Future navigationToPage(BuildContext context, Widget screen) {
    return Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => screen,
      ),
    );
  }

  static showSnackBar(
    BuildContext context, {
    required String message,
    Color? textColor,
    Color? background,
    bool error = false,
  }) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: MyText(
          title: message,
          fontSize: 14,
          color: textColor ?? AppColors.WHITE,
        ),
        behavior: SnackBarBehavior.floating,
        elevation: 0,
        backgroundColor: error
            ? Color.fromARGB(255, 132, 33, 13)
            : Color.fromARGB(255, 16, 98, 16),
      ),
    );
  }

  static Future<String?> selectDate(BuildContext context) async {
    DateTime selectedDate = DateTime.now();
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate) {
      print(selectedDate);
      selectedDate = picked;
      return "${selectedDate.toLocal()}".split(' ')[0];
    }
    return null;
  }

  static Set<Factory<OneSequenceGestureRecognizer>> getGesture() {
    return Set()
      ..add(Factory<PanGestureRecognizer>(() => PanGestureRecognizer()))
      ..add(Factory<ScaleGestureRecognizer>(() => ScaleGestureRecognizer()))
      ..add(Factory<TapGestureRecognizer>(() => TapGestureRecognizer()))
      ..add(Factory<VerticalDragGestureRecognizer>(
          () => VerticalDragGestureRecognizer()))
      ..add(Factory<HorizontalDragGestureRecognizer>(
          () => HorizontalDragGestureRecognizer()));
  }

  static Map<String, String> getHeader(SharedPrefController shared) {
    if (shared.getToken != null) {
      return {
        "Accept": "application/json",
        'Authorization': 'Bearer ${shared.getToken}',
        'lang': shared.getLang
      };
    } else {
      return {"Accept": "application/json", 'lang': shared.getLang};
    }
  }

  static MaterialIndicatorDelegate getIndecatorDelegate() {
    return MaterialIndicatorDelegate(
      builder: (context, controller) {
        return Icon(
          Icons.refresh,
          color: Theme.of(context).colorScheme.primary,
          size: 30,
        );
      },
      scrollableBuilder: (context, child, controller) {
        return Opacity(
          opacity: 1.0 - controller.value.clamp(0.0, 1.0),
          child: child,
        );
      },
    );
  }

  static clickPayment(
    BuildContext context, {
    required double amount,
    double? paymentPrice,
    required bool minus,
    int? offerId,
  }) {
    var billingDetails = BillingDetails(
      "John Smith",
      "email@domain.com",
      "+97311111111",
      "st. 12",
      "eg",
      "dubai",
      "dubai",
      "12345",
    );
    var shippingDetails = ShippingDetails(
      "John Smith",
      "email@domain.com",
      "+97311111111",
      "st. 12",
      "eg",
      "dubai",
      "dubai",
      "12345",
    );

    var configuration = PaymentSdkConfigurationDetails(
      profileId: "42733",
      serverKey: "SJJNLM6NHT-J6GNNRGMJM-2L2NTRMTJN",
      clientKey: "CNKMD2-9BVH6G-TQQRTN-QDRVTD",
      cartId: "cart id",
      cartDescription: "cart desc",
      // merchantName: "merchant name",
      iOSThemeConfigurations: IOSThemeConfigurations(
        logoImage: 'assets/images/app_icon.png',
        secondaryColor: '6DAC40',
        primaryFontColor: '6DAC40',
        secondaryFontColor: '6D6C70',
        strokeColor: '673AB7',
        buttonColor: '6DAC40',
      ),

      screentTitle: AppLocalizations.of(context)!.electronicPayment,
      billingDetails: billingDetails,
      shippingDetails: shippingDetails,
      locale: LanguageCubit.get(context).indexLang == 0
          ? PaymentSdkLocale.AR
          : PaymentSdkLocale
              .EN, //PaymentSdkLocale.AR or PaymentSdkLocale.DEFAULT
      amount: paymentPrice ?? amount,

      currencyCode: "SAR",
      merchantCountryCode: "SA",
    );

    configuration.showBillingInfo = false;
    configuration.showShippingInfo = false;

    FlutterPaymentSdkBridge.startCardPayment(configuration, (event) async {
      log("status : " + event["status"]);
      if (event["status"] == "success") {
        if (minus) {
          // SideBarCubit.get(context)
          //     .addBalance(context, amount: amount * -1, id: offerId);
          await MyRequestCubit.get(context)
              .changeStatusOffer(context, operation: 0, offerId: offerId!);
        } else {
          SideBarCubit.get(context)
              .addBalance(context, amount: amount, id: offerId);
        }
        var transactionDetails = event["data"];
        log(transactionDetails.toString());
      } else if (event["status"] == "error") {
        // Handle error here.
      } else if (event["status"] == "event") {
        // Handle events here.
      }
    });
  }

  static Future<String> getAddress(double latitude, double longitude) async {
    List<Placemark> placemarks =
        await placemarkFromCoordinates(latitude, longitude);
    Placemark place = placemarks[0];
    return '${place.country}, ${place.subAdministrativeArea}, ${place.postalCode}';
  }

  static String getNumberEnglish(String text) {
    return text
        .replaceAll('٠', '0')
        .replaceAll('١', '1')
        .replaceAll('٢', '2')
        .replaceAll('٣', '3')
        .replaceAll('٤', '4')
        .replaceAll('٥', '5')
        .replaceAll('٦', '6')
        .replaceAll('٧', '7')
        .replaceAll('٨', '8')
        .replaceAll('٩', '9');
  }

  static bool isDigit(String s) {
    return int.tryParse(s) != null;
  }

  static String getTextWithoutNum(String text) {
    String result = "";
    int digitCount = 0;

    for (int i = 0; i < text.length; i++) {
      if (isDigit(text[i])) {
        digitCount++;

        if (digitCount <= 3) {
          result += text[i];
        }
      } else {
        digitCount = 0;
        result += text[i];
      }
    }

    if (digitCount > 3) {
      result = result.replaceAll(RegExp(r'[0-9]'), ''); // إزالة جميع الأرقام
    }
    return result;
  }

  static String? getDuration(BuildContext context) {
    String? duration;
    switch (ServiceCubit.get(context).indexReservationPeriod) {
      case 0:
        duration = null;
        break;
      case 1:
        duration = 'hour';
        break;
      case 2:
        duration = 'day';

        break;
    }
    return duration;
  }
}
