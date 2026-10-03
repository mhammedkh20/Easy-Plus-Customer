import 'package:easy_plus_customer/core/utils/app_colors.dart';
import 'package:easy_plus_customer/core/utils/app_dialogs.dart';
import 'package:easy_plus_customer/core/utils/app_helpers.dart';
import 'package:easy_plus_customer/core/widgets/loading_widget.dart';
import 'package:easy_plus_customer/core/widgets/my_app_bar.dart';
import 'package:easy_plus_customer/core/widgets/my_elevated_button.dart';
import 'package:easy_plus_customer/features/request_services/model/order_model.dart';
import 'package:easy_plus_customer/features/request_services/views/manager/service_cubit/service_cubit.dart';
import 'package:easy_plus_customer/features/side_bar/model/order/order_response.dart';
import 'package:easy_plus_customer/features/side_bar/views/manager/my_request_cubit/my_request_cubit.dart';
import 'package:easy_plus_customer/features/side_bar/views/pages/complaint_request/mack_complaint_screen.dart';
import 'package:easy_plus_customer/features/side_bar/views/pages/my_request_screens/details_current_order_screen.dart';
import 'package:easy_plus_customer/features/side_bar/views/widgets/details_order/from_starting_address_to_widget.dart';
import 'package:easy_plus_customer/features/side_bar/views/widgets/details_order/order_data_widget.dart';
import 'package:easy_plus_customer/features/side_bar/views/widgets/details_order/user_data_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:lottie/lottie.dart';

class DetailsEndedOrderScreen extends StatefulWidget {
  final String orderId;
  const DetailsEndedOrderScreen({
    super.key,
    required this.orderId,
  });

  @override
  State<DetailsEndedOrderScreen> createState() =>
      _DetailsEndedOrderScreenState();
}

class _DetailsEndedOrderScreenState extends State<DetailsEndedOrderScreen> {
  int? orderId;
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
        actions: [
          GestureDetector(
            onTap: () {
              if (orderId != null) {
                AppHelpers.navigationToPage(
                    context,
                    MackComplaintScreen(
                      orderId: orderId,
                    ));
              }
            },
            child: Icon(
              Icons.report_gmailerrorred,
              size: 24.r,
            ),
          ),
          SizedBox(width: 10.w),
        ],
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
              if (orderResponse.data != null) {
                orderId = orderResponse.data!.id;
              }

