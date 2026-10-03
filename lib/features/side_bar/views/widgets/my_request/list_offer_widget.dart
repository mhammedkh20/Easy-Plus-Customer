import 'package:flutter_gen/gen_l10n/app_localizations.dart';
// ignore_for_file: use_build_context_synchronously
import 'package:easy_plus_customer/core/utils/app_bottom_sheet.dart';
import 'package:easy_plus_customer/features/side_bar/views/manager/side_bar_cubit/side_bar_cubit.dart';
import 'package:custom_refresh_indicator/custom_refresh_indicator.dart';
import 'package:easy_plus_customer/core/utils/app_dialogs.dart';
import 'package:easy_plus_customer/core/utils/app_helpers.dart';
import 'package:easy_plus_customer/core/widgets/my_text.dart';
import 'package:easy_plus_customer/features/side_bar/model/order/offer.dart';
import 'package:easy_plus_customer/features/side_bar/views/manager/my_request_cubit/my_request_cubit.dart';
import 'package:easy_plus_customer/features/side_bar/views/widgets/details_order/item_offers_submitted.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';

class ListOffers extends StatelessWidget {
  final String orderId;
  final String showTime;

  const ListOffers({
    super.key,
    required this.orderId,
    required this.showTime,
  });

  @override
  Widget build(BuildContext context) {
    List<Offers> listOffers =
        MyRequestCubit.get(context).dataOrderDetails!.data!.offers ?? [];

    return BlocConsumer<SideBarCubit, SideBarState>(
      listener: (context, state) async {
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
          MyRequestCubit.get(context).clearData(withEmit: false);
          MyRequestCubit.get(context).changeStatusMyRequest(1);
          MyRequestCubit.get(context).getOrders(context);
          AppHelpers.showSnackBar(
            context,
            message: state.message,
          );
        }

        if (state is WalletLoading) {
          AppDialogs.showLoadingDialog(context);
        }
        if (state is WalletSuccess) {
          String price = MyRequestCubit.get(context)
              .dataOrderDetails!
              .data!
              .offers![state.index!]
              .price!;
          String newPrice = '';
          for (int i = 0; i < price.length; i++) {
            if (_isNumeric(price[i])) {
              newPrice += price[i];
            } else {
              break;
            }
          }
          Navigator.of(context).pop();
          if (double.parse(SideBarCubit.get(context).balnce) >=
              double.parse(newPrice)) {
            SideBarCubit.get(context).addBalance(context,
                amount: double.parse(newPrice) * -1, id: state.id);
            MyRequestCubit.get(context)
                .changeStatusOffer(context, operation: 0, offerId: state.id!);
          } else {
            AppHelpers.showSnackBar(context,
                message:
                    AppLocalizations.of(context)!.yourCurrentBalanceNotEnough,
                error: true);
          }
        }
        if (state is WalletFailed) {
          Navigator.of(context).pop();
          AppHelpers.showSnackBar(
            context,
            message: state.message,
            error: true,
          );
        }
      },
      builder: (context, state) {
        return BlocConsumer<MyRequestCubit, MyRequestState>(
          listener: (context, state) {
            if (state is ChangeOfferStatusLoading) {
              AppDialogs.showLoadingDialog(context);
            }
            if (state is ChangeOfferStatusSuccess) {
              Navigator.of(context).pop();
              if (state.orderAccepted) {
                Navigator.pop(context);
                MyRequestCubit.get(context).clearData(withEmit: false);
                MyRequestCubit.get(context).changeStatusMyRequest(1);
                MyRequestCubit.get(context).getOrders(context);
              }
              AppHelpers.showSnackBar(
                context,
                message: state.message,
              );
            }
            if (state is ChangeOfferStatusFailed) {
              Navigator.of(context).pop();
              AppHelpers.showSnackBar(
                context,
                message: state.message,
                error: true,
              );
            }
          },
          builder: (context, state) {
            return CustomRefreshIndicator(
              leadingScrollIndicatorVisible: false,
              trailingScrollIndicatorVisible: false,
              builder: AppHelpers.getIndecatorDelegate(),
              onRefresh: () async {
                await MyRequestCubit.get(context)
                    .getOrderDetails(context, orderId);
              },
              child: listOffers.length == 0
                  ? ListView(
                      children: [
                        Column(
                          children: [
                            SizedBox(height: 100.h),
                            LottieBuilder.asset(
                              'assets/images/ic_json/offers.json',
                              width: 200.w,
                            ),
                            MyText(
                                title: AppLocalizations.of(context)!.noOffers),
                          ],
                        ),
                      ],
                    )
                  : ListView.builder(
                      itemCount: listOffers.length,
                      itemBuilder: (context, index) {
                        return Column(
                          children: [
                            ItemOffersSubmitted(
                              data: listOffers[index],
                              showTime: showTime,
                              onPressedOfferAccepted: () async {
                                if (listOffers[index].isCash != null) {
                                  bool isCash = listOffers[index].isCash == '1'
                                      ? true
                                      : false;

                                  if (isCash) {
                                    AppDialogs.showChoosePaymentMethodDialog(
                                      context,
                                      onPressedNo: () {
                                        Navigator.of(context).pop();
                                      },
                                      onPressedYes: () {
                                        MyRequestCubit.get(context)
                                            .changeStatusOffer(context,
                                                operation: 0,
                                                offerId: listOffers[index].id!);
                                        Navigator.of(context).pop();
                                      },
                                    );
                                  } else {
                                    AppBottomSheet.showChooseToAddBalance(
                                      context,
                                      onBankClick: () async {
                                        SideBarCubit.get(context)
                                            .getTransactions(context,
                                                index: index,
                                                id: listOffers[index].id);
                                        Navigator.pop(context);
                                      },
                                      onPaymentMethodClick: () async {
                                        String price =
                                            MyRequestCubit.get(context)
                                                .dataOrderDetails!
                                                .data!
                                                .offers![index]
                                                .price!;
                                        String newPrice = '';
                                        for (int i = 0; i < price.length; i++) {
                                          if (_isNumeric(price[i])) {
                                            newPrice += price[i];
                                          } else {
                                            break;
                                          }
                                        }
                                        AppHelpers.clickPayment(
                                          context,
                                          offerId: listOffers[index].id!,
                                          amount: double.parse(newPrice),
                                          minus: true,
                                        );
                                        Navigator.pop(context);
                                      },
                                    );
                                  }
                                }
                              },
                              onPressedOfferRejected: () async {
                                await MyRequestCubit.get(context)
                                    .changeStatusOffer(context,
                                        operation: 1,
                                        offerId: listOffers[index].id!);
                              },
                            ),
                            SizedBox(height: 12.h),
                          ],
                        );
                      },
                    ),
            );
          },
        );
      },
    );
  }

  bool _isNumeric(String? str) {
    if (str == null) {
      return false;
    }
    return double.tryParse(str) != null;
  }
}
