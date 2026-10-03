import 'package:easy_plus_customer/core/utils/app_colors.dart';
import 'package:easy_plus_customer/core/widgets/my_contianer_shape.dart';
import 'package:easy_plus_customer/core/widgets/my_text.dart';
import 'package:easy_plus_customer/features/main/model/item_drawer_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ItemDrawer extends StatelessWidget {
  const ItemDrawer({
    super.key,
    required this.item,
    required this.onTap,
    this.color,
  });

  final ItemDrawerModel item;
  final Function()? onTap;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8.r),
      child: MyContainerShape(
        borderRadius: 8,
        paddingVertical: 4,
        bgContainer: AppColors.TRANSPARENT,
        enableShadow: false,
        child: Row(
          children: [
            SizedBox(
              width: 20.r,
              height: 20.r,
              child: SvgPicture.asset(
                item.iconPath,
                color: color,
                width: 20.r,
                height: 20.r,
              ),
            ),
            SizedBox(width: 16.w),
            Expanded(
              child: MyText(
                title: item.name,
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: AppColors.WHITE,
              ),
            )
          ],
        ),
      ),
    );
  }
}
