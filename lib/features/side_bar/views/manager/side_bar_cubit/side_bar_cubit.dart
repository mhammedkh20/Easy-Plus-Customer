import 'dart:developer';
import 'package:easy_plus_customer/core/storage/pref/shared_pref_controller.dart';
import 'package:easy_plus_customer/features/main/model/notification_model.dart';
import 'package:easy_plus_customer/features/main/model/response_notification.dart';
import 'package:easy_plus_customer/features/main/model/response_privacy.dart';
import 'package:easy_plus_customer/features/request_services/model/general_response.dart';
import 'package:easy_plus_customer/features/side_bar/data/side_bar_repo_imp.dart';
import 'package:easy_plus_customer/features/side_bar/model/common_quastions_response.dart';
import 'package:easy_plus_customer/features/side_bar/model/qustion.dart';
import 'package:easy_plus_customer/features/side_bar/model/transactions.dart';
import 'package:easy_plus_customer/features/side_bar/model/wallet/wallet_response.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:easy_plus_customer/features/side_bar/model/response_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meta/meta.dart';

part 'side_bar_state.dart';

class SideBarCubit extends Cubit<SideBarState> {
  final SideBarRepoImp _apiSideBar = SideBarRepoImp();
  final ImagePicker _picker = ImagePicker();

  SideBarCubit() : super(SideBarInitial());

  static SideBarCubit get(BuildContext context) {
    return BlocProvider.of(context);
  }

  double totalTax = 0;
  double totalPayment = 0;
  changeTax(double tax, double price) {
    totalTax = price - (price * tax) / 100;
    totalPayment = price + (price * tax) / 100;
    emit(SideBarInitial());
  }

  String? pathImage;
  setBankImage(String? s) {
    pathImage = s;
    emit(SideBarInitial());
  }

  pickImageBank() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      pathImage = image.path;

