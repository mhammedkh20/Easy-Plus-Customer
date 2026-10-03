// ignore_for_file: constant_identifier_names

class SittingsApi {
  static const String BASE_URL = 'http://5ways.com.sa/api/';
  // ! Auth
  static const String REGISTR = '${BASE_URL}users/register';
  static const String LOGIN = '${BASE_URL}users/login';
  static const String VERIFY_CODE = '${BASE_URL}users/verify-code';
  static const String FORGET_PASSWORD = '${BASE_URL}users/forget-password';
  static const String RESET_PASSWORD = '${BASE_URL}users/reset-password';
  static const String CHANGE_PASSWORD = '${BASE_URL}users/change-password';
  static const String LOGOUT = '${BASE_URL}users/logout';
  static const String UPDATE_ACCOUNT = '${BASE_URL}users/update-profile';
  static const String PROFILE_ACCOUNT = '${BASE_URL}users/profile';

  // ! Category
  static const String CATEGORIES = '${BASE_URL}users/showCategories';
  static const String SLIDER_CATEGORIES = '${BASE_URL}ads/';
  static const String LAST_SEEN_DRIVERS = '${BASE_URL}users/lastSeenDrivers';

  // ! Side Bar
  static const String REPORT_MISSING = '${BASE_URL}users/report-missing';
  static const String CONTACT_US = '${BASE_URL}users/contact-us';
  static const String COMMON_QUSTION = '${BASE_URL}partners/common-quastions';
  static const String PRIVACY_POLICY = '${BASE_URL}users/privacy-policy';
  static const String TERMS_OF_USE = '${BASE_URL}users/terms_of_use';
  static const String NOTIFICATION = '${BASE_URL}users/notifications';
  static const String GET_SHOW_ORDER_IDS = '${BASE_URL}users/showOrderIds';

  // ! Orders
  static const String MAKE_ORDER = '${BASE_URL}users/make-order';
  static const String GET_MY_ORDERS = '${BASE_URL}users/showOrders?status=';
  static const String GET_DETAILS_ORDER = '${BASE_URL}users/showOrder/';
  static const String REFUSE_OFFER = '${BASE_URL}users/refuse-offer/';
  static const String ACCEPT_OFFER = '${BASE_URL}users/accept-offer/';
  static const String CANCEL_ORDER = '${BASE_URL}users/cancel-order/';
  static const String FINISH_ORDER = '${BASE_URL}users/arrive-order';
  static const String RATE_ORDER = '${BASE_URL}users/rate-order';

  // ! App Config
  static const String APP_CONFIG = '${BASE_URL}users/app';

  // ! Wallet
  static const String GET_WALLET = '${BASE_URL}users/wallet';
  static const String ADD_BALANCE = '${BASE_URL}users/add-balance';
  static const String REQUEST_BALANCE = '${BASE_URL}users/request-money';

  // ! Complaints
  static const String COMPLAINTS = '${BASE_URL}users/complaints';

  // ! On Boarding
  static const String SHOW_LOGIN_METHOD = '${BASE_URL}showLoginMethods';

  // ! get Google Places
  static const String PREDICTIONS =
      'https://maps.googleapis.com/maps/api/place/autocomplete/json';

  static const String PLACE_DETAILS =
      'https://maps.googleapis.com/maps/api/place/details/json';
}
