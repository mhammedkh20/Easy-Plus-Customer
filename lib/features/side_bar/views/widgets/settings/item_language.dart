import 'package:easy_plus_customer/core/utils/app_colors.dart';
import 'package:easy_plus_customer/core/widgets/my_contianer_shape.dart';
import 'package:easy_plus_customer/core/widgets/my_text.dart';
import 'package:flutter/material.dart';

class ItemLanguage extends StatelessWidget {
  const ItemLanguage({
    super.key,
    required this.title,
    required this.isSelected,
    required this.onTap,
  });

  final Function()? onTap;
  final String title;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Material(
        color: isSelected ? AppColors.BASE_COLOR : AppColors.WHITE,
        borderRadius: BorderRadius.circular(50),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(50),
          child: MyContainerShape(
            borderRadius: 50,
            height: double.infinity,
            enableShadow: false,
            bgContainer: AppColors.TRANSPARENT,
            child: MyText(
              title: title,
              fontSize: 14,
              color: isSelected ? AppColors.WHITE : AppColors.BLACK,
            ),
          ),
        ),
      ),
    );
  }
}
