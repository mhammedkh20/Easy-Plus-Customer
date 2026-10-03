import 'dart:convert';

import 'package:easy_plus_customer/core/network/api/settings_api.dart';
import 'package:easy_plus_customer/core/storage/pref/shared_pref_controller.dart';
import 'package:easy_plus_customer/core/utils/app_helpers.dart';
import 'package:easy_plus_customer/features/on_boarding/model/response_login_method.dart';
import 'package:http/http.dart' as http;

class ApiOnboarding {
  final SharedPrefController _shared = SharedPrefController();

  Future<ResponseLoginMethod?> getLoginMethods() async {
    ResponseLoginMethod? responseData;
    try {
      final response;

      response = await http.get(
        Uri.parse(SittingsApi.SHOW_LOGIN_METHOD),
        headers: AppHelpers.getHeader(_shared),
      );

      if (response.statusCode == 200) {
        responseData = ResponseLoginMethod.fromJson(jsonDecode(response.body));
        responseData.status = true;
      } else if (response.statusCode >= 400) {
        responseData = ResponseLoginMethod();
        responseData.message = jsonDecode(response.body)['message'];
        responseData.status = false;
      }
    } catch (ex) {
      responseData = ResponseLoginMethod();
      responseData.message = ex.toString();
      responseData.status = false;
    }

    return responseData;
  }
}
