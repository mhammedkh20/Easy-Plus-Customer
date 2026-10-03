import 'package:custom_refresh_indicator/custom_refresh_indicator.dart';
import 'package:easy_plus_customer/core/utils/app_colors.dart';
import 'package:easy_plus_customer/core/utils/app_helpers.dart';
import 'package:easy_plus_customer/core/widgets/loading_widget.dart';
import 'package:easy_plus_customer/core/widgets/my_app_bar.dart';
import 'package:easy_plus_customer/features/side_bar/model/my_orders_response.dart';
import 'package:easy_plus_customer/features/side_bar/views/manager/my_request_cubit/my_request_cubit.dart';
import 'package:easy_plus_customer/features/side_bar/views/pages/my_request_screens/details_current_order_screen.dart';
import 'package:easy_plus_customer/features/side_bar/views/pages/my_request_screens/details_ended_order_screen.dart';
import 'package:easy_plus_customer/features/side_bar/views/pages/my_request_screens/details_progress_order_screen.dart';
import 'package:easy_plus_customer/features/side_bar/views/widgets/my_request/item_order.dart';
import 'package:easy_plus_customer/features/side_bar/views/widgets/my_request/tap_bar_my_request.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:lottie/lottie.dart';

class MyRequestScreen extends StatefulWidget {
  const MyRequestScreen({super.key});

  @override
  State<MyRequestScreen> createState() => _MyRequestScreenState();
}

class _MyRequestScreenState extends State<MyRequestScreen> {
  var _scrollController = ScrollController();

  @override
  void initState() {
    MyRequestCubit.get(context).getOrders(context);
    _scrollController.addListener(pagination);

    super.initState();
  }

  void pagination() async {
    if ((_scrollController.position.pixels ==
            _scrollController.position.maxScrollExtent) &&
        (MyRequestCubit.get(context).listOrder.length <
            MyRequestCubit.get(context).total)) {
      await MyRequestCubit.get(context)
          .getOrders(context, loadPagination: true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.BG_SCAFOLLD,
      appBar: MyAppBar(
        backgroundColor: AppColors.BG_SCAFOLLD,
        title: AppLocalizations.of(context)!.myRequests,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: Column(
          children: [
            SizedBox(height: 16.h),
            const TapBarMyRequests(),
            SizedBox(height: 16.h),
            Expanded(
              child: BlocConsumer<MyRequestCubit, MyRequestState>(
                listener: (context, state) {
                  if (state is MyOrderFailed) {
                    AppHelpers.showSnackBar(context,
                        message: state.message, error: true);
                  }
                },
                builder: (context, state) {
                  if (state is MyOrderLoading) {
                    return const LoadingWidget();
                  }
                  if (state is MyOrderFailed) {
                    return LottieBuilder.asset(
                      'assets/images/ic_json/faild.json',
                      width: 300.w,
                    );
                  }

                  if (MyRequestCubit.get(context).listOrder.length == 0) {
                    return Center(
                      child: LottieBuilder.asset(
                        'assets/images/ic_json/no_data.json',
                        width: 300.w,
                      ),
                    );
                  }
                  List<Data> listData = MyRequestCubit.get(context).listOrder;
                  return Column(
                    children: [
                      Expanded(
                        child: CustomRefreshIndicator(
                          leadingScrollIndicatorVisible: true,
                          trailingScrollIndicatorVisible: true,
                          builder: AppHelpers.getIndecatorDelegate(),
                          onRefresh: () async {
                            await MyRequestCubit.get(context)
                                .getOrders(context);
                          },
                          child: ListView.builder(
                            controller: _scrollController,
                            padding: EdgeInsets.zero,
                            physics: const AlwaysScrollableScrollPhysics(),
                            itemCount: listData.length,
                            itemBuilder: (context, index) {
                              return ItemOrder(
                                status: MyRequestCubit.get(context)
                                    .indexStatusMyRequest,
                                data: listData[index],
                                onTap: () {
                                  if (MyRequestCubit.get(context)
                                          .indexStatusMyRequest ==
                                      0) {
                                    AppHelpers.navigationToPage(
                                        context,
                                        DetailsCurrentOrderScreen(
                                          orderId:
                                              listData[index].id.toString(),
                                        ));
                                  }
                                  if (MyRequestCubit.get(context)
                                          .indexStatusMyRequest ==
                                      1) {
                                    AppHelpers.navigationToPage(
                                      context,
                                      DetailsProgressOrderScreen(
                                        orderId: listData[index].id.toString(),
                                      ),
                                    );
                                  }
                                  if (MyRequestCubit.get(context)
                                          .indexStatusMyRequest ==
                                      2) {
                                    AppHelpers.navigationToPage(
                                      context,
                                      DetailsEndedOrderScreen(
                                          orderId:
                                              listData[index].id.toString()),
                                    );
                                  }
                                },
                              );
                            },
                          ),
                        ),
                      ),
                      (state is MyOrderLoadingPagination)
                          ? const LoadingWidget()
                          : const SizedBox(),
                    ],
                  );
                },
              ),
            ),
            SizedBox(height: MediaQuery.of(context).padding.bottom),
          ],
        ),
      ),
    );
  }
}
