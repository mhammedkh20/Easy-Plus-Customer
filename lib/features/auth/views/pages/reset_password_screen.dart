import 'package:easy_plus_customer/core/utils/app_colors.dart';
import 'package:easy_plus_customer/core/utils/app_helpers.dart';
import 'package:easy_plus_customer/core/widgets/loading_widget.dart';
import 'package:easy_plus_customer/core/widgets/my_app_bar.dart';
import 'package:easy_plus_customer/core/widgets/my_contianer_shape.dart';
import 'package:easy_plus_customer/core/widgets/my_elevated_button.dart';
import 'package:easy_plus_customer/core/widgets/my_text.dart';
import 'package:easy_plus_customer/core/widgets/my_text_field.dart';
import 'package:easy_plus_customer/features/auth/views/manager/auth_cubit/auth_cubit.dart';
import 'package:easy_plus_customer/features/auth/views/pages/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_svg/svg.dart';

class ResetPasswordScreen extends StatelessWidget {
  final _keyForm = GlobalKey<FormState>();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final String phone;

  ResetPasswordScreen({super.key, required this.phone});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(),
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
                    'assets/images/ic_reset_pass.svg',
                  ),
                ),
                SizedBox(height: 43.h),
                Align(
                  alignment: AlignmentDirectional.centerStart,
                  child: MyText(
                    title: AppLocalizations.of(context)!.passwordReset,
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    height: 0,
                  ),
                ),
                SizedBox(height: 16.h),
                Align(
                  alignment: AlignmentDirectional.centerStart,
                  child: MyText(
                    title: AppLocalizations.of(context)!.descResetPass,
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: AppColors.GRAY2,
                    height: 1.4,
                  ),
                ),
                SizedBox(height: 30.h),
                MyTextField(
                  controller: _passwordController,
                  textHint: AppLocalizations.of(context)!.newPassword,
                  filledColor: true,
                  isBorder: true,
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
                          .pleaseEnterYourNewPassword;
                    }

                    return null;
                  },
                ),
                SizedBox(height: 16.h),
                MyTextField(
                  obscureText: true,
                  controller: _confirmPasswordController,
                  textHint: AppLocalizations.of(context)!.confirmPassword,
                  filledColor: true,
                  isBorder: true,
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
                          .pleaseEnterYourConfirmPassword;
                    }

                    if (s != _passwordController.text) {
                      return 'الرجاء من تشابه كلمتا السر';
                    }

                    return null;
                  },
                ),
                SizedBox(height: 43.h),
                BlocConsumer<AuthCubit, AuthState>(
                  listener: (context, state) {
                    if (state is ResetPasswordSuccess) {
                      AppHelpers.showSnackBar(context, message: state.message);
                      AppHelpers.navigationToPageAndExitAll(
                        context,
                        LoginScreen(),
                      );
                    }
                    if (state is ResetPasswordFailed) {
                      AppHelpers.showSnackBar(
                        context,
                        message: state.message,
                        error: true,
                      );
                    }
                  },
                  builder: (context, state) {
                    if (state is ResetPasswordLoading) {
                      return const LoadingWidget();
                    }
                    return MyElevatedButton(
                      title: AppLocalizations.of(context)!.send,
                      onPressed: () async {
                        if (_keyForm.currentState!.validate()) {
                          await AuthCubit.get(context).userResetPassword(
                            context,
                            phone: phone,
                            password: AppHelpers.getNumberEnglish(
                                _passwordController.text.trim()),
                            passwordConfirmation: AppHelpers.getNumberEnglish(
                                _passwordController.text.trim()),
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
