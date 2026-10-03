import 'package:easy_plus_customer/core/utils/app_colors.dart';
import 'package:easy_plus_customer/core/widgets/my_contianer_shape.dart';
import 'package:easy_plus_customer/core/widgets/my_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class IconNavigationRange extends StatelessWidget {
  const IconNavigationRange({
    super.key,
    required this.onTap,
    required this.title,
    required this.isSelected,
    this.width,
  });

  final double? width;
  final Function()? onTap;
  final String title;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return width == null
        ? Expanded(
            child: Material(
              borderRadius: BorderRadius.circular(11),
              color:
                  isSelected ? AppColors.ICON_SELECTED : AppColors.TRANSPARENT,
              child: InkWell(
                onTap: onTap,
                borderRadius: BorderRadius.circular(11),
                child: MyContainerShape(
                  height: 40.h,
                  enableShadow: false,
                  enableBorder: true,
                  borderRadius: 11,
                  colorBorder: AppColors.ICON_SELECTED,
                  bgContainer: AppColors.TRANSPARENT,
                  child: MyText(
                    title: title,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color:
                        isSelected ? AppColors.WHITE : AppColors.ICON_SELECTED,
                  ),
                ),
              ),
            ),
          )
        : Material(
            borderRadius: BorderRadius.circular(11),
            color: isSelected ? AppColors.ICON_SELECTED : AppColors.TRANSPARENT,
            child: InkWell(
              onTap: onTap,
              borderRadius: BorderRadius.circular(11),
              child: MyContainerShape(
                height: 40.h,
                width: width!.w,
                enableShadow: false,
                enableBorder: true,
                borderRadius: 11,
                colorBorder: AppColors.ICON_SELECTED,
                bgContainer: AppColors.TRANSPARENT,
                child: MyText(
                  title: title,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: isSelected ? AppColors.WHITE : AppColors.ICON_SELECTED,
                ),
              ),
            ),
          );
  }
}
