import 'package:custom_refresh_indicator/custom_refresh_indicator.dart';
import 'package:easy_plus_customer/core/utils/app_colors.dart';
import 'package:easy_plus_customer/core/utils/app_helpers.dart';
import 'package:easy_plus_customer/core/widgets/loading_widget.dart';
import 'package:easy_plus_customer/core/widgets/my_app_bar.dart';
import 'package:easy_plus_customer/features/main/model/notification_model.dart';
import 'package:easy_plus_customer/features/side_bar/views/manager/side_bar_cubit/side_bar_cubit.dart';
import 'package:easy_plus_customer/features/side_bar/views/widgets/notifications/item_notification.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:lottie/lottie.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  @override
  void initState() {
    if (SideBarCubit.get(context).listNotification.length == 0) {
      SideBarCubit.get(context).showNotifications(context);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.BG_SCAFOLLD,
      appBar: MyAppBar(
        backgroundColor: AppColors.BG_SCAFOLLD,
        title: AppLocalizations.of(context)!.notifications,
      ),
      body: BlocConsumer<SideBarCubit, SideBarState>(
        listener: (context, state) {
          if (state is NotificationsFailed) {
            AppHelpers.showSnackBar(context,
                message: state.message, error: true);
          }
        },
        builder: (context, state) {
          if (state is NotificationsLoading) {
            return LoadingWidget();
          }
          if (state is NotificationsFailed) {
            return LottieBuilder.asset(
              'assets/images/ic_json/faild.json',
              width: 300.w,
            );
          }

          if (SideBarCubit.get(context).listNotification.length == 0) {
            return Center(
              child: LottieBuilder.asset(
                'assets/images/ic_json/no_data.json',
                width: 300.w,
              ),
            );
          }
          List<NotificationModel> listNotifications =
              SideBarCubit.get(context).listNotification;
          return CustomRefreshIndicator(
            leadingScrollIndicatorVisible: true,
            trailingScrollIndicatorVisible: true,
            builder: AppHelpers.getIndecatorDelegate(),
            onRefresh: () async {
              SideBarCubit.get(context).showNotifications(context);
            },
            child: ListView.builder(
              padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 16.w),
              itemCount: listNotifications.length,
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    ItemNotification(
                      data: SideBarCubit.get(context).listNotification[index],
                    ),
                    SizedBox(height: 10.h),
                  ],
                );
              },
            ),
          );
        },
      ),
    );
  }
}
