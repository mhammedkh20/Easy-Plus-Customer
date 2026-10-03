import 'package:easy_plus_customer/core/network/api/api_onboarding.dart';
import 'package:easy_plus_customer/features/on_boarding/domin/onboarding_repo.dart';
import 'package:easy_plus_customer/features/on_boarding/model/response_login_method.dart';

class OnboardingRepoImp extends OnboardingRepo {
  final ApiOnboarding _api = ApiOnboarding();

  @override
  Future<ResponseLoginMethod?> getLoginMethod() {
    return _api.getLoginMethods();
  }
}
