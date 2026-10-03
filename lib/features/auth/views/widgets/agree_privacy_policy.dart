import 'package:easy_plus_customer/core/utils/app_colors.dart';
import 'package:easy_plus_customer/core/utils/app_helpers.dart';
import 'package:easy_plus_customer/core/widgets/my_contianer_shape.dart';
import 'package:easy_plus_customer/features/auth/views/manager/auth_cubit/auth_cubit.dart';
import 'package:easy_plus_customer/features/side_bar/views/pages/privacy_policy_screen.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter/src/widgets/framework.dart';

class AgreePrivacyPolicy extends StatelessWidget {
  const AgreePrivacyPolicy({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        BlocBuilder<AuthCubit, AuthState>(
          builder: (context, state) {
            return GestureDetector(
              onTap: () {
                AuthCubit.get(context).changeSelectedAgree();
              },
              child: MyContainerShape(
                height: 24,
                width: 24,
                colorBorder: AppColors.BLACK,
                enableBorder: true,
                borderRadius: 4,
                bgContainer: AuthCubit.get(context).isSelectedToAgree
                    ? AppColors.BLACK
                    : AppColors.WHITE,
                child: Icon(
                  Icons.check,
                  color: AppColors.WHITE,
                  size: 18.r,
                ),
              ),
            );
          },
        ),
        SizedBox(width: 12.w),
        Expanded(
          child: Text.rich(
            TextSpan(
              children: [
                TextSpan(
                  text: '${AppLocalizations.of(context)!.iAgreeToAll} ',
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontFamily: 'Montserrat',
                    fontSize: 12.sp,
                    color: AppColors.BLACK,
                  ),
                ),
                TextSpan(
                  recognizer: TapGestureRecognizer()
                    ..onTap = () => AppHelpers.navigationToPage(
                        context, PrivacyPolicyScreen()),
                  text: AppLocalizations.of(context)!.theTermsAndPrivacyPolicy,
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 12.sp,
                    color: AppColors.BASE_COLOR,
                    fontFamily: 'Montserrat',
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
