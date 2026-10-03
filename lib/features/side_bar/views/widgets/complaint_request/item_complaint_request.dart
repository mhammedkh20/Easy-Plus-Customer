import 'package:easy_plus_customer/core/utils/app_colors.dart';
import 'package:easy_plus_customer/core/widgets/my_contianer_shape.dart';
import 'package:easy_plus_customer/core/widgets/my_text.dart';
import 'package:easy_plus_customer/features/side_bar/model/complaints.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ItemComplaintRequest extends StatelessWidget {
  const ItemComplaintRequest({
    super.key,
    required this.data,
  });

  final Complaints data;

  @override
  Widget build(BuildContext context) {
    return MyContainerShape(
      paddingHorizontal: 12,
      paddingVertical: 12,
      borderRadius: 11,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              SvgPicture.asset('assets/images/ic_signal.svg'),
              SizedBox(width: 8.w),
              MyText(
                title: data.id.toString(),
                fontSize: 16,
                fontWeight: FontWeight.w400,
              ),
              const Spacer(),
              MyContainerShape(
                paddingVertical: 2,
                width: 84.w,
                borderRadius: 30,
                bgContainer: data.status == null
                    ? AppColors.ORANGE.withOpacity(.1)
                    : data.status == 'pending'
                        ? AppColors.ORANGE.withOpacity(.1)
                        : AppColors.BASE_COLOR.withOpacity(.1),
                enableShadow: false,
                child: MyText(
                  title: data.status ?? 'pending',
                  color: data.status == null
                      ? AppColors.ORANGE
                      : data.status == 'pending'
                          ? AppColors.ORANGE
                          : AppColors.BASE_COLOR,
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                ),
              )
            ],
          ),
          SizedBox(height: 4.h),
          MyText(
            title: data.desc ?? "",
            fontSize: 14,
            textAlign: TextAlign.start,
            fontWeight: FontWeight.w400,
          ),
        ],
      ),
    );
  }
}
