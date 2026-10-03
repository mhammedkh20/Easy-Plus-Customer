import 'package:easy_plus_customer/core/utils/app_bottom_sheet.dart';
import 'package:easy_plus_customer/core/utils/app_dialogs.dart';
import 'package:easy_plus_customer/core/utils/app_helpers.dart';
import 'package:easy_plus_customer/features/main/views/manager/main_cubit/main_cubit.dart';
import 'package:easy_plus_customer/features/side_bar/views/manager/side_bar_cubit/side_bar_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:easy_plus_customer/core/utils/app_colors.dart';
import 'package:easy_plus_customer/core/widgets/my_contianer_shape.dart';
import 'package:easy_plus_customer/core/widgets/my_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ItemWallet extends StatelessWidget {
  const ItemWallet({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 212.h,
      width: double.infinity,
      child: Stack(
        children: [
          PositionedDirectional(
            top: 0,
            end: 0,
            bottom: 0,
            start: 0,
            child: SvgPicture.asset(
              'assets/images/bg_wallet.svg',
              fit: BoxFit.fill,
            ),
          ),
          PositionedDirectional(
            top: 40.h,
            end: 16.w,
            start: 16.w,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    MyText(
                      title: AppLocalizations.of(context)!.walletBalance,
                      fontSize: 15,
                      color: AppColors.WHITE,
                    ),
                    SizedBox(height: 10.h),
                    MyText(
                      title:
                          '${SideBarCubit.get(context).balnce}  ${SideBarCubit.get(context).currency}',
                      fontSize: 25,
                      fontWeight: FontWeight.w400,
                      color: AppColors.WHITE,
                    )
                  ],
                ),
                BlocConsumer<SideBarCubit, SideBarState>(
                  listener: (context, state) {
                    if (state is BalanceLoading) {
                      AppDialogs.showLoadingDialog(context);
                    }
                    if (state is BalanceFailed) {
                      Navigator.of(context).pop();
                      AppHelpers.showSnackBar(
                        context,
                        message: state.message,
                        error: true,
                      );
                    }

                    if (state is BalanceSuccess) {
                      Navigator.of(context).pop();
                      Navigator.of(context).pop();
                      Navigator.of(context).pop();
                      SideBarCubit.get(context).pathImage = null;
                      SideBarCubit.get(context).getTransactions(context);
                      AppHelpers.showSnackBar(
                        context,
                        message: state.message,
                      );
                    }
                  },
                  builder: (context, state) {
                    return MyContainerShape(
                      paddingVertical: 4,
                      paddingHorizontal: 12,
                      borderRadius: 30,
                      enableShadow: false,
                      bgContainer: AppColors.GREEN_LIGHT,
                      child: InkWell(
                        onTap: () {
                          AppBottomSheet.showChooseToAddBalance(
                            context,
                            icon: 'assets/images/ic_banck.svg',
                            title: AppLocalizations.of(context)!.bankTransfer,
                            onBankClick: () async {
                              AppBottomSheet.showAddBalanceWithBank(
                                context,
                                confirm: (id, username, imagePath) {
                                  SideBarCubit.get(context).requestBalance(
                                      context,
                                      image: imagePath,
                                      bankId: id);
                                },
                              );
                            },
                            onPaymentMethodClick: () {
                              double tax = double.parse(MainCubit.get(context)
                                  .appConfig!
                                  .app!
                                  .paymentGatewayCommission!);
                              AppBottomSheet.showAddBalanceWithPaymentMethod(
                                context,
                                tax: tax,
                                returnPrice:
                                    (double price, double paymentPrice) {
                                  AppHelpers.clickPayment(
                                    context,
                                    paymentPrice: paymentPrice,
                                    amount: price,
                                    minus: false,
                                  );
                                },
                              );
                            },
                          );
                        },
                        child: MyText(
                          title: AppLocalizations.of(context)!.addCredit,
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    );
                  },
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
