import 'package:easy_plus_customer/core/utils/app_colors.dart';
import 'package:easy_plus_customer/core/utils/app_helpers.dart';
import 'package:easy_plus_customer/core/widgets/my_app_bar.dart';
import 'package:easy_plus_customer/core/widgets/my_contianer_shape.dart';
import 'package:easy_plus_customer/core/widgets/my_text.dart';
import 'package:easy_plus_customer/features/side_bar/views/pages/settings_screens/change_password_screen.dart';
import 'package:easy_plus_customer/features/side_bar/views/widgets/settings/tab_language.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_svg/svg.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.BG_SCAFOLLD,
      appBar: MyAppBar(
        backgroundColor: AppColors.BG_SCAFOLLD,
        title: AppLocalizations.of(context)!.settings,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 32.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            MyText(
              title: AppLocalizations.of(context)!.theLanguage,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
            SizedBox(height: 10.h),
            const TabLanguage(),
            SizedBox(height: 20.h),
            MyText(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              title: AppLocalizations.of(context)!.securityInformation,
            ),
            SizedBox(height: 12.h),
            Material(
              color: AppColors.WHITE,
              borderRadius: BorderRadius.circular(11),
              child: InkWell(
                onTap: () {
                  AppHelpers.navigationToPage(context, ChangePasswordScreen());
                },
                borderRadius: BorderRadius.circular(11),
                child: MyContainerShape(
                  borderRadius: 11,
                  height: 55.h,
                  bgContainer: AppColors.TRANSPARENT,
                  paddingHorizontal: 12,
                  enableShadow: false,
                  child: Row(
                    children: [
                      SvgPicture.asset(
                        'assets/images/ic_reset_password.svg',
                        width: 18.w,
                      ),
                      SizedBox(width: 10.w),
                      MyText(
                        title: AppLocalizations.of(context)!.changePassword,
                        fontSize: 14,
                      ),
                      const Spacer(),
                      Icon(
                        Icons.arrow_forward_ios,
                        size: 16.r,
                      )
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
