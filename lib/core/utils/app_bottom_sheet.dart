import 'dart:io';

import 'package:easy_plus_customer/core/utils/app_helpers.dart';
import 'package:easy_plus_customer/core/widgets/custom_dropdown_menu.dart';
import 'package:easy_plus_customer/core/widgets/item_pay.dart';
import 'package:easy_plus_customer/core/widgets/my_contianer_shape.dart';
import 'package:easy_plus_customer/core/widgets/my_elevated_button.dart';
import 'package:easy_plus_customer/core/widgets/my_text.dart';
import 'package:easy_plus_customer/core/widgets/my_text_field.dart';
import 'package:easy_plus_customer/features/main/model/response_app_config.dart';
import 'package:easy_plus_customer/features/main/views/manager/main_cubit/main_cubit.dart';
import 'package:easy_plus_customer/features/side_bar/views/manager/side_bar_cubit/side_bar_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:easy_plus_customer/core/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppBottomSheet {
  static showChooseToAddBalance(
    BuildContext context, {
    Function()? onBankClick,
    Function()? onPaymentMethodClick,
    String? title,
    String? icon,
  }) {
    showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.WHITE,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(34.r),
        ),
      ),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      builder: (BuildContext context) {
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 26.w),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(height: 10.h),
              MyContainerShape(
                width: 60.w,
                height: 3.h,
                bgContainer: AppColors.GRAY,
              ),
              SizedBox(height: 30.h),
              Row(
                children: [
                  ItemPay(
                    icon: icon ?? 'assets/images/ic_wallet2.svg',
                    title: title ?? AppLocalizations.of(context)!.wallet,
                    fun: onBankClick,
                  ),
                  SizedBox(width: 20.w),
                  ItemPay(
                    icon: 'assets/images/payment-gateway.svg',
                    title: AppLocalizations.of(context)!.paymentGateway,
                    fun: onPaymentMethodClick,
                  ),
                ],
              ),
              SizedBox(height: 50.h),
            ],
          ),
        );
      },
    );
  }

  static showAddBalanceWithPaymentMethod(
    BuildContext context, {
    required double tax,
    required Function(double price, double paymentPrice) returnPrice,
  }) {
    double minBalance = double.parse(
        MainCubit.get(context).appConfig!.app!.minAddBalance ?? "0");
    double maxBalance = double.parse(
        MainCubit.get(context).appConfig!.app!.maxAddBalance ?? "0");
    TextEditingController balanceController = TextEditingController();
    showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.WHITE,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(34.r),
        ),
      ),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      builder: (BuildContext context) {
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 26.w),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(height: 10.h),
              MyContainerShape(
                width: 60.w,
                height: 3.h,
                bgContainer: AppColors.GRAY,
              ),
              SizedBox(height: 30.h),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  MyText(title: "${AppLocalizations.of(context)!.note} / "),
                  Expanded(
                    child: MyText(
                        title:
                            "${AppLocalizations.of(context)!.amountEnteredMustBeBetween} $minBalance ${AppLocalizations.of(context)!.and} $maxBalance"),
                  ), //
                ],
              ),
              SizedBox(height: 16.h),
              BlocBuilder<SideBarCubit, SideBarState>(
                builder: (context, state) {
                  double tax = double.parse(MainCubit.get(context)
                      .appConfig!
                      .app!
                      .paymentGatewayCommission!);
                  return MyTextField(
                    controller: balanceController,
                    labelText:
                        '${AppLocalizations.of(context)!.youWillGet}${SideBarCubit.get(context).totalTax}${AppLocalizations.of(context)!.shippingCommission}${tax.toInt()}%',
                    textHint: '',
                    fillColor2: AppColors.GRAY2.withOpacity(.05),
                    filledColor: true,
                    isBorder: true,
                    keyboardType: TextInputType.number,
                    onChange: (String s) {
                      SideBarCubit.get(context).changeTax(
                          tax,
                          s.length == 0
                              ? 0
                              : double.parse(balanceController.text));
                    },
                  );
                },
              ),
              SizedBox(height: 50.h),
              MyElevatedButton(
                title: AppLocalizations.of(context)!.confirm,
                onPressed: () {
                  double? currentBalance;
                  try {
                    if (balanceController.text.isNotEmpty) {
                      currentBalance = double.parse(
                          AppHelpers.getNumberEnglish(balanceController.text));
                    }
                  } catch (ex) {
                    currentBalance = null;
                  }
                  if (balanceController.text.trim().isNotEmpty &&
                      (currentBalance! >= minBalance &&
                          currentBalance <= maxBalance)) {
                    returnPrice(
                      double.parse(
                          AppHelpers.getNumberEnglish(balanceController.text)),
                      SideBarCubit.get(context).totalPayment,
                    );
                  }
                },
              ),
              SizedBox(height: MediaQuery.of(context).viewInsets.bottom),
              SizedBox(height: MediaQuery.of(context).padding.bottom + 20),
            ],
          ),
        );
      },
    );
  }

  static showAddBalanceWithBank(
    BuildContext context, {
    required Function(int id, String username, String imagePath) confirm,
  }) {
    CustomClass? bank;
    if (MainCubit.get(context).appConfig!.banks != null) {
      if (MainCubit.get(context).appConfig!.banks!.isNotEmpty) {
        bank = MainCubit.get(context).appConfig!.banks![0];
      }
    } else {
      bank = null;
    }

    TextEditingController usernameController = TextEditingController();
    TextEditingController ibanController = TextEditingController();
    TextEditingController numberController = TextEditingController();
    if (bank != null) {
      ibanController.text = bank.iban!;
    } else {
      ibanController.text = '';
    }
    numberController.text = bank != null ? bank.accountNumber! : '';
    showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.WHITE,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(34.r),
        ),
      ),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      builder: (BuildContext context) {
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 26.w),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(height: 10.h),
              MyContainerShape(
                width: 60.w,
                height: 3.h,
                bgContainer: AppColors.GRAY,
              ),
              // SizedBox(height: 30.h),
              // MyTextField(
              //   controller: usernameController,
              //   labelText: AppLocalizations.of(context)!.username,
              //   textHint: '',
              //   fillColor2: AppColors.GRAY2.withOpacity(.05),
              //   filledColor: true,
              //   isBorder: true,
              //   keyboardType: TextInputType.text,
              // ),
              SizedBox(height: 12.h),
              CustomDropdownMenu(
                listItems: MainCubit.get(context).appConfig!.banks!,
                onChanged: (CustomClass selected) {
                  bank = selected;
                  ibanController.text = selected.iban ?? "";
                  numberController.text = selected.accountNumber ?? "";
                },
                height: 48.h,
                isExpanded: true,
                alignment: AlignmentDirectional.centerStart,
              ),
              SizedBox(height: 12.h),

              MyTextField(
                controller: numberController,
                labelText: AppLocalizations.of(context)!.accountNumber,
                textHint: '',
                fillColor2: AppColors.GRAY2.withOpacity(.05),
                filledColor: true,
                isBorder: true,
                readOnly: true,
                keyboardType: TextInputType.text,
              ),
              SizedBox(height: 12.h),
              MyTextField(
                controller: ibanController,
                labelText: AppLocalizations.of(context)!.iban,
                textHint: '',
                fillColor2: AppColors.GRAY2.withOpacity(.05),
                filledColor: true,
                isBorder: true,
                readOnly: true,
                keyboardType: TextInputType.text,
              ),
              SizedBox(height: 12.h),
              BlocBuilder<SideBarCubit, SideBarState>(
                builder: (context, state) {
                  return MyContainerShape(
                    height: 48.h,
                    alignment: AlignmentDirectional.centerStart,
                    enableRadius: true,
                    enableBorder: true,
                    paddingVertical: 0,
                    enableShadow: false,
                    bgContainer: AppColors.TRANSPARENT,
                    borderRadius: 10.r,
                    child: SideBarCubit.get(context).pathImage != null
                        ? Padding(
                            padding: EdgeInsets.symmetric(horizontal: 20.w),
                            child: Row(
                              children: [
                                MyText(
                                  title: 'تم ارفاق صورة',
                                ),
                                SizedBox(width: 30.w),
                                Expanded(
                                  child: Image.file(
                                    File(SideBarCubit.get(context).pathImage!),
                                  ),
                                ),
                                IconButton(
                                  onPressed: () {
                                    SideBarCubit.get(context)
                                        .setBankImage(null);
                                  },
                                  icon: const Icon(
                                    Icons.delete,
                                    color: AppColors.RED,
                                  ),
                                ),
                              ],
                            ),
                          )
                        : InkWell(
                            onTap: () {
                              SideBarCubit.get(context).pickImageBank();
                            },
                            child:
                                Center(child: MyText(title: 'قم بإرفاق صورة')),
                          ),
                  );
                },
              ),
              SizedBox(height: 50.h),
              MyElevatedButton(
                title: AppLocalizations.of(context)!.confirm,
                onPressed: () {
                  if (bank != null &&
                      SideBarCubit.get(context).pathImage != null) {
                    confirm(bank!.id!, usernameController.text.trim(),
                        SideBarCubit.get(context).pathImage!);
                  }
                },
              ),
              SizedBox(height: MediaQuery.of(context).viewInsets.bottom),
              SizedBox(height: MediaQuery.of(context).padding.bottom + 20),
            ],
          ),
        );
      },
    );
  }
}
