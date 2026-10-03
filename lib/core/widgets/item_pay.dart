import 'package:easy_plus_customer/core/utils/app_colors.dart';
import 'package:easy_plus_customer/core/widgets/my_contianer_shape.dart';
import 'package:easy_plus_customer/core/widgets/my_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class ItemPay extends StatelessWidget {
  final String icon;
  final String title;
  final Function()? fun;

  const ItemPay({
    super.key,
    this.fun,
    required this.icon,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Material(
        borderRadius: BorderRadius.circular(10.r),
        child: InkWell(
          borderRadius: BorderRadius.circular(10.r),
          onTap: fun,
          child: MyContainerShape(
            borderRadius: 10,
            paddingVertical: 15,
            bgContainer: AppColors.TRANSPARENT,
            enableShadow: false,
            child: Column(
              children: [
                SvgPicture.asset(
                  icon,
                  width: 60.r,
                  height: 60.r,
                  fit: BoxFit.cover,
                ),
                SizedBox(height: 10.h),
                MyText(
                  title: title,
                  fontSize: 18,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
