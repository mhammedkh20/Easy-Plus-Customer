import 'package:easy_plus_customer/features/on_boarding/model/response_login_method.dart';

abstract class OnboardingRepo {
  Future<ResponseLoginMethod?> getLoginMethod();
}
