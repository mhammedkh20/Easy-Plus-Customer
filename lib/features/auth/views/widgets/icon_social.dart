import 'package:easy_plus_customer/core/utils/app_colors.dart';
import 'package:easy_plus_customer/core/widgets/my_contianer_shape.dart';
import 'package:easy_plus_customer/core/widgets/my_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class IconSocial extends StatelessWidget {
  final bool isSvg;
  final String name;
  final String icPath;
  final Function()? onTap;
  final bool isSelected;

  const IconSocial({
    required this.name,
    required this.icPath,
    required this.onTap,
    required this.isSelected,
    this.isSvg = false,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    print(icPath);
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Material(
          color: onTap != null
              ? isSelected
                  ? AppColors.ICON_SELECTED
                  : AppColors.WHITE2
              : AppColors.WHITE3,
          borderRadius: BorderRadius.circular(50.r),
          child: InkWell(
            onTap: onTap,
            borderRadius: BorderRadius.circular(50.r),
            child: MyContainerShape(
              width: 51.h,
              height: 51.h,
              paddingVertical: 0,
              bgContainer: AppColors.TRANSPARENT,
              enableShadow: false,
              borderRadius: 8,
              child: isSvg
                  ? Image.asset(
                      icPath,
                      width: 32.r,
                      height: 32.r,
                    )
                  : SvgPicture.network(
                      icPath,
                      width: 32.r,
                      height: 32.r,
                    ),
            ),
          ),
        ),
        SizedBox(height: 6.h),
        MyText(
          title: name,
          fontSize: 12,
          fontWeight: FontWeight.w500,
          color: AppColors.BLACK,
        ),
      ],
    );
  }
}
