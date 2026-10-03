import 'package:easy_plus_customer/core/storage/pref/shared_pref_controller.dart';
import 'package:easy_plus_customer/core/utils/app_colors.dart';
import 'package:easy_plus_customer/core/utils/app_dialogs.dart';
import 'package:easy_plus_customer/core/utils/app_helpers.dart';
import 'package:easy_plus_customer/core/widgets/loading_widget.dart';
import 'package:easy_plus_customer/core/widgets/my_app_bar.dart';
import 'package:easy_plus_customer/core/widgets/my_contianer_shape.dart';
import 'package:easy_plus_customer/core/widgets/my_elevated_button.dart';
import 'package:easy_plus_customer/core/widgets/my_text.dart';
import 'package:easy_plus_customer/core/widgets/my_text_field.dart';
import 'package:easy_plus_customer/features/auth/views/manager/auth_cubit/auth_cubit.dart';
import 'package:easy_plus_customer/features/auth/views/widgets/select_social_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_svg/svg.dart';

import '../widgets/my_country_code_item.dart';
import 'forget_confirmation_screen.dart';

class ForgetPasswordScreen extends StatelessWidget {
  final _keyForm = GlobalKey<FormState>();
  final TextEditingController _otherController = TextEditingController();

  ForgetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    String? type = SharedPrefController().getTypeTextFeild;

    if (type != null) {
      AuthCubit.get(context).socialSelected(0, type: "phone");
    }
    return Scaffold(
      appBar: const MyAppBar(),
      body: Padding(
        padding: EdgeInsetsDirectional.symmetric(horizontal: 16.w),
        child: Form(
          key: _keyForm,
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: 8.h),
                MyContainerShape(
                  width: 128.r,
                  height: 128.r,
                  borderRadius: 100,
                  enableShadow: false,
                  bgContainer: AppColors.WHITE2,
                  paddingHorizontal: 20,
                  paddingVertical: 20,
                  child: SvgPicture.asset(
                    'assets/images/ic_forget_password.svg',
                  ),
                ),
                SizedBox(height: 43.h),
                Align(
                  alignment: AlignmentDirectional.centerStart,
                  child: MyText(
                    title: AppLocalizations.of(context)!.forgotYourPassword,
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    height: 0,
                  ),
                ),
                SizedBox(height: 16.h),
                Align(
                  alignment: AlignmentDirectional.centerStart,
                  child: MyText(
                    title: AppLocalizations.of(context)!.descSendCode,
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: AppColors.GRAY2,
                    height: 1.4,
                  ),
                ),
                SizedBox(height: 30.h),
                SelectSocialWidget(otherController: _otherController),
                SizedBox(height: 30.h),
                BlocBuilder<AuthCubit, AuthState>(
                  builder: (context, state) {
                    if (AuthCubit.get(context).type.contains('Email') ||
                        AuthCubit.get(context)
                            .type
                            .contains('البريد الإلكتروني')) {
                      return MyTextField(
                        controller: _otherController,
                        textHint: AppLocalizations.of(context)!.email,
                        filledColor: true,
                        isBorder: true,
                        colorBorder: AppColors.WHITE2,
                        prefixIcon: Padding(
                          padding:
                              EdgeInsetsDirectional.only(start: 9.w, end: 5.w),
                          child: SvgPicture.asset(
                            'assets/images/ic_social/ic_email.svg',
                            width: 19.w,
                            height: 19.h,
                            color: AppColors.ICON_COLOR,
                          ),
                        ),
                        validator: (String? s) {
                          if (s == null || s.isEmpty) {
                            return AppLocalizations.of(context)!
                                .pleaseEnterYourEmail;
                          }

                          return null;
                        },
                      );
                    }
                    return MyTextField(
                      controller: _otherController,
                      textHint: AppLocalizations.of(context)!.phoneNumber,
                      filledColor: true,
                      isBorder: true,
                      colorBorder: AppColors.WHITE2,
                      prefixIcon: Padding(
                        padding:
                            EdgeInsetsDirectional.only(start: 9.w, end: 5.w),
                        child: SvgPicture.asset(
                          'assets/images/ic_social/ic_call.svg',
                          width: 19.w,
                          height: 19.h,
                        ),
                      ),
                      suffixWidget: GestureDetector(
                        onTap: () {
                          AppDialogs.showCountryPicker(context);
                        },
                        child: BlocBuilder<AuthCubit, AuthState>(
                          builder: (context, state) {
                            return MyCountryCodeItem(
                              country:
                                  AuthCubit.get(context).selectedDialogCountry,
                            );
                          },
                        ),
                      ),
                      validator: (String? s) {
                        if (s == null || s.isEmpty) {
                          return AppLocalizations.of(context)!
                              .pleaseEnterYourPhoneNumber;
                        }

                        return null;
                      },
                    );
                  },
                ),
                SizedBox(height: 43.h),
                BlocConsumer<AuthCubit, AuthState>(
                  listener: (context, state) {
                    if (state is ForgetPasswordSuccess) {
                      AppHelpers.showSnackBar(context, message: state.message);

                      AppHelpers.navigationToPage(
                        context,
                        ForgetConfirmationScreen(
                          phone: _otherController.text.trim(),
                          phoneCode: AuthCubit.get(context)
                              .selectedDialogCountry
                              .phoneCode,
                        ),
                      );
                    }
                    if (state is ForgetPasswordFailed) {
                      AppHelpers.showSnackBar(
                        context,
                        message: state.message,
                        error: true,
                      );
                    }
                  },
                  builder: (context, state) {
                    if (state is ForgetPasswordLoading) {
                      return const LoadingWidget();
                    }
                    return MyElevatedButton(
                      title: AppLocalizations.of(context)!.send,
                      onPressed: () async {
                        if (_keyForm.currentState!.validate()) {
                          await AuthCubit.get(context).userForgetPassword(
                            context,
                            other: AppHelpers.getNumberEnglish(
                                _otherController.text.trim()),
                          );
                        }
                      },
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
