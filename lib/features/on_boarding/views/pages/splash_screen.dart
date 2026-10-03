import 'package:easy_plus_customer/core/utils/app_colors.dart';
import 'package:easy_plus_customer/core/utils/app_helpers.dart';
import 'package:easy_plus_customer/features/on_boarding/views/manager/onboarding_cubit/on_boarding_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    OnBoardingCubit.get(context).getMethods(context);
    return BlocConsumer<OnBoardingCubit, OnBoardingState>(
      listener: (context, state) {
        if (state is GetDataFailed) {
          OnBoardingCubit.get(context).checkLogin(context);

          AppHelpers.showSnackBar(
            context,
            message: state.message,
            error: true,
          );
        }
        if (state is GetDataSuccess) {
          OnBoardingCubit.get(context).checkLogin(context);
        }
      },
      builder: (context, state) {
        return Scaffold(
          backgroundColor: AppColors.WHITE,
          body: Center(
            child: SvgPicture.asset(
              'assets/images/ic_app.svg',
              width: 250.r,
              height: 250.r,
            ),
          ),
        );
      },
    );
  }
}
