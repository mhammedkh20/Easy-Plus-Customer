import 'package:easy_plus_customer/core/network/api/api_side_bar.dart';
import 'package:easy_plus_customer/features/main/model/response_notification.dart';
import 'package:easy_plus_customer/features/main/model/response_privacy.dart';
import 'package:easy_plus_customer/features/request_services/model/general_response.dart';
import 'package:easy_plus_customer/features/side_bar/domin/side_bar_repo.dart';
import 'package:easy_plus_customer/features/side_bar/model/common_quastions_response.dart';
import 'package:easy_plus_customer/features/side_bar/model/complaints_response.dart';
import 'package:easy_plus_customer/features/side_bar/model/my_orders_response.dart';
import 'package:easy_plus_customer/features/side_bar/model/order/order_response.dart';
import 'package:easy_plus_customer/features/side_bar/model/response_data.dart';
import 'package:easy_plus_customer/features/side_bar/model/show_order_ids_response.dart';
import 'package:easy_plus_customer/features/side_bar/model/wallet/wallet_response.dart';

class SideBarRepoImp extends SideBarRepo {
  final ApiSideBar _api = ApiSideBar();

  @override
  Future<ResponseData?> sendContactUs({
    required String title,
    required String message,
  }) {
    return _api.contactUs(title: title, message: message);
  }

  @override
  Future<ResponseData?> sendReportMissing({
    required String phone,
    required String message,
    required String missingTime,
    required String orderId,
    List<String>? items,
  }) {
    return _api.reportMissing(
      phone: phone,
      message: message,
      missingTime: missingTime,
      orderId: orderId,
      items: items,
    );
  }

  @override
  Future<MyOrdersResponse?> getMyOrders(
      {required String orderId, required int page}) {
    return _api.getMyOrder(statusOrder: orderId, page: page);
  }

  @override
  Future<WalletResponse?> getTransactions() {
    return _api.getTransaction();
  }

  @override
  Future<ComplaintsResponse?> getComplaintsResponse({required int page}) {
    return _api.getComplaints(page: page);
  }

  @override
  Future<ComplaintsResponse?> sendComplaints({
    required String orderId,
    required String desc,
  }) {
    return _api.postComplaints(orderId, desc);
  }

  @override
  Future<OrderResponse?> getDetailsOrder({required String orderId}) {
    return _api.getDataOrder(orderId);
  }

  @override
  Future<OrderResponse?> acceptOffer({required String offerId}) {
    return _api.acceptOffer(offerId);
  }

  @override
  Future<OrderResponse?> refuseOffer({required String offerId}) {
    return _api.refuseOffer(offerId);
  }

  @override
  Future<OrderResponse?> cancelOrder({required String offerId}) {
    return _api.cancelOrder(offerId);
  }

  @override
  Future<OrderResponse?> finishOrder({
    required String orderId,
    required String isArrived,
  }) {
    return _api.finishTheOrder(orderId, isArrived);
  }

  @override
  Future<OrderResponse?> rateOrder({
    required String orderId,
    required String rate,
  }) {
    return _api.rateOrder(orderId, rate);
  }

  @override
  Future<GeneralResponse?> addBalance({required double amount}) {
    return _api.addBalance(amount);
  }

  @override
  Future<GeneralResponse?> requestBalance({
    required int bankId,
    required String image,
    required String name,
  }) {
    return _api.requestBalance(bankId, image, name);
  }

  @override
  Future<ResponsePrivacy?> privacyPolicy() {
    return _api.privacyPolicy();
  }

  @override
  Future<CommonQuastionsResponse?> getCommonQus(int page) {
    return _api.getCommonQus(page: page);
  }

  @override
  Future<ResponsePrivacy?> termsOfUse() {
    return _api.termsOfUse();
  }

  @override
  Future<ResponseNotification?> showNotifications() {
    return _api.showNotifications();
  }

  @override
  Future<ShowOrderIdsResponse?> showOrderIds() async {
    return _api.getShowOrderIds();
  }
}
