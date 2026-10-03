import 'package:easy_plus_customer/core/widgets/my_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class ItemSearch extends StatelessWidget {
  const ItemSearch({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          children: [
            SvgPicture.asset(
              'assets/images/ic_location.svg',
              width: 13.w,
            ),
            SizedBox(width: 8.w),
            Expanded(
              child: MyText(
                title: 'السعودية - المدينة المنورة - شارع الملك فهد',
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            )
          ],
        ),
        SizedBox(height: 14.h),
      ],
    );
  }
}