              return SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(height: 16.h),
                    const FromStartingAddressTo(),
                    SizedBox(height: 16.h),
                    OrderDataWidget(data: orderResponse),
                    if (orderResponse.data!.driver != null) ...[
                      SizedBox(height: 16.h),
                      UserDataWidget(data: orderResponse),
                      SizedBox(height: 16.h),
                    ],
                    SizedBox(height: 27.h),
                    BlocConsumer<ServiceCubit, ServiceState>(
                      listener: (context, state) {
                        if (state is SendOrderSuccess) {
                          AppHelpers.showSnackBar(context,
                              message: state.message);

                          AppHelpers.navigationReplacementToPage(
                            context,
                            DetailsCurrentOrderScreen(
                                orderId: state.orderId.toString()),
                          );

                          AppHelpers.showSnackBar(
                            context,
                            message: AppLocalizations.of(context)!
                                .waitingReceiveOffers,
                          );
                        }
                        if (state is SendOrderFailed) {
                          AppHelpers.showSnackBar(
                            context,
                            message: state.message,
                            error: true,
                          );
                        }
                      },
                      builder: (context, state) {
                        if (state is SendOrderLoading) {
                          return const LoadingWidget();
                        }
                        return MyElevatedButton(
                          title: AppLocalizations.of(context)!.reorder,
                          onPressed: () async {
                            OrderResponse orderResponse =
                                MyRequestCubit.get(context).dataOrderDetails!;

                            AppDialogs.showReorderDialog(context,
                                onPressedNo: () {
                              Navigator.pop(context);
                            }, onPressedYes: () async {
                              Navigator.pop(context);
                              await makeOrder(orderResponse);
                            });
                          },
                          fontWeight: FontWeight.bold,
                        );
                      },
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Future makeOrder(OrderResponse orderResponse) async {
    int? driverGenderId;
    String? gender;
    if (orderResponse.data!.driverGenderId == null ||
        orderResponse.data!.driverGenderId == 'null') {
      gender = orderResponse.data!.driverGender;
    } else {
      gender = orderResponse.data!.driverGenderId;
    }

    if (gender != null && gender.toLowerCase() == 'male' ||
        gender!.toLowerCase() == 'ذكر') {
      driverGenderId = 1;
    } else if (gender.toLowerCase() == 'female' ||
        gender.toLowerCase() == 'انثى') {
      driverGenderId = 2;
    } else if (gender.toLowerCase() == 'all' ||
        gender.toLowerCase() == 'الكل') {
      driverGenderId = 3;
    }
    print(orderResponse.data!.daysCount);

    switch (orderResponse.data!.categoryId!) {
      case 1:
        await ServiceCubit.get(context).sendOrder(
          context,
          order: OrderModel(
            categoryId: orderResponse.data!.categoryId!,
            startLng: double.parse(orderResponse.data!.startLng!),
            startLat: double.parse(orderResponse.data!.startLat!),
            endLat: orderResponse.data!.endLat == null
                ? null
                : double.parse(orderResponse.data!.endLat!),
            endLng: orderResponse.data!.endLng == null
                ? null
                : double.parse(orderResponse.data!.endLng!),
            orderTypeId: orderResponse.data!.orderTypeId,
            navRangeId: orderResponse.data!.navRangeId,
            desc: orderResponse.data!.desc,
            driverGenderId: driverGenderId,
            startDate: orderResponse.data!.startDate == null
                ? null
                : DateTime.parse(orderResponse.data!.startDate!),
            startAddress: orderResponse.data!.startAddress,
            duration: orderResponse.data!.duration,
            daysCount: orderResponse.data!.daysCount == null ||
                    orderResponse.data!.daysCount == 'null'
                ? '0'
                : orderResponse.data!.daysCount,
            endAddress: orderResponse.data!.endAddress,
            initilPrice: orderResponse.data!.initialPrice == null
                ? 0
                : num.parse(orderResponse.data!.initialPrice!),
          ),
        );
        break;
      case 2:
        await ServiceCubit.get(context).sendOrder(
          context,
          order: OrderModel(
            categoryId: orderResponse.data!.categoryId!,
            startLng: double.parse(orderResponse.data!.startLng!),
            startLat: double.parse(orderResponse.data!.startLat!),
            driverGenderId: driverGenderId,
            daysCount: orderResponse.data!.daysCount,
            revisionTypeId: orderResponse.data!.revisionTypeId!,
            startDate: orderResponse.data!.startDate == null
                ? null
                : DateTime.parse(orderResponse.data!.startDate!),
            desc: orderResponse.data!.desc,
            startAddress: orderResponse.data!.startAddress,
            reviewer: orderResponse.data!.reviewer,
            initilPrice: orderResponse.data!.initialPrice == null
                ? 0
                : num.parse(orderResponse.data!.initialPrice!),
          ),
        );
        break;
      case 3:
        await ServiceCubit.get(context).sendOrder(
          context,
          order: OrderModel(
            categoryId: orderResponse.data!.categoryId!,
            startLng: double.parse(orderResponse.data!.startLng!),
            startLat: double.parse(orderResponse.data!.startLat!),
            endLat: orderResponse.data!.endLat == null
                ? null
                : double.parse(orderResponse.data!.endLat!),
            endLng: orderResponse.data!.endLng == null
                ? null
                : double.parse(orderResponse.data!.endLng!),
            shoppingTypeId: orderResponse.data!.shoppingTypeId2 == null
                ? null
                : orderResponse.data!.shoppingTypeId2!,
            desc: orderResponse.data!.desc,
            endAddress: orderResponse.data!.endAddress,
            startAddress: orderResponse.data!.startAddress,
            initilPrice: orderResponse.data!.initialPrice == null
                ? 0
                : num.parse(orderResponse.data!.initialPrice!),
            shoppingDestination: orderResponse.data!.shoppingDestination,
            driverGenderId: driverGenderId,
            daysCount: ServiceCubit.get(context).numberOfHours.toString(),
            startDate: orderResponse.data!.startDate == null
                ? null
                : DateTime.parse(orderResponse.data!.startDate!),
          ),
        );
        break;
      case 4:
        String? tourTypeS;
        String? status = orderResponse.data!.tourTypeStatus;

        if (status != null && status.toLowerCase() == 'ترفيهية' ||
            status!.toLowerCase() == 'entertainment') {
          tourTypeS = 'entertainment';
        } else if (status.toLowerCase() == 'تدريبية' ||
            status.toLowerCase() == 'training') {
          tourTypeS = 'training';
        }
        await ServiceCubit.get(context).sendOrder(
          context,
          order: OrderModel(
            categoryId: orderResponse.data!.categoryId!,
            startLng: double.parse(orderResponse.data!.startLng!),
            startLat: double.parse(orderResponse.data!.startLat!),
            tourTypeId: orderResponse.data!.tourTypeId,
            tourType: tourTypeS,
            tourTime: orderResponse.data!.tourTime == null
                ? null
                : int.parse(orderResponse.data!.tourTime!),
            desc: orderResponse.data!.desc,
            duration: AppHelpers.getDuration(context),
            startAddress: orderResponse.data!.startAddress,
            initilPrice: orderResponse.data!.initialPrice == null
                ? 0
                : num.parse(orderResponse.data!.initialPrice!),
            driverGenderId: driverGenderId,
            startDate: orderResponse.data!.startDate == null
                ? null
                : orderResponse.data!.startDate!.isEmpty
                    ? null
                    : DateTime.parse(orderResponse.data!.startDate!),
          ),
        );

        break;
      case 5:
        int? pickType;
        if (orderResponse.data!.pickType == 'private' ||
            orderResponse.data!.pickType == 'خاص') {
          pickType = 1;
        } else if (orderResponse.data!.pickType == 'مشاركة مقاعد' ||
            orderResponse.data!.pickType == 'shared seats') {
          pickType = 2;
        }
        String? driverGender;
        String? genderDriver = orderResponse.data!.driverGender;
        if (genderDriver == null ||
            genderDriver == 'All' ||
            genderDriver == 'الكل') {
          driverGender = 'All';
        }

        if (genderDriver == null ||
            genderDriver == 'Female' ||
            genderDriver == 'انثى') {
          driverGender = 'Female';
        }
        if (genderDriver == null ||
            genderDriver == 'Male' ||
            genderDriver == 'ذكر') {
          driverGender = 'Male';
        }

        await ServiceCubit.get(context).sendOrder(
          context,
          order: OrderModel(
            categoryId: orderResponse.data!.categoryId!,
            startLng: double.parse(orderResponse.data!.startLng!),
            startLat: double.parse(orderResponse.data!.startLat!),
            endLat: orderResponse.data!.endLat == null
                ? null
                : double.parse(orderResponse.data!.endLat!),
            endLng: orderResponse.data!.endLng == null
                ? null
                : double.parse(orderResponse.data!.endLng!),
            navRangeId: orderResponse.data!.navRangeId,
            driverGender: driverGender,
            pickType: pickType,
            seatsNumber: orderResponse.data!.seatsNumber == null
                ? null
                : int.parse(orderResponse.data!.seatsNumber!),
            carTypeId: orderResponse.data!.carTypeId,
            mishwarTypeId: orderResponse.data!.mishwarTypeId,
            revisionType: orderResponse.data!.revisionTypeId,
            desc: orderResponse.data!.desc,
            duration: AppHelpers.getDuration(context),
            startAddress: orderResponse.data!.startAddress,
            startDate: orderResponse.data!.startDate == null
                ? DateTime(2000, 1, 1, 00, 00, 00)
                : DateTime.parse(orderResponse.data!.startDate!),
            reservationTypeId: orderResponse.data!.reservationTypeid!,
            endAddress: orderResponse.data!.endAddress,
            initilPrice: orderResponse.data!.initialPrice == null
                ? 0
                : num.parse(orderResponse.data!.initialPrice!),
          ),
        );
        break;
    }
  }
}
