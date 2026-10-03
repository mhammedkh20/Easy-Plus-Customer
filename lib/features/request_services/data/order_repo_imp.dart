import 'package:easy_plus_customer/core/network/api/api_order.dart';
import 'package:easy_plus_customer/features/main/model/response_category.dart';
import 'package:easy_plus_customer/features/request_services/domin/order_repo.dart';
import 'package:easy_plus_customer/features/request_services/model/order_model.dart';
import 'package:easy_plus_customer/features/request_services/model/places/response_place_details.dart';
import 'package:easy_plus_customer/features/request_services/model/places/response_predictions.dart';
import 'package:easy_plus_customer/features/side_bar/model/order/order_response.dart';

class OrderRepoImp extends OrderRepo {
  final ApiOrder _api = ApiOrder();

  @override
  Future<OrderResponse?> postOrder({required OrderModel order}) {
    return _api.sendOrder(model: order);
  }

  @override
  Future<ResponseCategory?> getSliderCategory(int id) {
    return _api.getSliderByCategory(id);
  }

  @override
  Future<ResponsePredictions?> getPredictions(String input) {
    return _api.getPredictions(input: input);
  }

  @override
  Future<ResponsePlaceDetails?> getPlaceDetails(String placeId) {
    return _api.getPlaceDetails(placeId: placeId);
  }
}
