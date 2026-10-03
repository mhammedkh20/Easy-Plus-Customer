import 'dart:io';
import 'package:easy_plus_customer/core/utils/app_colors.dart';
import 'package:easy_plus_customer/core/utils/app_dialogs.dart';
import 'package:easy_plus_customer/core/utils/app_helpers.dart';
import 'package:easy_plus_customer/core/widgets/loading_widget.dart';
import 'package:easy_plus_customer/core/widgets/my_app_bar.dart';
import 'package:easy_plus_customer/core/widgets/my_elevated_button.dart';
import 'package:easy_plus_customer/features/main/views/manager/main_cubit/main_cubit.dart';
import 'package:easy_plus_customer/features/side_bar/model/order/order_response.dart';
import 'package:easy_plus_customer/features/side_bar/views/manager/my_request_cubit/my_request_cubit.dart';
import 'package:easy_plus_customer/features/side_bar/views/widgets/details_order/order_data_widget.dart';
import 'package:easy_plus_customer/features/side_bar/views/widgets/details_order/from_starting_address_to_widget.dart';
import 'package:easy_plus_customer/features/side_bar/views/widgets/details_order/user_data_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:lottie/lottie.dart';
import 'package:map_launcher/map_launcher.dart';

class DetailsProgressOrderScreen extends StatefulWidget {
  final String orderId;
  const DetailsProgressOrderScreen({
    super.key,
    required this.orderId,
  });

  @override
  State<DetailsProgressOrderScreen> createState() =>
      _DetailsProgressOrderScreenState();
}

