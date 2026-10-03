import 'package:easy_plus_customer/features/on_boarding/model/response_login_method.dart';
import 'package:easy_plus_customer/features/on_boarding/views/manager/onboarding_cubit/on_boarding_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:easy_plus_customer/features/auth/views/manager/auth_cubit/auth_cubit.dart';
import 'package:easy_plus_customer/features/auth/views/widgets/icon_social.dart';
import 'package:flutter/material.dart';

class SelectSocialWidget extends StatelessWidget {
  const SelectSocialWidget({
    super.key,
    required TextEditingController otherController,
  }) : _otherController = otherController;

  final TextEditingController _otherController;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(
      builder: (context, state) {
        return OnBoardingCubit.get(context).methods == null
            ? SizedBox()
            : SizedBox(
                height: 90.h,
                child: Center(
                  child: ListView.builder(
                      padding: EdgeInsets.zero,
                      shrinkWrap: true,
                      itemCount:
                          OnBoardingCubit.get(context).methods!.data!.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        LoginMethod model =
                            OnBoardingCubit.get(context).methods!.data![index];
                        return Row(
                          children: [
                            IconSocial(
                              name: model.name ?? "",
                              icPath: model.icon!,
                              isSvg: false,
                              isSelected:
                                  AuthCubit.get(context).socialSelectedIndex ==
                                      index,
                              onTap: model.status!
                                  ? () {
                                      if (AuthCubit.get(context)
                                              .socialSelectedIndex !=
                                          index) {
                                        AuthCubit.get(context).socialSelected(
                                            index,
                                            changeType: true,
                                            type: model.name ?? "phone");
                                        _otherController.clear();
                                      }
                                    }
                                  : null,
                            ),
                            SizedBox(width: 20.w),
                          ],
                        );
                      }),
                ));
      },
    );
  }
}
