import 'dart:convert';
import 'package:easy_plus_customer/core/network/api/settings_api.dart';
import 'package:easy_plus_customer/core/storage/pref/shared_pref_controller.dart';
import 'package:easy_plus_customer/core/utils/app_helpers.dart';
import 'package:easy_plus_customer/features/main/model/response_category.dart';
import 'package:easy_plus_customer/features/request_services/model/order_model.dart';
import 'package:easy_plus_customer/features/request_services/model/places/response_place_details.dart';
import 'package:easy_plus_customer/features/request_services/model/places/response_predictions.dart';
import 'package:easy_plus_customer/features/side_bar/model/order/order_response.dart';
import 'package:http/http.dart' as http;

class ApiOrder {
  final SharedPrefController _shared = SharedPrefController();

  Future<OrderResponse?> sendOrder({required OrderModel model}) async {
    OrderResponse? responseOrder;
    try {
      Map<String, dynamic> postData = {};
      //! توصيل طلبات
      if (model.categoryId == 1) {
        postData = model.toJsonDelivry();
      }
      //! مراجع
      if (model.categoryId == 2) {
        postData = model.toJsonRevision();
      }
      //! تسوق شخصي
      if (model.categoryId == 3) {
        postData = model.toJsonShopper();
      }
      //! جولة
      if (model.categoryId == 4) {
        postData = model.toJsonTour();
      }

      //! مشوار
      if (model.categoryId == 5) {
        postData = model.toJsonMashwar();
      }

      final response = await http.post(
        Uri.parse(SittingsApi.MAKE_ORDER),
        headers: AppHelpers.getHeader(_shared),
        body: postData,
      );

      if (response.statusCode == 200) {
        responseOrder = OrderResponse.fromJson(jsonDecode(response.body));
        responseOrder.status = true;
      } else if (response.statusCode >= 400) {
        responseOrder = OrderResponse();
        responseOrder.message = jsonDecode(response.body)['message'];
        responseOrder.status = false;
      }
    } catch (ex) {
      responseOrder = OrderResponse();
      responseOrder.message = ex.toString();
      responseOrder.status = false;
    }

    return responseOrder;
  }

  Future<ResponseCategory?> getSliderByCategory(int catId) async {
    ResponseCategory? responseCategories;
    try {
      final response;

      response = await http.get(
        Uri.parse(SittingsApi.SLIDER_CATEGORIES + catId.toString()),
        headers: AppHelpers.getHeader(_shared),
      );
      if (response.statusCode == 200) {
        responseCategories =
            ResponseCategory.fromJsonSliders(jsonDecode(response.body));
        responseCategories.status = true;
      } else if (response.statusCode >= 400) {
        responseCategories = ResponseCategory();
        responseCategories.message = jsonDecode(response.body)['message'];
        responseCategories.status = false;
      }
    } catch (ex) {
      responseCategories = ResponseCategory();
      responseCategories.message = ex.toString();
      responseCategories.status = false;
    }

    return responseCategories;
  }

  Future<ResponsePredictions?> getPredictions({
    required String input,
  }) async {
    ResponsePredictions? responsePredictions;
    try {
      final response = await http.get(
        Uri.parse(
            '${SittingsApi.PREDICTIONS}?input=$input&language=ar&key=AIzaSyBmYbeBrpmYzA1noCpt_xXG6typcMP6PWc'),
      );
      if (response.statusCode == 200) {
        if (jsonDecode(response.body)['status'] == 'OK') {
          responsePredictions = ResponsePredictions.fromJson(
            jsonDecode(response.body),
          );
          responsePredictions.message = 'OK';
        } else {
          responsePredictions = ResponsePredictions();
          responsePredictions.status = jsonDecode(response.body)['status'];
          responsePredictions.message =
              jsonDecode(response.body)['error_message'];
        }
      } else if (response.statusCode >= 400) {
        responsePredictions = ResponsePredictions();
        responsePredictions.status = 'NO';
      }
    } catch (ex) {
      responsePredictions = ResponsePredictions();
      responsePredictions.status = 'NO';
      responsePredictions.message = ex.toString();
    }

    return responsePredictions;
  }

  Future<ResponsePlaceDetails?> getPlaceDetails({
    required String placeId,
  }) async {
    ResponsePlaceDetails? responsePlaceDetails;
    try {
      final response = await http.get(
        Uri.parse(SittingsApi.PLACE_DETAILS +
            '?' +
            'language=ar&key=AIzaSyBmYbeBrpmYzA1noCpt_xXG6typcMP6PWc&place_id=$placeId&fields=formatted_address,name,geometry,icon,place_id,plus_code,type,url,utc_offset,vicinity,wheelchair_accessible_entrance'),
      );
      if (response.statusCode == 200) {
        if (jsonDecode(response.body)['status'] == 'OK') {
          responsePlaceDetails = ResponsePlaceDetails.fromJson(
            jsonDecode(response.body),
          );
          responsePlaceDetails.message = 'OK';
        } else {
          responsePlaceDetails = ResponsePlaceDetails();
          responsePlaceDetails.status = jsonDecode(response.body)['status'];
          responsePlaceDetails.message =
              jsonDecode(response.body)['error_message'];
        }
      } else if (response.statusCode >= 400) {
        responsePlaceDetails = ResponsePlaceDetails();
        responsePlaceDetails.status = 'NO';
      }
    } catch (ex) {
      print("error " + ex.toString());
    }

    return responsePlaceDetails;
  }
}
