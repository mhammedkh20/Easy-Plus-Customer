import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:easy_plus_customer/core/network/api/settings_api.dart';
import 'package:easy_plus_customer/core/storage/pref/shared_pref_controller.dart';
import 'package:easy_plus_customer/core/utils/app_helpers.dart';
import 'package:easy_plus_customer/features/main/model/response_notification.dart';
import 'package:easy_plus_customer/features/main/model/response_privacy.dart';
import 'package:easy_plus_customer/features/request_services/model/general_response.dart';
import 'package:easy_plus_customer/features/side_bar/model/common_quastions_response.dart';
import 'package:easy_plus_customer/features/side_bar/model/complaints_response.dart';
import 'package:easy_plus_customer/features/side_bar/model/my_orders_response.dart';
import 'package:easy_plus_customer/features/side_bar/model/order/order_response.dart';
import 'package:easy_plus_customer/features/side_bar/model/response_data.dart';
import 'package:easy_plus_customer/features/side_bar/model/show_order_ids_response.dart';
import 'package:easy_plus_customer/features/side_bar/model/wallet/wallet_response.dart';
import 'package:http/http.dart' as http;

class ApiSideBar {
  final SharedPrefController _shared = SharedPrefController();
  //! contact us
  Future<ResponseData?> contactUs({
    required String title,
    required String message,
  }) async {
    ResponseData? responseData;
    try {
      final response;

      response = await http.post(
        Uri.parse(SittingsApi.CONTACT_US),
        headers: AppHelpers.getHeader(_shared),
        body: {"title": title, "message": message},
      );

      if (response.statusCode == 200) {
        responseData = ResponseData.fromJson(jsonDecode(response.body));
        responseData.status = true;
      } else if (response.statusCode >= 400) {
        responseData = ResponseData();
        responseData.message = jsonDecode(response.body)['message'];
        responseData.status = false;
      }
    } catch (ex) {
      responseData = ResponseData();
      responseData.message = ex.toString();
      responseData.status = false;
    }

    return responseData;
  }

  //! report missing
  Future<ResponseData?> reportMissing({
    required String phone,
    required String message,
    required String missingTime,
    required String orderId,
    List<String>? items,
  }) async {
    ResponseData? responseData;
    try {
      FormData formData = FormData.fromMap(
        {
          "phone": phone,
          "message": message,
          "missing_time": missingTime,
          "order_id": orderId,
        },
      );

      if (items != null) {
        for (int i = 0; i < items.length; i++) {
          formData.files.add(MapEntry(
            'images[$i]',
            await MultipartFile.fromFile(items[i]),
          ));
        }
      }

      final response = await Dio().post(
        SittingsApi.REPORT_MISSING,
        data: formData,
        options: Options(
          headers: AppHelpers.getHeader(_shared),
          followRedirects: false,
          validateStatus: (int? status) {
            return status! < 500;
          },
        ),
      );

      if (response.statusCode == 200) {
        responseData = ResponseData.fromJson(response.data);
        responseData.status = true;
      } else if (response.statusCode! >= 400) {
        responseData = ResponseData();
        responseData.message = response.data['message'];
        responseData.status = false;
      }
    } catch (ex) {
      responseData = ResponseData();
      responseData.message = ex.toString();
      responseData.status = false;
    }

    return responseData;
  }

  // ! My Order
  Future<MyOrdersResponse?> getMyOrder({
    required String statusOrder,
    required int page,
  }) async {
    MyOrdersResponse? responseOrder;
    try {
      final response;
      response = await http.get(
        Uri.parse(
          SittingsApi.GET_MY_ORDERS + statusOrder + "&page=" + page.toString(),
        ),
        headers: AppHelpers.getHeader(_shared),
      );

      if (response.statusCode == 200) {
        responseOrder = MyOrdersResponse.fromJson(jsonDecode(response.body));
        responseOrder.status = true;
      } else if (response.statusCode >= 400) {
        responseOrder = MyOrdersResponse();
        responseOrder.message = jsonDecode(response.body)['message'];
        responseOrder.status = false;
      }
    } catch (ex) {
      responseOrder = MyOrdersResponse();
      responseOrder.message = ex.toString();
      responseOrder.status = false;
    }

    return responseOrder;
  }

  // ! Get Transaction
  Future<WalletResponse?> getTransaction() async {
    WalletResponse? responseWallet;
    try {
      final response;
      response = await http.get(
        Uri.parse(SittingsApi.GET_WALLET),
        headers: AppHelpers.getHeader(_shared),
      );

      if (response.statusCode == 200) {
        responseWallet = WalletResponse.fromJson(jsonDecode(response.body));
        responseWallet.status = true;
      } else if (response.statusCode >= 400) {
        responseWallet = WalletResponse();
        responseWallet.message = jsonDecode(response.body)['message'];
        responseWallet.status = false;
      }
    } catch (ex) {
      responseWallet = WalletResponse();
      responseWallet.message = ex.toString();
      responseWallet.status = false;
    }

    return responseWallet;
  }

