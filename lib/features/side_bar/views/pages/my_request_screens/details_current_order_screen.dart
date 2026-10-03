import 'package:easy_plus_customer/core/utils/app_colors.dart';
import 'package:easy_plus_customer/core/utils/app_helpers.dart';
import 'package:easy_plus_customer/core/widgets/loading_widget.dart';
import 'package:easy_plus_customer/core/widgets/my_app_bar.dart';
import 'package:easy_plus_customer/core/widgets/my_contianer_shape.dart';
import 'package:easy_plus_customer/features/side_bar/views/manager/my_request_cubit/my_request_cubit.dart';
import 'package:easy_plus_customer/features/side_bar/views/widgets/details_order/details_order_widget.dart';
import 'package:easy_plus_customer/features/side_bar/views/widgets/my_request/list_offer_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:lottie/lottie.dart';
import '../../widgets/my_request/item_tap.dart';

class DetailsCurrentOrderScreen extends StatefulWidget {
  final String orderId;

  const DetailsCurrentOrderScreen({
    super.key,
    required this.orderId,
  });

  @override
  State<DetailsCurrentOrderScreen> createState() =>
      _DetailsCurrentOrderScreenState();
}

class _DetailsCurrentOrderScreenState extends State<DetailsCurrentOrderScreen> {
  @override
  void initState() {
    print('state.orderId ${widget.orderId}');

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
      body: Padding(
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
            return Column(
              children: [
                SizedBox(height: 16.h),
                MyContainerShape(
                  bgContainer: AppColors.GREEN_LIGHT,
                  height: 65.h,
                  borderRadius: 70,
                  enableShadow: false,
                  paddingHorizontal: 12,
                  paddingVertical: 10,
                  child: BlocBuilder<MyRequestCubit, MyRequestState>(
                    builder: (context, state) {
                      int selected =
                          MyRequestCubit.get(context).indexOrderDetails;
                      return Row(
                        children: [
                          ItemTap(
                            selected: selected == 0,
                            title: AppLocalizations.of(context)!.orderDetails,
                            onTap: () {
                              MyRequestCubit.get(context).changeOrderDetails(0);
                            },
                          ),
                          ItemTap(
                            selected: selected == 1,
                            title:
                                AppLocalizations.of(context)!.offersSubmitted,
                            onTap: () {
                              MyRequestCubit.get(context).changeOrderDetails(1);
                            },
                          ),
                        ],
                      );
                    },
                  ),
                ),
                SizedBox(height: 16.h),
                Expanded(
                  child: BlocBuilder<MyRequestCubit, MyRequestState>(
                    builder: (context, state) {
                      return MyRequestCubit.get(context).indexOrderDetails == 0
                          ? const DetailsOrderWidget()
                          : ListOffers(
                              orderId: widget.orderId,
                              showTime: MyRequestCubit.get(context)
                                  .dataOrderDetails!
                                  .data!
                                  .showTime!,
                            );
                    },
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
