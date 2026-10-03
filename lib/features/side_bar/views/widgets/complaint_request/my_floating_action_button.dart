import 'package:easy_plus_customer/core/utils/app_helpers.dart';
import 'package:easy_plus_customer/features/side_bar/views/pages/complaint_request/mack_complaint_screen.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:easy_plus_customer/core/utils/app_colors.dart';
import 'package:flutter/material.dart';

class MyFloatingActionButton extends StatelessWidget {
  const MyFloatingActionButton({super.key});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      backgroundColor: AppColors.BASE_COLOR,
      onPressed: () {
        AppHelpers.navigationToPage(context, MackComplaintScreen());
      },
      child: Icon(
        Icons.add,
        color: AppColors.WHITE,
        size: 34.r,
      ),
    );
  }
}