class _DetailsProgressOrderScreenState
    extends State<DetailsProgressOrderScreen> {
  @override
  void initState() {
    MyRequestCubit.get(context).getOrderDetails(context, widget.orderId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.BG_SCAFOLLD,
      appBar: MyAppBar(
        backgroundColor: AppColors.BG_SCAFOLLD,
        title: AppLocalizations.of(context)!.orderDetails,
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: BlocConsumer<MyRequestCubit, MyRequestState>(
            listener: (context, state) {
              if (state is OrderDetailsFailed) {
                AppHelpers.showSnackBar(context,
                    message: state.message, error: true);
              }
            },
            builder: (context, state) {
              if (state is OrderDetailsLoading) {
                return LoadingWidget();
              }
              if (state is OrderDetailsFailed) {
                return Center(
                  child: LottieBuilder.asset(
                    'assets/images/ic_json/faild.json',
                    width: 300.w,
                  ),
                );
              }
              OrderResponse orderResponse =
                  MyRequestCubit.get(context).dataOrderDetails!;

              return SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(height: 16.h),
                    const FromStartingAddressTo(),
                    SizedBox(height: 16.h),
                    OrderDataWidget(data: orderResponse),
                    SizedBox(height: 16.h),
                    if (orderResponse.data!.driver != null) ...[
                      UserDataWidget(data: orderResponse),
                      SizedBox(height: 16.h),
                    ],
                    if (orderResponse.data!.startLat != null) ...[
                      SizedBox(height: 12.h),
                      MyElevatedButton(
                        title: AppLocalizations.of(context)!.driverTracking,
                        onPressed: () async {
                          final availableMaps = await MapLauncher.installedMaps;
                          print(
                              availableMaps); // [AvailableMap { mapName: Google Maps, mapType: google }, ...]
                          if (orderResponse.data!.endLat != null) {
                            print(orderResponse.data!.startLat! +
                                ',' +
                                orderResponse.data!.startLng!);
                            print(orderResponse.data!.endLat! +
                                ',' +
                                orderResponse.data!.endLng!);

                            availableMaps.first.showDirections(
                              destination: Coords(
                                double.parse(orderResponse.data!.startLat!),
                                double.parse(orderResponse.data!.startLng!),
                              ),
                              origin: Coords(
                                double.parse(orderResponse.data!.endLat!),
                                double.parse(orderResponse.data!.endLng!),
                              ),
                            );
                          } else {
                            MapLauncher.showMarker(
                                mapType: Platform.isAndroid
                                    ? MapType.google
                                    : MapType.apple,
                                coords: Coords(
                                  double.parse(orderResponse.data!.startLat!),
                                  double.parse(orderResponse.data!.startLng!),
                                ),
                                title: '');
                          }

                          // AppHelpers.navigationToPage(
                          //     context, TrackingScreen());
                        },
                        fontWeight: FontWeight.bold,
                      ),
                    ],
                    SizedBox(height: 35.h),
                    Row(
                      children: [
                        Expanded(
                          child: BlocConsumer<MyRequestCubit, MyRequestState>(
                            listener: (context, state) {
                              if (state is FinishOrderLoading) {
                                AppDialogs.showLoadingDialog(context);
                              }
                              if (state is FinishOrderSuccess) {
                                Navigator.pop(context);
                                if (state.isRateOrder) {
                                  Navigator.pop(context);
                                }
                                AppHelpers.showSnackBar(
                                  context,
                                  message: state.message,
                                );
                                if (!state.isRateOrder) {
                                  AppDialogs.showEvaluationDialog(
                                    context,
                                    onPressedIsDone: () async {
                                      Navigator.pop(context);
                                      await MyRequestCubit.get(context)
                                          .rateOrder(
                                        context,
                                        orderId: orderResponse.data!.id!,
                                        isRateOrder: true,
                                      );
                                    },
                                  );
                                }
                              }
                              if (state is FinishOrderFailed) {
                                Navigator.of(context).pop();
                                AppHelpers.showSnackBar(
                                  context,
                                  message: state.message,
                                  error: true,
                                );
                              }
                            },
                            builder: (context, state) {
                              return MyElevatedButton(
                                title: AppLocalizations.of(context)!.endTheTrip,
                                onPressed: () {
                                  AppDialogs.showDidYouDeliverDialog(
                                    context,
                                    onPressedNo: () {
                                      Navigator.of(context).pop();
                                    },
                                    onPressedYes: () async {
                                      Navigator.of(context).pop();
                                      await MyRequestCubit.get(context)
                                          .finishOrder(
                                        context,
                                        orderId: orderResponse.data!.id!,
                                      );
                                    },
                                  );
                                },
                                fontWeight: FontWeight.bold,
                              );
                            },
                          ),
                        ),
                        SizedBox(width: 16.w),
                        Expanded(
                          child: BlocConsumer<MyRequestCubit, MyRequestState>(
                            listener: (context, state) {
                              if (state is ChangeOfferStatusLoading) {
                                AppDialogs.showLoadingDialog(context);
                              }
                              if (state is ChangeOfferStatusSuccess) {
                                Navigator.of(context).pop();
                                AppHelpers.showSnackBar(
                                  context,
                                  message: state.message,
                                );
                                Navigator.pop(context);
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
                              return MyElevatedButton(
                                title: AppLocalizations.of(context)!
                                    .cancellingOrder,
                                background: AppColors.WHITE,
                                titleColor: AppColors.BLACK,
                                borderColor: AppColors.BLACK,
                                onPressed: () {
                                  int index = MainCubit.get(context)
                                      .appConfig!
                                      .categories!
                                      .indexWhere((element) =>
                                          element.id ==
                                          orderResponse.data!.categoryId);
                                  String cancellationUser =
                                      MainCubit.get(context)
                                              .appConfig!
                                              .categories![index]
                                              .cancellationUser ??
                                          '0';
                                  double tax = double.parse(cancellationUser);

                                  OrderResponse data =
                                      MyRequestCubit.get(context)
                                          .dataOrderDetails!;
                                  double price =
                                      double.parse(data.data!.initialPrice!);

                                  AppDialogs.showDeleteOrderDialog(
                                    context,
                                    price: price * tax / 100,
                                    onPressedNo: () {
                                      Navigator.of(context).pop();
                                    },
                                    onPressedYes: () async {
                                      Navigator.of(context).pop();
                                      await MyRequestCubit.get(context)
                                          .changeStatusOffer(
                                        context,
                                        operation: 2,
                                        offerId: orderResponse.data!.id!,
                                      );

                                      // Navigator.pop(context);
                                    },
                                  );
                                },
                              );
                            },
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
