import 'package:easy_plus_customer/core/utils/app_colors.dart';
import 'package:easy_plus_customer/core/utils/app_helpers.dart';
import 'package:easy_plus_customer/core/widgets/item_radio.dart';
import 'package:easy_plus_customer/core/widgets/loading_widget.dart';
import 'package:easy_plus_customer/core/widgets/my_app_bar.dart';
import 'package:easy_plus_customer/core/widgets/my_contianer_shape.dart';
import 'package:easy_plus_customer/core/widgets/my_elevated_button.dart';
import 'package:easy_plus_customer/core/widgets/my_text.dart';
import 'package:easy_plus_customer/core/widgets/my_text_field.dart';
import 'package:easy_plus_customer/features/auth/model/user.dart';
import 'package:easy_plus_customer/features/side_bar/views/manager/my_account_cubit/my_account_cubit.dart';
import 'package:easy_plus_customer/features/side_bar/views/widgets/my_account/pick_image_user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_svg/svg.dart';

class MyAccountScreen extends StatefulWidget {
  MyAccountScreen({super.key});

  @override
  State<MyAccountScreen> createState() => _MyAccountScreenState();
}

class _MyAccountScreenState extends State<MyAccountScreen> {
  final _keyForm = GlobalKey<FormState>();

  final TextEditingController _datePickerController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _idNumberController = TextEditingController();

  @override
  void initState() {
    User? user = MyAccountCubit.get(context).userData;
    if (user != null) {
      if (user.gender == '') {
        MyAccountCubit.get(context).changeGenderUser(-1);
      } else {
        MyAccountCubit.get(context)
            .changeGenderUser(user.gender == 'male' ? 1 : 2);
      }
      if (user.idNumber != null) {
        _idNumberController.text =
            user.idNumber == '' ? "" : user.idNumber!.toString();
      }
      _datePickerController.text = user.birthDate ?? "";
      _usernameController.text = user.name ?? "";
      _phoneController.text = user.phone == '-1' ? "" : user.phone!;
    }
    super.initState();
  }

  @override
  void dispose() {
    _datePickerController.dispose();
    _usernameController.dispose();
    _phoneController.dispose();
    _idNumberController.dispose();
    super.dispose();
  }

  @override
  void deactivate() {
    MyAccountCubit.get(context).picked = false;

    super.deactivate();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.BG_SCAFOLLD,
      appBar: MyAppBar(
        elevation: 0,
        backgroundColor: AppColors.BASE_COLOR,
        title: AppLocalizations.of(context)!.profile,
        textColor: AppColors.WHITE,
      ),
      body: Column(
        children: [
          SizedBox(
            height: 171.h,
            child: Stack(
              children: [
                MyContainerShape(
                  height: 111.h,
                  width: double.infinity,
                  enableShadow: false,
                  bgContainer: AppColors.BASE_COLOR,
                  bottomEndRaduis: 32,
                  bottomStartRaduis: 32,
                ),
                const PickImageUser(),
              ],
            ),
          ),
          Expanded(
            child: Form(
              key: _keyForm,
              child: ListView(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                children: [
                  SizedBox(height: 40.h),
                  MyTextField(
                    controller: _usernameController,
                    textHint: AppLocalizations.of(context)!.username,
                    filledColor: true,
                    isBorder: true,
                    fillColor2: AppColors.WHITE,
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
                  SizedBox(height: 12.h),
                  MyTextField(
                    controller: _phoneController,
                    textHint: AppLocalizations.of(context)!.phoneNumber,
                    filledColor: true,
                    isBorder: true,
                    fillColor2: AppColors.WHITE,
                    prefixIcon: Padding(
                      padding: EdgeInsetsDirectional.only(start: 9.w, end: 5.w),
                      child: SvgPicture.asset(
                        'assets/images/ic_social/ic_call.svg',
                        width: 19.w,
                        height: 19.h,
                      ),
                    ),
                    validator: (String? s) {
                      if (s == null || s.isEmpty) {
                        return AppLocalizations.of(context)!
                            .pleaseEnterYourPhoneNumber;
                      }

                      return null;
                    },
                  ),
                  SizedBox(height: 12.h),
                  MyTextField(
                    controller: _idNumberController,
                    textHint: AppLocalizations.of(context)!.idNumber,
                    filledColor: true,
                    isBorder: true,
                    fillColor2: AppColors.WHITE,
                    prefixIcon: Padding(
                      padding: EdgeInsetsDirectional.only(start: 9.w, end: 5.w),
                      child: SvgPicture.asset(
                        'assets/images/ic_id_number.svg',
                        width: 19.w,
                        height: 19.h,
                      ),
                    ),
                  ),
                  SizedBox(height: 12.h),
                  MyTextField(
                    controller: _datePickerController,
                    textHint: AppLocalizations.of(context)!.dateOfBirth,
                    filledColor: true,
                    onTap: () async {
                      await _selectDate(context);
                    },
                    isBorder: true,
                    readOnly: true,
                    fillColor2: AppColors.WHITE,
                    prefixIcon: Padding(
                      padding: EdgeInsetsDirectional.only(start: 9.w, end: 5.w),
                      child: SvgPicture.asset(
                        'assets/images/ic_calender.svg',
                        width: 19.w,
                        height: 19.h,
                      ),
                    ),
                  ),
                  SizedBox(height: 12.h),
                  BlocBuilder<MyAccountCubit, MyAccountState>(
                    builder: (context, state) {
                      int indexSelected =
                          MyAccountCubit.get(context).indexSelected;
                      return Row(
                        children: [
                          MyText(title: AppLocalizations.of(context)!.gender),
                          SizedBox(width: 20.w),
                          ItemRadio(
                            title: AppLocalizations.of(context)!.male,
                            onChanged: (int? selected) {
                              if (selected != null) {
                                MyAccountCubit.get(context)
                                    .changeGenderUser(selected);
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
                                MyAccountCubit.get(context)
                                    .changeGenderUser(selected);
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
                ],
              ),
            ),
          ),
          BlocConsumer<MyAccountCubit, MyAccountState>(
            listener: (context, state) {
              if (state is UpdateUserSuccess) {
                AppHelpers.showSnackBar(context, message: state.message);
              }
              if (state is UpdateUserFailed) {
                AppHelpers.showSnackBar(
                  context,
                  message: state.message,
                  error: true,
                );
              }
            },
            builder: (context, state) {
              if (state is UpdateUserLoading) {
                return const LoadingWidget();
              }
              return Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: MyElevatedButton(
                  title: AppLocalizations.of(context)!.save,
                  onPressed: () async {
                    if (_keyForm.currentState!.validate()) {
                      await MyAccountCubit.get(context).updateUser(
                        context,
                        user: User(
                            name: _usernameController.text.trim(),
                            phone: _phoneController.text.trim(),
                            idNumber: _idNumberController.text.trim(),
                            birthDate: _datePickerController.text.trim(),
                            gender: MyAccountCubit.get(context).indexSelected ==
                                    -1
                                ? ''
                                : MyAccountCubit.get(context).indexSelected == 1
                                    ? "male"
                                    : "female",
                            image: MyAccountCubit.get(context).pathImage),
                      );
                    }
                  },
                  background: AppColors.TRANSPARENT,
                  borderColor: AppColors.GRAY3,
                  titleColor: AppColors.GRAY3,
                ),
              );
            },
          ),
          SizedBox(height: 40.h),
        ],
      ),
    );
  }

  DateTime selectedDate = DateTime.now();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate) {
      selectedDate = picked;
      String date = "${selectedDate.toLocal()}".split(' ')[0];
      _datePickerController.text = date;
    }
  }
}
