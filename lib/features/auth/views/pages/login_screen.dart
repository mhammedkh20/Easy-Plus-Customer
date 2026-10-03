import 'package:easy_plus_customer/core/storage/pref/shared_pref_controller.dart';
import 'package:easy_plus_customer/core/utils/app_colors.dart';
import 'package:easy_plus_customer/core/utils/app_dialogs.dart';
import 'package:easy_plus_customer/core/utils/app_helpers.dart';
import 'package:easy_plus_customer/core/widgets/my_elevated_button.dart';
import 'package:easy_plus_customer/core/widgets/my_text.dart';
import 'package:easy_plus_customer/core/widgets/my_text_field.dart';
import 'package:easy_plus_customer/features/auth/views/manager/auth_cubit/auth_cubit.dart';
import 'package:easy_plus_customer/features/auth/views/pages/account_confirmation_screen.dart';
import 'package:easy_plus_customer/features/auth/views/pages/forget_password_screen.dart';
import 'package:easy_plus_customer/features/auth/views/pages/register_screen.dart';
import 'package:easy_plus_customer/features/auth/views/widgets/my_country_code_item.dart';
import 'package:easy_plus_customer/features/auth/views/widgets/select_social_widget.dart';
import 'package:easy_plus_customer/features/main/views/pages/main_screen.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_svg/svg.dart';
import '../../../../core/widgets/loading_widget.dart';

class LoginScreen extends StatelessWidget {
  final _keyForm = GlobalKey<FormState>();

  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _otherController = TextEditingController();

  LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    String? type = SharedPrefController().getTypeTextFeild;
    if (type != null) {
      AuthCubit.get(context)
          .socialSelected(type == 'email' ? 2 : 0, type: "phone");
    }
    return Scaffold(
      body: Padding(
        padding: EdgeInsetsDirectional.symmetric(horizontal: 16.w),
        child: Form(
          key: _keyForm,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 84.h,
                  width: double.infinity,
                ),
                MyText(
                  title: AppLocalizations.of(context)!.welcomeBack,
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  height: 0,
                ),
                SizedBox(height: 10.h),
                MyText(
                  title: AppLocalizations.of(context)!.logInNow,
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
                SizedBox(height: 64.h),
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
                      keyboardType: TextInputType.number,
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
                SizedBox(height: 16.h),
                MyTextField(
                  controller: _passwordController,
                  textHint: AppLocalizations.of(context)!.password,
                  filledColor: true,
                  isBorder: true,
                  obscureText: true,
                  maxLines: 1,
                  colorBorder: AppColors.WHITE2,
                  prefixIcon: Padding(
                    padding: EdgeInsetsDirectional.only(start: 9.w, end: 5.w),
                    child: SvgPicture.asset(
                      'assets/images/ic_lock.svg',
                      width: 19.w,
                      height: 19.h,
                    ),
                  ),
                  validator: (String? s) {
                    if (s == null || s.isEmpty) {
                      return AppLocalizations.of(context)!
                          .pleaseEnterYourPassword;
                    }

                    return null;
                  },
                ),
                SizedBox(height: 16.h),
                Align(
                  alignment: AlignmentDirectional.centerEnd,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      GestureDetector(
                        onTap: () {
                          AppHelpers.navigationToPage(
                              context, ForgetPasswordScreen());
                        },
                        child: MyText(
                          title:
                              AppLocalizations.of(context)!.forgotYourPassword,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(width: 12.w),
                    ],
                  ),
                ),
                SizedBox(height: 64.h),
                BlocConsumer<AuthCubit, AuthState>(
                  listener: (context, state) {
                    if (state is LoginSuccess) {
                      if (AuthCubit.get(context).user!.status == '1') {
                        AppHelpers.showSnackBar(context,
                            message: state.message);
                        AppHelpers.navigationToPageAndExitAll(
                            context, const MainScreen());
                      } else {
                        AppDialogs.showBlockFromAdminDialog(context,
                            onPressedOk: () {
                          Navigator.of(context).pop();
                        });
                      }
                    }
                    if (state is LoginFailed) {
                      AppHelpers.showSnackBar(
                        context,
                        message: state.message,
                        error: true,
                      );
                      if (state.unauthorized) {
                        AppHelpers.navigationToPage(
                          context,
                          AccountConfirmationScreen(
                              phone: _otherController.text.trim()),
                        );
                      }
                    }
                  },
                  builder: (context, state) {
                    if (state is LoginLoading) {
                      return const LoadingWidget();
                    }
                    return MyElevatedButton(
                      title: AppLocalizations.of(context)!.logIn,
                      onPressed: () async {
                        if (_keyForm.currentState!.validate()) {
                          await AuthCubit.get(context).userLogin(
                            context,
                            other: AppHelpers.getNumberEnglish(
                                _otherController.text.trim()),
                            password: AppHelpers.getNumberEnglish(
                                _passwordController.text.trim()),
                          );
                        }
                      },
                    );
                  },
                ),
                SizedBox(height: 12.h),
                RichText(
                  text: TextSpan(
                    text: AppLocalizations.of(context)!
                        .iDoNotHaveAnAccountInTheApplication,
                    style: TextStyle(
                      color: AppColors.TEXT_LIGHT,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w400,
                      fontFamily: 'ubuntu',
                    ),
                    children: <TextSpan>[
                      TextSpan(
                        text: AppLocalizations.of(context)!.createAnAccount,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14.sp,
                          height: 1.4,
                          fontFamily: 'ubuntu',
                          color: AppColors.BLACK,
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            AppHelpers.navigationToPage(
                                context, RegisterScreen());
                          },
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