      emit(SideBarInitial());
    }
  }

  Future sendContactUs(
    BuildContext context, {
    required String title,
    required String message,
  }) async {
    emit(ContactUsLoading());

    ResponseData? responseData = await _apiSideBar.sendContactUs(
      title: title.trim(),
      message: message.trim(),
    );

    if (responseData != null && responseData.status!) {
      emit(ContactUsSuccess(message: responseData.message!));
    }

    if (responseData == null) {
      emit(
        ContactUsFailed(
            message:
                AppLocalizations.of(context)!.anErrorOccurredPleaseTryAgain),
      );
    } else if (!responseData.status!) {
      emit(ContactUsFailed(message: responseData.message!));
    }
  }

  Future reportMissing(
    BuildContext context, {
    required String phone,
    required String message,
    required String orderId,
    required String missingTime,
    List<String>? items,
  }) async {
    emit(ContactUsLoading());

    ResponseData? responseData = await _apiSideBar.sendReportMissing(
      phone: phone.trim(),
      message: message.trim(),
      missingTime: missingTime.trim(),
      orderId: orderId.trim(),
      items: items,
    );

    if (responseData != null && responseData.status!) {
      emit(ContactUsSuccess(message: responseData.message!));
    }

    if (responseData == null) {
      emit(
        ContactUsFailed(
            message:
                AppLocalizations.of(context)!.anErrorOccurredPleaseTryAgain),
      );
    } else if (!responseData.status!) {
      emit(ContactUsFailed(message: responseData.message!));
    }
  }

  List<Transactions> listTransactions = [];
  String balnce = '0';
  String currency = 'SAR';

  Future getTransactions(BuildContext context, {int? index, int? id}) async {
    balnce = '0';
    emit(WalletLoading());

    WalletResponse? responseData = await _apiSideBar.getTransactions();

    if (responseData != null && responseData.status!) {
      if (responseData.data!.balance != null) {
        balnce = responseData.data!.balance!;
      }
      if (responseData.data!.currency != null) {
        currency = responseData.data!.currency!;
      }
      listTransactions = responseData.data!.transactions ?? [];
      emit(WalletSuccess(message: responseData.message!, index: index, id: id));
    }

    if (responseData == null) {
      emit(
        WalletFailed(
          message: AppLocalizations.of(context)!.anErrorOccurredPleaseTryAgain,
        ),
      );
    } else if (!responseData.status!) {
      emit(WalletFailed(message: responseData.message!));
    }
  }

  Future addBalance(
    BuildContext context, {
    required double amount,
    int? id,
  }) async {
    emit(BalanceLoading());

    GeneralResponse? responseData =
        await _apiSideBar.addBalance(amount: amount);

    if (responseData != null && responseData.status!) {
      log('addBalance Success');
      emit(BalanceSuccess(
          message: responseData.message!, id: id, navigationPage: true));
    }

    if (responseData == null) {
      log('addBalance  fail');

      emit(
        BalanceFailed(
          message: AppLocalizations.of(context)!.anErrorOccurredPleaseTryAgain,
        ),
      );
    } else if (!responseData.status!) {
      log('addBalance fail');

      emit(BalanceFailed(message: responseData.message!));
    }
  }

  Future requestBalance(
    BuildContext context, {
    required String image,
    required int bankId,
  }) async {
    emit(BalanceLoading());

    GeneralResponse? responseData = await _apiSideBar.requestBalance(
        bankId: bankId,
        image: image,
        name: SharedPrefController().getDataUser().name ?? "");

    if (responseData != null && responseData.status!) {
      emit(BalanceSuccess(message: responseData.message!));
    }

    if (responseData == null) {
      emit(
        BalanceFailed(
          message: AppLocalizations.of(context)!.anErrorOccurredPleaseTryAgain,
        ),
      );
    } else if (!responseData.status!) {
      emit(BalanceFailed(message: responseData.message!));
    }
  }

  ResponsePrivacy? responsePrivacy;

  Future getPrivacy(BuildContext context) async {
    emit(PrivacyPolicyLoading());

    ResponsePrivacy? responseData = await _apiSideBar.privacyPolicy();

    if (responseData != null && responseData.status!) {
      responsePrivacy = responseData;
      emit(PrivacyPolicySuccess(message: responseData.message!));
    }

    if (responseData == null) {
      emit(
        PrivacyPolicyFailed(
            message:
                AppLocalizations.of(context)!.anErrorOccurredPleaseTryAgain),
      );
    } else if (!responseData.status!) {
      emit(PrivacyPolicyFailed(message: responseData.message!));
    }
  }

  List<Qustion> listQustion = [];
  int total = 0;
  int page = 1;

  clearData({required bool withEmit}) {
    total = 0;
    page = 1;
    listQustion.clear();
    if (withEmit) {
      emit(SideBarInitial());
    }
  }

  Future getQustion(BuildContext context, {bool loadPagination = false}) async {
    if (loadPagination) {
      emit(QustionLoadingPagination());
      page++;
    } else {
      clearData(withEmit: false);
      emit(LoadingQustionData());
    }
    CommonQuastionsResponse? response = await _apiSideBar.getCommonQus(page);

    if (response != null && response.status!) {
      total = response.meta!.total ?? 0;
      listQustion.addAll(response.data ?? []);
      emit(SuccessQustionData());
    }

    if (response == null) {
      emit(
        FailedQustionData(
            message:
                AppLocalizations.of(context)!.anErrorOccurredPleaseTryAgain),
      );
    } else if (!response.status!) {
      emit(FailedQustionData(message: response.message!));
    }
  }

  ResponsePrivacy? responseTerms;
  Future getTermsOfUse(BuildContext context) async {
    emit(PrivacyPolicyLoading());

    ResponsePrivacy? responseData = await _apiSideBar.termsOfUse();

    if (responseData != null && responseData.status!) {
      responseTerms = responseData;
      emit(PrivacyPolicySuccess(message: responseData.message!));
    }

    if (responseData == null) {
      emit(
        PrivacyPolicyFailed(
            message:
                AppLocalizations.of(context)!.anErrorOccurredPleaseTryAgain),
      );
    } else if (!responseData.status!) {
      emit(PrivacyPolicyFailed(message: responseData.message!));
    }
  }

  List<NotificationModel> listNotification = [];
  Future showNotifications(BuildContext context) async {
    emit(NotificationsLoading());

    ResponseNotification? responseData = await _apiSideBar.showNotifications();

    if (responseData != null && responseData.status!) {
      listNotification = responseData.data ?? [];
      emit(NotificationsSuccess());
    }

    if (responseData == null) {
      emit(
        NotificationsFailed(
            message:
                AppLocalizations.of(context)!.anErrorOccurredPleaseTryAgain),
      );
    } else if (!responseData.status!) {
      emit(NotificationsFailed(message: responseData.message!));
    }
  }
}