  // ! Get Complaints
  Future<ComplaintsResponse?> getComplaints({required int page}) async {
    ComplaintsResponse? responseComplaint;
    try {
      final response;
      response = await http.get(
        Uri.parse("${SittingsApi.COMPLAINTS}?page=$page"),
        headers: AppHelpers.getHeader(_shared),
      );

      if (response.statusCode == 200) {
        responseComplaint =
            ComplaintsResponse.fromJson(jsonDecode(response.body));
        responseComplaint.status = true;
      } else if (response.statusCode >= 400) {
        responseComplaint = ComplaintsResponse();
        responseComplaint.message = jsonDecode(response.body)['message'];
        responseComplaint.status = false;
      }
    } catch (ex) {
      responseComplaint = ComplaintsResponse();
      responseComplaint.message = ex.toString();
      responseComplaint.status = false;
    }

    return responseComplaint;
  }

  Future<ComplaintsResponse?> postComplaints(
    String orderId,
    String desc,
  ) async {
    ComplaintsResponse? responseComplaint;
    try {
      final response;
      response = await http.post(Uri.parse(SittingsApi.COMPLAINTS),
          headers: AppHelpers.getHeader(_shared),
          body: {
            'order_id': orderId,
            'desc': desc,
          });

      if (response.statusCode == 200) {
        responseComplaint =
            ComplaintsResponse.fromJsonSend(jsonDecode(response.body));
        responseComplaint.status = true;
      } else if (response.statusCode >= 400) {
        responseComplaint = ComplaintsResponse();
        responseComplaint.message = jsonDecode(response.body)['message'];
        responseComplaint.status = false;
      }
    } catch (ex) {
      responseComplaint = ComplaintsResponse();
      responseComplaint.message = ex.toString();
      responseComplaint.status = false;
    }

    return responseComplaint;
  }

  // ! Order and Offer
  Future<OrderResponse?> getDataOrder(
    String orderId,
  ) async {
    OrderResponse? responseDetailsOrder;
    try {
      final response;
      response = await http.get(
        Uri.parse(SittingsApi.GET_DETAILS_ORDER + orderId),
        headers: AppHelpers.getHeader(_shared),
      );
      log(SittingsApi.GET_DETAILS_ORDER + orderId);
      if (response.statusCode == 200) {
        responseDetailsOrder =
            OrderResponse.fromJson(jsonDecode(response.body));
        responseDetailsOrder.status = true;
      } else if (response.statusCode >= 400) {
        responseDetailsOrder = OrderResponse();
        responseDetailsOrder.message = jsonDecode(response.body)['message'];
        responseDetailsOrder.status = false;
      }
    } catch (ex) {
      responseDetailsOrder = OrderResponse();
      responseDetailsOrder.message = ex.toString();
      responseDetailsOrder.status = false;
    }

    return responseDetailsOrder;
  }

  Future<OrderResponse?> refuseOffer(String offerId) async {
    OrderResponse? responseStatusOffer;
    try {
      final response;
      response = await http.get(
        Uri.parse(SittingsApi.REFUSE_OFFER + offerId),
        headers: AppHelpers.getHeader(_shared),
      );

      if (response.statusCode == 200) {
        responseStatusOffer = OrderResponse.fromJson(jsonDecode(response.body));
        responseStatusOffer.status = true;
      } else if (response.statusCode >= 400) {
        responseStatusOffer = OrderResponse();
        responseStatusOffer.message = jsonDecode(response.body)['message'];
        responseStatusOffer.status = false;
      }
    } catch (ex) {
      responseStatusOffer = OrderResponse();
      responseStatusOffer.message = ex.toString();
      responseStatusOffer.status = false;
    }

    return responseStatusOffer;
  }

  Future<OrderResponse?> cancelOrder(String orderId) async {
    OrderResponse? responseStatusOffer;
    try {
      final response = await http.get(
        Uri.parse(SittingsApi.CANCEL_ORDER + orderId),
        headers: AppHelpers.getHeader(_shared),
      );

      if (response.statusCode == 200) {
        responseStatusOffer = OrderResponse.fromJson(jsonDecode(response.body));
        responseStatusOffer.status = true;
      } else if (response.statusCode >= 400) {
        responseStatusOffer = OrderResponse();
        responseStatusOffer.message = jsonDecode(response.body)['message'];
        responseStatusOffer.status = false;
      }
    } catch (ex) {
      responseStatusOffer = OrderResponse();
      responseStatusOffer.message = ex.toString();
      responseStatusOffer.status = false;
    }

    return responseStatusOffer;
  }

