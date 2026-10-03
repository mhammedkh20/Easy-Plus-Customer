import 'package:easy_plus_customer/core/utils/app_colors.dart';
import 'package:easy_plus_customer/core/widgets/my_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ReceiveOffersScreen extends StatelessWidget {
  final String titleScreen;
  const ReceiveOffersScreen({
    super.key,
    required this.titleScreen,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.BG_SCAFOLLD,
      appBar: MyAppBar(
        title: titleScreen,
        backgroundColor: AppColors.BG_SCAFOLLD,
      ),
      body: ListView.builder(
        itemCount: 4,
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
        itemBuilder: (context, index) {
          return Column(
            children: [
              // ItemOffersSubmitted(
              //   detailsCar: false,
              //   onPressedOfferAccepted: () {
              //     AppHelpers.navigationToPage(context, CheckoutView());
              //     // AppHelpers.navigationToPage(context, PayDetailsScreen());
              //   },
              //   onPressedOfferRejected: () {},
              //   data: Offers(),
              // ),
              SizedBox(height: 12.h),
            ],
          );
        },
      ),
    );
  }
}
