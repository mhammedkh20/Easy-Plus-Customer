import 'package:easy_plus_customer/core/storage/pref/pref_keys.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../features/auth/model/user.dart';

class SharedPrefController {
  static final SharedPrefController _instance =
      SharedPrefController._internal();

  late SharedPreferences _preferences;

  SharedPrefController._internal();

  factory SharedPrefController() => _instance;

  Future<SharedPreferences> initSharedPref() async =>
      _preferences = await SharedPreferences.getInstance();

  SharedPreferences get prefManager => _preferences;

  Future<bool> setToken(String token) async =>
      await _preferences.setString(PrefKeys.TOKEN, token);

  String? get getToken => _preferences.getString(PrefKeys.TOKEN);

  Future<bool> saveDataUser(User user) async {
    await _preferences.setInt(PrefKeys.ID_USER, user.id ?? -1);
    await _preferences.setString(PrefKeys.ID_NUMBER_USER, user.idNumber ?? '');
    await _preferences.setString(PrefKeys.NAME_USER, user.name ?? "");
    await _preferences.setString(PrefKeys.PHONE_USER, user.phone ?? "");
    await _preferences.setString(PrefKeys.TOKEN, user.token ?? "");
    await _preferences.setString(PrefKeys.STATUS_USER, user.status ?? "");
    await _preferences.setString(PrefKeys.GENDER_USER, user.gender ?? "");
    await _preferences.setString(
        PrefKeys.WALLET_BALANCE, user.walletBalance ?? "");
    await _preferences.setString(
        PrefKeys.BIRTH_DATE_USER, user.birthDate ?? "");

    return await _preferences.setString(PrefKeys.IMAGE_USER, user.image ?? "");
  }

  User getDataUser() {
    int id = _preferences.getInt(PrefKeys.ID_USER) ?? -1;
    String idNumber = _preferences.getString(PrefKeys.ID_NUMBER_USER) ?? '';
    String name = _preferences.getString(PrefKeys.NAME_USER) ?? "";
    String phone = _preferences.getString(PrefKeys.PHONE_USER) ?? "";
    String email = _preferences.getString(PrefKeys.EMAIL) ?? "";
    String token = _preferences.getString(PrefKeys.TOKEN) ?? "";
    String status = _preferences.getString(PrefKeys.STATUS_USER) ?? "";
    String gender = _preferences.getString(PrefKeys.GENDER_USER) ?? "";
    String walletBalance =
        _preferences.getString(PrefKeys.WALLET_BALANCE) ?? "";
    String birthDate = _preferences.getString(PrefKeys.BIRTH_DATE_USER) ?? "";
    String image = _preferences.getString(PrefKeys.IMAGE_USER) ?? "";

    return User(
      id: id,
      name: name,
      phone: phone,
      birthDate: birthDate,
      idNumber: idNumber,
      token: token,
      email: email,
      status: status,
      gender: gender,
      image: image,
      walletBalance: walletBalance,
    );
  }

  Future<bool> setLang(String token) async =>
      await _preferences.setString(PrefKeys.LANG, token);

  String get getLang => _preferences.getString(PrefKeys.LANG) ?? 'ar';

  // ! type email or phone
  Future<bool> setTypeTextFeild(String type) async =>
      await _preferences.setString(PrefKeys.TYPE_LOGIN, type);

  String? get getTypeTextFeild => _preferences.getString(PrefKeys.TYPE_LOGIN);

  Future clearAllData() async {
    await _preferences.clear();
  }
}