  Future<OrderResponse?> acceptOffer(String offerId) async {
    OrderResponse? responseStatusOffer;
    try {
      final response;
      response = await http.get(
        Uri.parse(SittingsApi.ACCEPT_OFFER + offerId),
        headers: AppHelpers.getHeader(_shared),
      );

      if (response.statusCode == 200) {
        responseStatusOffer = OrderResponse.fromJson(jsonDecode(response.body));
        responseStatusOffer.status = true;
      } else if (response.statusCode >= 400) {
        responseStatusOffer = OrderResponse();
        responseStatusOffer.message = jsonDecode(response.body)['message'];
        responseStatusOffer.status = false;
      }
    } catch (ex) {
      responseStatusOffer = OrderResponse();
      responseStatusOffer.message = ex.toString();
      responseStatusOffer.status = false;
    }

    return responseStatusOffer;
  }

  Future<OrderResponse?> finishTheOrder(
      String orderId, String isArrived) async {
    OrderResponse? responseStatusOrder;
    try {
      final response;
      response = await http.post(
        Uri.parse(SittingsApi.FINISH_ORDER),
        headers: AppHelpers.getHeader(_shared),
        body: {
          "order_id": orderId,
          "is_arrived": isArrived,
        },
      );

      if (response.statusCode == 200) {
        responseStatusOrder = OrderResponse.fromJson(jsonDecode(response.body));
        responseStatusOrder.status = true;
      } else if (response.statusCode >= 400) {
        responseStatusOrder = OrderResponse();
        responseStatusOrder.message = jsonDecode(response.body)['message'];
        responseStatusOrder.status = false;
      }
    } catch (ex) {
      responseStatusOrder = OrderResponse();
      responseStatusOrder.message = ex.toString();
      responseStatusOrder.status = false;
    }

    return responseStatusOrder;
  }

  Future<OrderResponse?> rateOrder(String orderId, String rate) async {
    OrderResponse? responseStatusRateOrder;
    try {
      final response;
      response = await http.post(
        Uri.parse(SittingsApi.RATE_ORDER),
        headers: AppHelpers.getHeader(_shared),
        body: {
          "order_id": orderId,
          "rate": rate,
        },
      );

      if (response.statusCode == 200) {
        responseStatusRateOrder =
            OrderResponse.fromJson(jsonDecode(response.body));
        responseStatusRateOrder.status = true;
      } else if (response.statusCode >= 400) {
        responseStatusRateOrder = OrderResponse();
        responseStatusRateOrder.message = jsonDecode(response.body)['message'];
        responseStatusRateOrder.status = false;
      }
    } catch (ex) {
      responseStatusRateOrder = OrderResponse();
      responseStatusRateOrder.message = ex.toString();
      responseStatusRateOrder.status = false;
    }

    return responseStatusRateOrder;
  }

  Future<GeneralResponse?> addBalance(double amount) async {
    GeneralResponse? responseAddBalance;
    try {
      final response;
      response = await http.post(
        Uri.parse(SittingsApi.ADD_BALANCE),
        headers: AppHelpers.getHeader(_shared),
        body: {"amount": amount.toString()},
      );

      if (response.statusCode == 200) {
        responseAddBalance =
            GeneralResponse.fromJson(jsonDecode(response.body));
        responseAddBalance.status = true;
      } else if (response.statusCode >= 400) {
        responseAddBalance = GeneralResponse();
        responseAddBalance.message = jsonDecode(response.body)['message'];
        responseAddBalance.status = false;
      }
    } catch (ex) {
      responseAddBalance = GeneralResponse();
      responseAddBalance.message = ex.toString();
      responseAddBalance.status = false;
    }

    return responseAddBalance;
  }

  Future<GeneralResponse?> requestBalance(
    int bankId,
    String image,
    String name,
  ) async {
    GeneralResponse? responseRequentBalance;

    try {
      final response;

      FormData formData = FormData.fromMap({
        'bank_id': bankId,
        'name': name,
        'image': await MultipartFile.fromFile(
          image,
          filename: DateTime.now().toString(),
        ),
      });

      response = await Dio().post(
        SittingsApi.REQUEST_BALANCE,
        data: formData,
        options: Options(
          headers: AppHelpers.getHeader(_shared),
          followRedirects: false,
          validateStatus: (int? status) {
            return status! < 500;
          },
        ),
      );

      log('message');
      if (response.statusCode == 200) {
        responseRequentBalance = GeneralResponse.fromJson(response.data);
        responseRequentBalance.status = true;
      } else if (response.statusCode >= 400) {
        responseRequentBalance = GeneralResponse();
        responseRequentBalance.message = response.data['message'];
        responseRequentBalance.status = false;
      }
    } catch (ex) {
      responseRequentBalance = GeneralResponse();
      responseRequentBalance.message = ex.toString();
      responseRequentBalance.status = false;
    }

    return responseRequentBalance;
  }

