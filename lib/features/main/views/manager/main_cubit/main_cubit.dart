import 'package:easy_plus_customer/features/main/data/category_repo_imp.dart';
import 'package:easy_plus_customer/features/main/model/category_model.dart';
import 'package:easy_plus_customer/features/main/model/last_seen_drivers.dart';
import 'package:easy_plus_customer/features/main/model/response_app_config.dart';
import 'package:easy_plus_customer/features/main/model/response_category.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:bloc/bloc.dart';
import 'package:easy_plus_customer/features/main/model/item_drawer_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tale_drawer/tale_drawer.dart';

part 'main_state.dart';

class MainCubit extends Cubit<MainState> {
  final CategoryRepoImp _catRepoImp = CategoryRepoImp();

  // final zoomDrawerController = ZoomDrawerController();
  final drawerController = TaleController();

  MainCubit() : super(MainInitial());

  bool isLoading = true;
  List<CategoryModel> listCategory = [];

  List<ItemDrawerModel> itemsDrawer(BuildContext context) {
    return [
      ItemDrawerModel(
        iconPath: 'assets/images/ic_drawer/ic_profile.svg',
        name: AppLocalizations.of(context)!.profile,
      ),
      ItemDrawerModel(
        iconPath: 'assets/images/ic_drawer/ic_list.svg',
        name: AppLocalizations.of(context)!.myRequests,
      ),
      ItemDrawerModel(
        iconPath: 'assets/images/ic_drawer/ic_notification.svg',
        name: AppLocalizations.of(context)!.notifications,
      ),
      ItemDrawerModel(
        iconPath: 'assets/images/ic_drawer/ic_walet.svg',
        name: AppLocalizations.of(context)!.wallet,
      ),
      ItemDrawerModel(
        iconPath: 'assets/images/ic_drawer/ic_complaints.svg',
        name: AppLocalizations.of(context)!.complaintsAndSuggestions,
      ),
      ItemDrawerModel(
        iconPath: 'assets/images/ic_drawer/ic_inform.svg',
        name: AppLocalizations.of(context)!.reportMissing,
      ),
      // ItemDrawerModel(
      //   iconPath: 'assets/images/ic_drawer/ic_info.svg',
      //   name: AppLocalizations.of(context)!.aboutUs,
      // ),
      ItemDrawerModel(
        iconPath: 'assets/images/ic_drawer/ic_contact_us.svg',
        name: AppLocalizations.of(context)!.connectUs,
      ),
      ItemDrawerModel(
        iconPath: 'assets/images/ic_drawer/ic_qustions.svg',
        name: AppLocalizations.of(context)!.commonQuestions,
      ),
      ItemDrawerModel(
        iconPath: 'assets/images/ic_drawer/ic_privicy.svg',
        name: AppLocalizations.of(context)!.privacyPolicy,
      ),

      ItemDrawerModel(
        iconPath: 'assets/images/ic_drawer/ic_terms_and_conditions.svg',
        name: AppLocalizations.of(context)!.termsAndConditions,
      ),
      ItemDrawerModel(
        iconPath: 'assets/images/ic_drawer/ic_settings.svg',
        name: AppLocalizations.of(context)!.settings,
      ),
      ItemDrawerModel(
        iconPath: 'assets/images/ic_drawer/ic_delete.svg',
        name: AppLocalizations.of(context)!.deleteAccount,
      ),
      ItemDrawerModel(
        iconPath: 'assets/images/ic_drawer/ic_logout.svg',
        name: AppLocalizations.of(context)!.logOut,
      ),
    ];
  }

  static MainCubit get(BuildContext context) {
    return BlocProvider.of(context);
  }

  bool toggleMain = true;

  changeToggle(bool toggle) {
    toggleMain = toggle;
    emit(MainInitial());
  }

  notify() {
    emit(MainInitial());
  }

  Future getCategories(BuildContext context) async {
    ResponseCategory? responseCat = await _catRepoImp.getAllCategories();

    if (responseCat != null && responseCat.status!) {
      isLoading = false;
      listCategory.addAll(responseCat.data!);
      print(responseCat.data!.length);
      emit(MainInitial());
    }

    if (responseCat == null) {
      emit(
        CategoriesFailed(
            message:
                AppLocalizations.of(context)!.anErrorOccurredPleaseTryAgain),
      );
    } else if (!responseCat.status!) {
      emit(CategoriesFailed(message: responseCat.message!));
    }
  }

  ResponseAppConfig? appConfig;

  Future getAppConfig(BuildContext context) async {
    ResponseAppConfig? responseAppConfig = await _catRepoImp.getAppConfig();
    if (responseAppConfig != null && responseAppConfig.status!) {
      isLoading = false;
      appConfig = responseAppConfig;

      emit(MainInitial());
    }

    if (responseAppConfig == null) {
      emit(
        CategoriesFailed(
            message:
                AppLocalizations.of(context)!.anErrorOccurredPleaseTryAgain),
      );
    } else if (!responseAppConfig.status!) {
      emit(CategoriesFailed(message: responseAppConfig.message!));
    }
  }

  LastSeenDrivers? lastSeenDrivers;

  Future getLastSeen(BuildContext context) async {
    LastSeenDrivers? responseLastSeen = await _catRepoImp.getLastSeenDrivers();

    if (responseLastSeen != null && responseLastSeen.status!) {
      isLoading = false;
      lastSeenDrivers = responseLastSeen;

      emit(GetLastSeenDriversSuccess());
    }

    if (responseLastSeen == null) {
      emit(
        GetLastSeenDriversFailed(
            message:
                AppLocalizations.of(context)!.anErrorOccurredPleaseTryAgain),
      );
    } else if (!responseLastSeen.status!) {
      emit(GetLastSeenDriversFailed(message: responseLastSeen.message!));
    }
  }
}
