import 'dart:convert';

import 'package:easy_plus_customer/core/network/api/settings_api.dart';
import 'package:easy_plus_customer/core/storage/pref/shared_pref_controller.dart';
import 'package:easy_plus_customer/core/utils/app_helpers.dart';
import 'package:easy_plus_customer/features/main/model/last_seen_drivers.dart';
import 'package:easy_plus_customer/features/main/model/response_app_config.dart';
import 'package:easy_plus_customer/features/main/model/response_category.dart';
import 'package:http/http.dart' as http;

class ApiCat {
  final SharedPrefController _shared = SharedPrefController();

  Future<ResponseCategory?> getCategories() async {
    ResponseCategory? responseCategories;
    try {
      final response;

      response = await http.get(
        Uri.parse(SittingsApi.CATEGORIES),
        headers: AppHelpers.getHeader(_shared),
      );

      if (response.statusCode == 200) {
        responseCategories =
            ResponseCategory.fromJson(jsonDecode(response.body));
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

  Future<ResponseAppConfig?> getAppConfig() async {
    ResponseAppConfig? responseAppConfig;
    try {
      final response = await http.get(
        Uri.parse(SittingsApi.APP_CONFIG),
        headers: AppHelpers.getHeader(_shared),
      );

      if (response.statusCode == 200) {
        responseAppConfig =
            ResponseAppConfig.fromJson(jsonDecode(response.body));
        responseAppConfig.status = true;
      } else if (response.statusCode >= 400) {
        responseAppConfig = ResponseAppConfig();
        responseAppConfig.message = jsonDecode(response.body)['message'];
        responseAppConfig.status = false;
      }
    } catch (ex) {
      responseAppConfig = ResponseAppConfig();
      responseAppConfig.message = ex.toString();
      responseAppConfig.status = false;
    }

    return responseAppConfig;
  }

  Future<LastSeenDrivers?> getLastSeenDrivers() async {
    LastSeenDrivers? responseLastSeenDr;
    try {
      final response = await http.get(
        Uri.parse(SittingsApi.LAST_SEEN_DRIVERS),
        headers: AppHelpers.getHeader(_shared),
      );

      if (response.statusCode == 200) {
        responseLastSeenDr =
            LastSeenDrivers.fromJson(jsonDecode(response.body));
        responseLastSeenDr.status = true;
      } else if (response.statusCode >= 400) {
        responseLastSeenDr = LastSeenDrivers();
        responseLastSeenDr.message = jsonDecode(response.body)['message'];
        responseLastSeenDr.status = false;
      }
    } catch (ex) {
      responseLastSeenDr = LastSeenDrivers();
      responseLastSeenDr.message = ex.toString();
      responseLastSeenDr.status = false;
    }

    return responseLastSeenDr;
  }
}