  Future<ResponsePrivacy?> privacyPolicy() async {
    ResponsePrivacy? responsePrivacy;

    try {
      final response;

      response = await http.get(
        Uri.parse(SittingsApi.PRIVACY_POLICY),
        headers: {"Accept": "application/json"},
      );
      if (response.statusCode == 200) {
        responsePrivacy = ResponsePrivacy.fromJson(jsonDecode(response.body));
        responsePrivacy.status = true;
      } else if (response.statusCode >= 400) {
        responsePrivacy = ResponsePrivacy();
        responsePrivacy.message = jsonDecode(response.body)['message'];
        responsePrivacy.status = false;
      }
    } catch (ex) {
      responsePrivacy = ResponsePrivacy();
      responsePrivacy.message = ex.toString();
      responsePrivacy.status = false;
    }

    return responsePrivacy;
  }

  // ! Mack Offer
  Future<CommonQuastionsResponse?> getCommonQus({
    required int page,
  }) async {
    CommonQuastionsResponse? responseCommonQus;
    try {
      final response;
      log("${SittingsApi.COMMON_QUSTION}?&page=$page");
      response = await http.get(
        Uri.parse(
          "${SittingsApi.COMMON_QUSTION}?&page=$page",
        ),
        headers: AppHelpers.getHeader(_shared),
      );

      if (response.statusCode == 200) {
        responseCommonQus =
            CommonQuastionsResponse.fromJson(jsonDecode(response.body));
        responseCommonQus.status = true;
      } else if (response.statusCode >= 400) {
        responseCommonQus = CommonQuastionsResponse();
        responseCommonQus.message = jsonDecode(response.body)['message'];
        responseCommonQus.status = false;
      }
    } catch (ex) {
      responseCommonQus = CommonQuastionsResponse();
      responseCommonQus.message = ex.toString();
      responseCommonQus.status = false;
    }

    return responseCommonQus;
  }

  Future<ResponsePrivacy?> termsOfUse() async {
    ResponsePrivacy? responsePrivacy;

    try {
      final response;

      response = await http.get(
        Uri.parse(SittingsApi.TERMS_OF_USE),
        headers: {"Accept": "application/json"},
      );
      if (response.statusCode == 200) {
        responsePrivacy = ResponsePrivacy.fromJson(jsonDecode(response.body));
        responsePrivacy.status = true;
      } else if (response.statusCode >= 400) {
        responsePrivacy = ResponsePrivacy();
        responsePrivacy.message = jsonDecode(response.body)['message'];
        responsePrivacy.status = false;
      }
    } catch (ex) {
      responsePrivacy = ResponsePrivacy();
      responsePrivacy.message = ex.toString();
      responsePrivacy.status = false;
    }

    return responsePrivacy;
  }

  Future<ResponseNotification?> showNotifications() async {
    ResponseNotification? responseNotifications;

    try {
      final response;

      response = await http.get(
        Uri.parse(SittingsApi.NOTIFICATION),
        headers: AppHelpers.getHeader(_shared),
      );
      if (response.statusCode == 200) {
        responseNotifications =
            ResponseNotification.fromJson(jsonDecode(response.body));
        responseNotifications.status = true;
      } else if (response.statusCode >= 400) {
        responseNotifications = ResponseNotification();
        responseNotifications.message = jsonDecode(response.body)['message'];
        responseNotifications.status = false;
      }
    } catch (ex) {
      responseNotifications = ResponseNotification();
      responseNotifications.message = ex.toString();
      responseNotifications.status = false;
    }

    return responseNotifications;
  }

  Future<ShowOrderIdsResponse?> getShowOrderIds() async {
    ShowOrderIdsResponse? responseOrderIds;
    try {
      final response;
      response = await http.get(
        Uri.parse(SittingsApi.GET_SHOW_ORDER_IDS),
        headers: AppHelpers.getHeader(_shared),
      );
      print(response.statusCode);

      if (response.statusCode == 200) {
        responseOrderIds =
            ShowOrderIdsResponse.fromJson(jsonDecode(response.body));
        responseOrderIds.status = true;
      } else if (response.statusCode >= 400) {
        responseOrderIds = ShowOrderIdsResponse();
        responseOrderIds.message = jsonDecode(response.body)['message'];
        responseOrderIds.status = false;
      }
    } catch (ex) {
      responseOrderIds = ShowOrderIdsResponse();
      responseOrderIds.message = ex.toString();
      responseOrderIds.status = false;
    }

    return responseOrderIds;
  }
}
