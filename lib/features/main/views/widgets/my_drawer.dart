import 'package:easy_plus_customer/core/storage/pref/shared_pref_controller.dart';
import 'package:easy_plus_customer/core/utils/app_dialogs.dart';
import 'package:easy_plus_customer/core/utils/app_helpers.dart';
import 'package:easy_plus_customer/core/widgets/my_contianer_shape.dart';
import 'package:easy_plus_customer/features/auth/views/manager/auth_cubit/auth_cubit.dart';
import 'package:easy_plus_customer/features/auth/views/pages/login_screen.dart';
import 'package:easy_plus_customer/features/side_bar/views/manager/my_account_cubit/my_account_cubit.dart';
import 'package:easy_plus_customer/features/side_bar/views/pages/common_questions_screen.dart';
import 'package:easy_plus_customer/features/side_bar/views/pages/complaint_request/complaint_requests_screen.dart';
import 'package:easy_plus_customer/features/side_bar/views/pages/contact_us_screen.dart';
import 'package:easy_plus_customer/features/side_bar/views/pages/my_account_screen.dart';
import 'package:easy_plus_customer/features/side_bar/views/pages/my_request_screens/my_request_screen.dart';
import 'package:easy_plus_customer/features/side_bar/views/pages/notification_screen.dart';
import 'package:easy_plus_customer/features/side_bar/views/pages/privacy_policy_screen.dart';
import 'package:easy_plus_customer/features/side_bar/views/pages/report_missing_screen.dart';
import 'package:easy_plus_customer/features/side_bar/views/pages/settings_screens/settings_screen.dart';
import 'package:easy_plus_customer/features/side_bar/views/pages/terms_and_conditions.dart';
import 'package:easy_plus_customer/features/side_bar/views/pages/wallet_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:easy_plus_customer/core/utils/app_colors.dart';
import 'package:easy_plus_customer/core/widgets/my_text.dart';
import 'package:easy_plus_customer/features/main/model/item_drawer_model.dart';
import 'package:easy_plus_customer/features/main/views/manager/main_cubit/main_cubit.dart';
import 'package:easy_plus_customer/features/main/views/widgets/item_drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.BASE_COLOR,
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      width: MediaQuery.of(context).size.width * 0.65,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: MediaQuery.of(context).padding.top + 10.h),
          GestureDetector(
            onTap: () {
              // MainCubit.get(context).zoomDrawerController.close;

              MainCubit.get(context).drawerController.close();
            },
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(
                  Icons.arrow_back,
                  color: AppColors.WHITE,
                  size: 20.r,
                ),
                SizedBox(width: 8.w),
                MyText(
                  title: AppLocalizations.of(context)!.back,
                  color: AppColors.WHITE,
                  fontSize: 16,
                )
              ],
            ),
          ),
          SizedBox(height: 10.h),
          BlocBuilder<MyAccountCubit, MyAccountState>(
            builder: (context, state) {
              if (MyAccountCubit.get(context).userData!.image != null) {
                return MyContainerShape(
                  borderRadius: 8,
                  width: 50.r,
                  height: 50.r,
                  bgContainer: AppColors.TRANSPARENT,
                  child: Image.network(
                    MyAccountCubit.get(context).userData!.image!,
                    width: 50.r,
                    height: 50.r,
                    fit: BoxFit.cover,
                  ),
                );
              }
              return Image.asset('assets/images/ic_user.png');
            },
          ),
          SizedBox(height: 12.h),
          MyText(
            title: AppLocalizations.of(context)!.welcome,
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: AppColors.WHITE,
          ),
          SizedBox(height: 4.h),
          BlocBuilder<MyAccountCubit, MyAccountState>(
            builder: (context, state) {
              return MyText(
                title: MyAccountCubit.get(context).userData!.name ?? "",
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: AppColors.WHITE,
              );
            },
          ),
          SizedBox(height: 20.h),
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.zero,
              itemCount: MainCubit.get(context).itemsDrawer(context).length,
              itemBuilder: (context, index) {
                ItemDrawerModel item =
                    MainCubit.get(context).itemsDrawer(context)[index];
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (12 == index) ...[
                      SizedBox(height: 23.h),
                      Divider(
                        height: 1.h,
                        thickness: 1,
                        color: AppColors.WHITE,
                      ),
                      SizedBox(height: 20.h),
                      BlocConsumer<AuthCubit, AuthState>(
                        listener: (context, state) async {
                          if (state is LogoutSuccess) {
                            await logout(context);
                          }
                          if (state is LogoutFailed) {
                            await logout(context);
                          }
                        },
                        builder: (context, state) {
                          if (state is LogoutLoading) {
                            return CircularProgressIndicator.adaptive();
                          }
                          return ItemDrawer(
                            item: item,
                            onTap: () async {
                              AppDialogs.customDialog(
                                context,
                                onPressedBack: () {
                                  Navigator.of(context).pop();
                                },
                                onPressedDelete: () {
                                  AuthCubit.get(context).logout(context);
                                  Navigator.of(context).pop();
                                },
                                titleHeader: null,
                                iconHeader: 'assets/images/danger.png',
                                desc1: AppLocalizations.of(context)!
                                    .areYouSureYouWantToLogOut,
                                desc1Color: AppColors.BLACK,
                                png: true,
                                sizeHeader: 50,
                              );
                            },
                          );
                        },
                      ),
                    ] else ...[
                      index == 11
                          ? BlocBuilder<AuthCubit, AuthState>(
                              builder: (context, state) {
                                if (state is LogoutLoading) {
                                  return CircularProgressIndicator.adaptive();
                                }
                                return ItemDrawer(
                                  item: item,
                                  onTap: () async {
                                    await onNavigationScreen(context, index);
                                  },
                                );
                              },
                            )
                          : ItemDrawer(
                              item: item,
                              onTap: () async {
                                if (index != 10 || index != 11) {
                                  MainCubit.get(context)
                                      .drawerController
                                      .close();
                                }
                                await onNavigationScreen(context, index);
                              },
                            ),
                      SizedBox(height: 10.h),
                    ]
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Future onNavigationScreen(BuildContext context, int index) async {
    switch (index) {
      case 0:
        AppHelpers.navigationToPage(context, MyAccountScreen());
        break;
      case 1:
        AppHelpers.navigationToPage(context, const MyRequestScreen());
        break;
      case 2:
        AppHelpers.navigationToPage(context, const NotificationScreen());
        break;
      case 3:
        AppHelpers.navigationToPage(context, const WalletScreen());
        break;
      case 4:
        AppHelpers.navigationToPage(context, const ComplaintRequestsScreen());
        break;
      case 5:
        AppHelpers.navigationToPage(context, ReportMissingScreen());
        break;
      // case 6:
      //   AppHelpers.navigationToPage(context, AboutInfoScreen());
      //   break;
      case 6:
        AppHelpers.navigationToPage(context, ContactUsScreen());
        break;

      case 7:
        AppHelpers.navigationToPage(context, const CommonQuestionsScreen());
        break;
      case 8:
        AppHelpers.navigationToPage(context, const PrivacyPolicyScreen());
        break;
      case 9:
        AppHelpers.navigationToPage(context, const TermsAndConditionsScreen());
        break;
      case 10:
        AppHelpers.navigationToPage(context, const SettingsScreen());
        break;
      case 11:
        AppDialogs.customDialog(
          context,
          onPressedBack: () {
            Navigator.of(context).pop();
          },
          onPressedDelete: () {
            AuthCubit.get(context).logout(context);
            Navigator.of(context).pop();
          },
          titleHeader: AppLocalizations.of(context)!.deleteAccount,
          iconColor: null,
          iconHeader: 'assets/images/ic_emoji.png',
          desc1: AppLocalizations.of(context)!.areYouSureToDeleteYourAccount,
          desc1Color: AppColors.BLACK,
          sizeHeader: 100,
          png: true,
          iconSize: 36,
        );
        break;
    }
  }

  Future logout(BuildContext context) async {
    MainCubit.get(context).drawerController.close();
    await SharedPrefController().clearAllData();
    AppHelpers.navigationToPageAndExitAll(context, LoginScreen());
  }
}
