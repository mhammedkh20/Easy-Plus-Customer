import 'package:easy_plus_customer/core/utils/app_colors.dart';
import 'package:easy_plus_customer/core/widgets/my_contianer_shape.dart';
import 'package:easy_plus_customer/core/widgets/preview_card_image.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:easy_plus_customer/core/widgets/my_text.dart';
import 'package:flutter/material.dart';

class MyIconMain extends StatelessWidget {
  const MyIconMain({
    super.key,
    required this.toggle,
    required this.alignment,
    required this.isSvg,
    required this.iconPath,
    required this.title,
    required this.onTap,
  });

  final bool toggle;
  final Alignment alignment;
  final bool isSvg;
  final String iconPath;
  final String title;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return AnimatedAlign(
      duration: toggle
          ? const Duration(milliseconds: 100)
          : const Duration(milliseconds: 50),
      alignment: alignment,
      curve: toggle ? Curves.easeIn : Curves.easeOut,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Material(
            color: AppColors.WHITE,
            borderRadius: BorderRadius.circular(40),
            child: InkWell(
              borderRadius: BorderRadius.circular(40),
              onTap: onTap,
              child: MyContainerShape(
                height: 57.r,
                width: 57.r,
                enableShadow: false,
                borderRadius: 50,
                paddingHorizontal: 0,
                bgContainer: AppColors.TRANSPARENT,
                paddingVertical: 0,
                // child: Image.network(
                //   iconPath,
                // )
                child: Stack(
                  children: [
                    PositionedDirectional(
                      top: 0,
                      bottom: 0,
                      start: 0,
                      end: 0,
                      child: PreviewCardImage(
                        errorImage:
                            AssetImage('assets/images/bg_google_maps.png'),
                        url: iconPath,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Container(
                        color: onTap != null
                            ? AppColors.TRANSPARENT
                            : AppColors.GRAY.withOpacity(.3)),
                  ],
                ),
              ),
            ),
          ),
          if (!toggle) ...[
            SizedBox(height: 5.h),
            SizedBox(
              width: 110.w,
              child: MyText(
                title: title,
                fontSize: 12,
                fontWeight: FontWeight.w500,
                textAlign: TextAlign.center,
              ),
            )
          ]
        ],
      ),
    );
  }
}
