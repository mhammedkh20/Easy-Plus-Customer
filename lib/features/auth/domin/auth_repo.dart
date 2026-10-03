import 'package:easy_plus_customer/features/auth/model/user.dart';

import '../model/response_sign_up.dart';

abstract class AuthRepo {
  // ! Auth
  Future<ResponseAuth?> login({
    required String other,
    required int socialSelectedIndex,
    required String password,
  });

  Future<ResponseAuth?> register({
    required String name,
    required String other,
    required String gender,
    required String password,
    required int socialSelectedIndex,
  });

  Future<ResponseAuth?> verifyCode({
    required String other,
    required String code,
    required int socialSelectedIndex,
  });

  Future<ResponseAuth?> resetPassword({
    required String phone,
    required String password,
    required String passwordConfirmation,
  });

  Future<ResponseAuth?> forgetPassword({
    required String other,
    required int socialSelectedIndex,
  });
  Future<ResponseAuth?> changePassword({
    required String currentPass,
    required String newPass,
    required String confirmPass,
  });
  Future<ResponseAuth?> updateAccount({required User user});
  Future<ResponseAuth?> logout();
  Future<ResponseAuth?> profile();
}
