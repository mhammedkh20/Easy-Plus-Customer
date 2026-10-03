import 'package:easy_plus_customer/features/main/model/last_seen_drivers.dart';
import 'package:easy_plus_customer/features/main/model/response_app_config.dart';
import 'package:easy_plus_customer/features/main/model/response_category.dart';

abstract class CategoryRepo {
  Future<ResponseCategory?> getAllCategories();
  Future<ResponseAppConfig?> getAppConfig();

  Future<LastSeenDrivers?> getLastSeenDrivers();
}
