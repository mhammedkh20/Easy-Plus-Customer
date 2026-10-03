import 'package:easy_plus_customer/core/storage/pref/shared_pref_controller.dart';
import 'package:easy_plus_customer/core/utils/app_helpers.dart';
import 'package:easy_plus_customer/core/utils/remoteconfig_servoce.dart';
import 'package:easy_plus_customer/features/main/views/manager/main_cubit/main_cubit.dart';
import 'package:easy_plus_customer/features/main/views/pages/main_screen.dart';
import 'package:easy_plus_customer/features/on_boarding/views/pages/on_boarding_screen.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:easy_plus_customer/features/on_boarding/data/onboarding_repo_imp.dart';
import 'package:easy_plus_customer/features/on_boarding/model/response_login_method.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'on_boarding_state.dart';

class OnBoardingCubit extends Cubit<OnBoardingState> {
  final OnboardingRepoImp _onboardingRepoImp = OnboardingRepoImp();
  OnBoardingCubit() : super(OnBoardingInitial());

  static OnBoardingCubit get(BuildContext context) {
    return BlocProvider.of(context);
  }

  ResponseLoginMethod? methods;
  bool isLoading = true;

  Future getMethods(BuildContext context) async {
    await MainCubit.get(context).getAppConfig(context);
    bool check = await RemoteConfigService().checkOurAppForUpdate(context);
    if (!check) {
      ResponseLoginMethod? responseMethods =
          await _onboardingRepoImp.getLoginMethod();

      if (responseMethods != null && responseMethods.status!) {
        isLoading = false;
        methods = responseMethods;
        print(methods!.data!.length);

        emit(GetDataSuccess());
      }

      if (responseMethods == null) {
        emit(
          GetDataFailed(
              message:
                  AppLocalizations.of(context)!.anErrorOccurredPleaseTryAgain),
        );
      } else if (!responseMethods.status!) {
        emit(GetDataFailed(message: responseMethods.message!));
      }
    }
  }

  checkLogin(BuildContext context) {
    if (SharedPrefController().getToken != null) {
      AppHelpers.navigationReplacementToPage(context, const MainScreen());
    } else {
      AppHelpers.navigationReplacementToPage(
        context,
        const OnBoardingScreen(),
      );
    }
  }
}
