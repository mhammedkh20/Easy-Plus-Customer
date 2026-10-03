import 'package:easy_plus_customer/core/utils/app_colors.dart';
import 'package:easy_plus_customer/core/utils/app_dialogs.dart';
import 'package:easy_plus_customer/core/utils/app_helpers.dart';
import 'package:easy_plus_customer/core/widgets/item_radio.dart';
import 'package:easy_plus_customer/core/widgets/loading_widget.dart';
import 'package:easy_plus_customer/core/widgets/my_contianer_shape.dart';
import 'package:easy_plus_customer/core/widgets/my_elevated_button.dart';
import 'package:easy_plus_customer/core/widgets/my_text.dart';
import 'package:easy_plus_customer/core/widgets/my_text_field.dart';
import 'package:easy_plus_customer/features/auth/views/manager/auth_cubit/auth_cubit.dart';
import 'package:easy_plus_customer/features/auth/views/pages/account_confirmation_screen.dart';
import 'package:easy_plus_customer/features/auth/views/widgets/agree_privacy_policy.dart';
import 'package:easy_plus_customer/features/auth/views/widgets/my_country_code_item.dart';
import 'package:easy_plus_customer/features/auth/views/widgets/select_social_widget.dart';
import 'package:easy_plus_customer/features/side_bar/views/manager/my_account_cubit/my_account_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_svg/svg.dart';

class RegisterScreen extends StatelessWidget {
  final _keyForm = GlobalKey<FormState>();

  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _otherController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: EdgeInsetsDirectional.symmetric(horizontal: 16.w),
        children: [
          SizedBox(height: 64.h),
          Align(
            child: MyContainerShape(
              width: 128.r,
              height: 128.r,
              borderRadius: 100,
              enableShadow: false,
              bgContainer: AppColors.WHITE2,
              paddingHorizontal: 28,
              paddingVertical: 28,
              child: SvgPicture.asset('assets/images/ic_rocket.svg'),
            ),
          ),
          SizedBox(height: 20.h),
          MyText(
            title: AppLocalizations.of(context)!.newAccount,
            fontSize: 20,
            textAlign: TextAlign.center,
            fontWeight: FontWeight.w700,
          ),
          SizedBox(height: 32.h),
          SelectSocialWidget(otherController: _otherController),
          SizedBox(height: 32.h),
          Form(
            key: _keyForm,
            child: Column(
              children: [
                MyTextField(
                  controller: _usernameController,
                  textHint: AppLocalizations.of(context)!.username,
                  filledColor: true,
                  isBorder: true,
                  colorBorder: AppColors.WHITE2,
                  prefixIcon: Padding(
                    padding: EdgeInsetsDirectional.only(start: 9.w, end: 5.w),
                    child: SvgPicture.asset(
                      'assets/images/ic_user.svg',
                      width: 19.w,
                      height: 19.h,
                    ),
                  ),
                  validator: (String? s) {
                    if (s == null || s.isEmpty) {
                      return AppLocalizations.of(context)!
                          .pleaseEnterYourUsername;
                    }

                    return null;
                  },
                ),
                SizedBox(height: 16.h),
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
                SizedBox(height: 16.h),
                MyTextField(
                  controller: _passwordController,
                  textHint: AppLocalizations.of(context)!.password,
                  filledColor: true,
                  obscureText: true,
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
                          .pleaseEnterYourPassword;
                    }

                    return null;
                  },
                ),
              ],
            ),
          ),
          SizedBox(height: 16.h),
          BlocBuilder<MyAccountCubit, MyAccountState>(
            builder: (context, state) {
              int indexSelected = MyAccountCubit.get(context).indexSelected;
              return Row(
                children: [
                  MyText(
                    title: AppLocalizations.of(context)!.gender,
                    fontSize: 14,
                  ),
                  SizedBox(width: 20.w),
                  ItemRadio(
                    title: AppLocalizations.of(context)!.male,
                    onChanged: (int? selected) {
                      if (selected != null) {
                        MyAccountCubit.get(context).changeGenderUser(selected);
                      }
                    },
                    value: indexSelected,
                    fontSize: 16,
                    indexKey: 1,
                  ),
                  SizedBox(width: 10.w),
                  ItemRadio(
                    title: AppLocalizations.of(context)!.female,
                    onChanged: (int? selected) {
                      if (selected != null) {
                        MyAccountCubit.get(context).changeGenderUser(selected);
                      }
                    },
                    value: indexSelected,
                    indexKey: 2,
                    fontSize: 16,
                  ),
                ],
              );
            },
          ),
          SizedBox(height: 16.h),
          const AgreePrivacyPolicy(),
          SizedBox(height: 32.h),
          BlocConsumer<AuthCubit, AuthState>(
            listener: (context, state) {
              if (state is RegisterSuccess) {
                AppHelpers.showSnackBar(context, message: state.message);

                AppHelpers.navigationToPage(
                  context,
                  AccountConfirmationScreen(
                      phone: _otherController.text.trim()),
                );
              }
              if (state is RegisterFailed) {
                AppHelpers.showSnackBar(
                  context,
                  message: state.message,
                  error: true,
                );
              }
            },
            builder: (context, state) {
              if (state is RegisterLoading) {
                return const LoadingWidget();
              }
              return MyElevatedButton(
                title: AppLocalizations.of(context)!.createAnAccount,
                onPressed: AuthCubit.get(context).isSelectedToAgree
                    ? () async {
                        if (_keyForm.currentState!.validate()) {
                          await AuthCubit.get(context).userRegister(context,
                              gender:
                                  MyAccountCubit.get(context).indexSelected == 1
                                      ? 'male'
                                      : MyAccountCubit.get(context)
                                                  .indexSelected ==
                                              2
                                          ? 'female'
                                          : 'male',
                              name: AppHelpers.getTextWithoutNum(
                                      _usernameController.text.trim())
                                  .replaceAll(RegExp(r'\d{3,}'), ''),
                              password: AppHelpers.getNumberEnglish(
                                  _passwordController.text.trim()),
                              other: AppHelpers.getNumberEnglish(
                                  _otherController.text.trim()));
                        }
                      }
                    : null,
              );
            },
          ),
          SizedBox(height: 12.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              MyText(
                title:
                    AppLocalizations.of(context)!.iAlreadyHaveAnAccountOnTheApp,
                color: AppColors.TEXT_LIGHT,
                fontSize: 14,
                fontWeight: FontWeight.w400,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: MyText(
                  title: AppLocalizations.of(context)!.logIn,
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
