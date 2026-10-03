import 'package:easy_plus_customer/core/network/api/api_cat.dart';
import 'package:easy_plus_customer/features/main/domin/category_repo.dart';
import 'package:easy_plus_customer/features/main/model/last_seen_drivers.dart';
import 'package:easy_plus_customer/features/main/model/response_app_config.dart';
import 'package:easy_plus_customer/features/main/model/response_category.dart';

class CategoryRepoImp extends CategoryRepo {
  final ApiCat _api = ApiCat();

  @override
  Future<ResponseCategory?> getAllCategories() {
    return _api.getCategories();
  }

  @override
  Future<ResponseAppConfig?> getAppConfig() {
    return _api.getAppConfig();
  }

  @override
  Future<LastSeenDrivers?> getLastSeenDrivers() {
    return _api.getLastSeenDrivers();
  }
}
