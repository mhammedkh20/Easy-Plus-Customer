import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:easy_plus_customer/core/utils/app_colors.dart';
import 'package:easy_plus_customer/core/widgets/my_contianer_shape.dart';
import 'package:flutter/material.dart';

class IconAppBar extends StatelessWidget {
  const IconAppBar({
    super.key,
    required this.onTap,
    required this.icon,
  });

  final Function()? onTap;
  final Widget? icon;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: AlignmentDirectional.centerEnd,
      child: Material(
        color: AppColors.WHITE,
        borderRadius: BorderRadius.circular(50),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(50),
          child: MyContainerShape(
            height: 44.r,
            width: 44.r,
            bgContainer: AppColors.TRANSPARENT,
            borderRadius: 50,
            child: icon,
          ),
        ),
      ),
    );
  }
}
