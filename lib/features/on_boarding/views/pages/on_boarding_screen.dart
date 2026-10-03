import 'package:easy_plus_customer/core/utils/app_colors.dart';
import 'package:easy_plus_customer/core/utils/app_helpers.dart';
import 'package:easy_plus_customer/core/widgets/my_text.dart';
import 'package:easy_plus_customer/core/widgets/preview_card_image.dart';
import 'package:easy_plus_customer/features/auth/views/pages/login_screen.dart';
import 'package:easy_plus_customer/features/main/views/manager/main_cubit/main_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OnBoardingScreen extends StatelessWidget {
  const OnBoardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () {
          AppHelpers.navigationReplacementToPage(context, LoginScreen());
        },
        child: MainCubit.get(context).appConfig != null
            ? PreviewCardImage(
                url: MainCubit.get(context).appConfig!.app!.splash!,
                errorImage: AssetImage('assets/images/bg_google_maps.png'),
                width: double.infinity,
                hieght: double.infinity,
                fit: BoxFit.fill,
              )

            // Image.network(
            //     MainCubit.get(context).appConfig!.app!.splash!,
            //     width: double.infinity,
            //     height: double.infinity,
            //     fit: BoxFit.fill,
            //   )
            : Stack(
                children: [
                  PositionedDirectional(
                    top: 0,
                    bottom: 0,
                    end: 0,
                    start: 0,
                    child: Image.asset(
                      'assets/images/bg_onboarding.jpeg',
                      fit: BoxFit.cover,
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: AlignmentDirectional.topCenter,
                        end: AlignmentDirectional.bottomCenter,
                        colors: [
                          AppColors.BLACK.withOpacity(0),
                          AppColors.BLACK.withOpacity(.2),
                          AppColors.BLACK.withOpacity(.8),
                        ],
                      ),
                    ),
                  ),
                  PositionedDirectional(
                    bottom: 33.h,
                    start: 16.w,
                    end: 50.w,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        MyText(
                          title: 'مرحبا بك 👋',
                          color: AppColors.WHITE,
                          fontSize: 40,
                          fontWeight: FontWeight.w400,
                          height: 0,
                        ),
                        SizedBox(height: 10.h),
                        MyText(
                          title: 'Easy Plus',
                          color: AppColors.YELLOW,
                          fontSize: 40,
                          height: 0,
                        ),
                        SizedBox(height: 18.h),
                        MyText(
                          color: AppColors.WHITE,
                          fontSize: 18,
                          fontWeight: FontWeight.w400,
                          title:
                              'هذا نص تجريبي لاختبار شكل و حجم النصوص و طريقة عرضها في هذا المكان\n ',
                        ),
                      ],
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
