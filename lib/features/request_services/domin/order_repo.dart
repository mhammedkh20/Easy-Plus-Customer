import 'package:easy_plus_customer/features/main/model/response_category.dart';
import 'package:easy_plus_customer/features/request_services/model/order_model.dart';
import 'package:easy_plus_customer/features/request_services/model/places/response_place_details.dart';
import 'package:easy_plus_customer/features/request_services/model/places/response_predictions.dart';
import 'package:easy_plus_customer/features/side_bar/model/order/order_response.dart';

abstract class OrderRepo {
  Future<OrderResponse?> postOrder({required OrderModel order});
  Future<ResponseCategory?> getSliderCategory(int id);
  Future<ResponsePredictions?> getPredictions(String input);
  Future<ResponsePlaceDetails?> getPlaceDetails(String input);
}
