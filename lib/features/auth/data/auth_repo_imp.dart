import 'package:easy_plus_customer/core/network/api/api_auth.dart';
import 'package:easy_plus_customer/features/auth/domin/auth_repo.dart';
import 'package:easy_plus_customer/features/auth/model/response_sign_up.dart';
import 'package:easy_plus_customer/features/auth/model/user.dart';

class AuthRepoImp extends AuthRepo {
  final ApiAuth _api = ApiAuth();

  @override
  Future<ResponseAuth?> forgetPassword({
    required String other,
    required int socialSelectedIndex,
  }) {
    return _api.forgetPassword(
      other: other,
      socialSelectedIndex: socialSelectedIndex,
    );
  }

  @override
  Future<ResponseAuth?> login({
    required String other,
    required String password,
    required int socialSelectedIndex,
  }) {
    return _api.loginAccount(
      other: other,
      password: password,
      socialSelectedIndex: socialSelectedIndex,
    );
  }

  @override
  Future<ResponseAuth?> register({
    required String name,
    required String other,
    required String gender,
    required String password,
    required int socialSelectedIndex,
  }) {
    return _api.registerAccount(
      name: name,
      password: password,
      other: other,
      gender: gender,
      socialSelectedIndex: socialSelectedIndex,
    );
  }

  @override
  Future<ResponseAuth?> resetPassword({
    required String phone,
    required String password,
    required String passwordConfirmation,
  }) {
    return _api.resetPassword(
      password: password,
      phone: phone,
      passwordConfirmation: passwordConfirmation,
    );
  }

  @override
  Future<ResponseAuth?> verifyCode({
    required String other,
    required String code,
    required int socialSelectedIndex,
  }) {
    return _api.verifyCodeAccount(
      other: other,
      socialSelectedIndex: socialSelectedIndex,
      code: code,
    );
  }

  @override
  Future<ResponseAuth?> updateAccount({required User user}) {
    return _api.updateAccount(user: user);
  }

  @override
  Future<ResponseAuth?> changePassword({
    required String currentPass,
    required String newPass,
    required String confirmPass,
  }) {
    return _api.changePassword(
      currentPass: currentPass,
      newPass: newPass,
      confirmPass: confirmPass,
    );
  }

  @override
  Future<ResponseAuth?> logout() {
    return _api.logout();
  }

  @override
  Future<ResponseAuth?> profile() {
    return _api.getProfile();
  }
}
