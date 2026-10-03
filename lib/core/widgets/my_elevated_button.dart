import 'package:easy_plus_customer/core/utils/app_colors.dart';
import 'package:easy_plus_customer/core/widgets/my_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// ignore: must_be_immutable
class MyElevatedButton extends StatelessWidget {
  String title;
  VoidCallback? onPressed;
  double fontSize;
  Color? titleColor;
  FontWeight fontWeight;
  Color borderColor;
  Color? background;
  double borderWidth;
  double height;
  double width;
  double borderRaduis;
  bool enabledBorder;
  double? elevation;
  IconData? iconPath;
  bool iconStart;

  MyElevatedButton({
    Key? key,
    required this.title,
    this.onPressed,
    this.fontSize = 17,
    this.titleColor = AppColors.WHITE,
    this.fontWeight = FontWeight.w500,
    this.borderColor = AppColors.TRANSPARENT,
    this.background,
    this.borderWidth = 1,
    this.height = 51,
    this.borderRaduis = 50,
    this.width = 176,
    this.enabledBorder = true,
    this.elevation,
    this.iconPath,
    this.iconStart = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: onPressed,
        style: ButtonStyle(
          minimumSize: MaterialStateProperty.all(Size(width.w, height.h)),
          shadowColor: MaterialStateProperty.resolveWith<Color?>(
              (states) => AppColors.TRANSPARENT),
          backgroundColor:
              MaterialStateProperty.resolveWith<Color?>((states) => background),
          elevation:
              MaterialStateProperty.resolveWith<double?>((states) => elevation),
          shape: MaterialStateProperty.resolveWith(
            (states) {
              if (states.contains(MaterialState.pressed)) {
                return RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(borderRaduis.r),
                  side: BorderSide(
                    color: AppColors.BASE_COLOR,
                    width: borderWidth,
                  ),
                );
              }
              if (states.contains(MaterialState.hovered)) {
                return RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(borderRaduis.r),
                  side: BorderSide(
                    color: AppColors.BASE_COLOR,
                    width: borderWidth,
                  ),
                );
              }
              return RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(borderRaduis.r),
                side: BorderSide(
                  color: borderColor,
                  width: borderWidth,
                ),
              );
            },
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (iconStart)
              if (iconPath != null) ...[
                Icon(
                  iconPath,
                  size: 26.r,
                ),
                SizedBox(width: 10.w),
              ],
            MyText(
              title: title,
              fontSize: fontSize,
              color: titleColor,
              fontWeight: fontWeight,
              textAlign: TextAlign.center,
            ),
            if (!iconStart)
              if (iconPath != null) ...[
                SizedBox(width: 10.w),
                Icon(
                  iconPath,
                  size: 26.r,
                ),
              ],
          ],
        ));
  }
}
