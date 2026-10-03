import 'package:easy_plus_customer/core/utils/app_colors.dart';
import 'package:easy_plus_customer/core/widgets/my_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomText extends StatelessWidget {
  const CustomText({
    super.key,
    required this.text1,
    required this.text2,
    this.fontSize1 = 14,
    this.fontSize2 = 16,
    this.textColor1 = AppColors.GRAY3,
    this.textColor2 = AppColors.BLACK,
  });

  final String text1;
  final String text2;

  final double fontSize1;
  final double fontSize2;

  final Color textColor1;
  final Color textColor2;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsDirectional.only(bottom: 8.h, end: 20.w),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          MyText(
            title: text1,
            fontWeight: FontWeight.w500,
            color: textColor1,
            fontSize: fontSize1,
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: MyText(
              title: text2,
              fontWeight: textColor2 == AppColors.BASE_COLOR
                  ? FontWeight.w700
                  : FontWeight.w500,
              color: textColor2,
              fontSize: fontSize2,
              textAlign: TextAlign.center,
              textOverflow: true,
              maxLines: 2,
            ),
          ),
        ],
      ),
    );
  }
}
