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

abstract class SideBarRepo {
  Future<ResponseData?> sendContactUs({
    required String title,
    required String message,
  });

  Future<ResponseData?> sendReportMissing({
    required String phone,
    required String message,
    required String orderId,
    required String missingTime,
    List<String>? items,
  });

  Future<MyOrdersResponse?> getMyOrders({
    required String orderId,
    required int page,
  });

  Future<WalletResponse?> getTransactions();

  Future<ComplaintsResponse?> getComplaintsResponse({required int page});
  Future<ComplaintsResponse?> sendComplaints({
    required String orderId,
    required String desc,
  });

  Future<OrderResponse?> getDetailsOrder({required String orderId});
  Future<OrderResponse?> acceptOffer({required String offerId});
  Future<OrderResponse?> refuseOffer({required String offerId});
  Future<OrderResponse?> cancelOrder({required String offerId});
  Future<OrderResponse?> finishOrder({
    required String orderId,
    required String isArrived,
  });

  Future<OrderResponse?> rateOrder({
    required String orderId,
    required String rate,
  });

  Future<GeneralResponse?> addBalance({required double amount});

  Future<GeneralResponse?> requestBalance({
    required int bankId,
    required String image,
    required String name,
  });

  Future<ResponsePrivacy?> privacyPolicy();

  Future<CommonQuastionsResponse?> getCommonQus(int page);

  Future<ResponsePrivacy?> termsOfUse();

  Future<ResponseNotification?> showNotifications();

  Future<ShowOrderIdsResponse?> showOrderIds();
}
