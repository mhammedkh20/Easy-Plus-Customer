import 'package:easy_plus_customer/core/utils/app_dialogs.dart';
import 'package:easy_plus_customer/core/widgets/my_contianer_shape.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:easy_plus_customer/core/utils/app_colors.dart';
import 'package:easy_plus_customer/core/widgets/my_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class DataUserWidget extends StatelessWidget {
  const DataUserWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return PositionedDirectional(
      bottom: 0,
      start: 0,
      end: 0,
      child: GestureDetector(
        onTap: () {
          // AppDialogs.showDidYouDeliverDialog(
          //   context,
          //   onPressedNo: () {
          //     Navigator.pop(context);
          //   },
          //   onPressedYes: () {
          //     Navigator.pop(context);
          //   },
          // );

          AppDialogs.showEvaluationDialog(context);
        },
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: 16.w,
            vertical: 20.h,
          ),
          decoration: BoxDecoration(
            color: AppColors.WHITE,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(34.r),
              topRight: Radius.circular(34.r),
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.asset(
                    'assets/images/ic_user4.png',
                    width: 54.r,
                    height: 54.r,
                    fit: BoxFit.cover,
                  ),
                  SizedBox(width: 12.w),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 3.h),
                        Row(
                          children: [
                            MyText(
                              title: 'عبدالله ابو القمبز',
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                            MyText(
                              title: '5.4',
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                            ),
                            SizedBox(width: 2.w),
                            const Icon(
                              Icons.star,
                              color: AppColors.ORANGE,
                            ),
                            const Spacer(),
                            MyText(
                              title:
                                  AppLocalizations.of(context)!.estimatedTime,
                            )
                          ],
                        ),
                        SizedBox(height: 10.h),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            MyText(
                              title: '9710565625872+',
                              fontSize: 12,
                              color: AppColors.GRAY3,
                              fontWeight: FontWeight.w400,
                            ),
                            MyText(
                              title: '10دقائق',
                              fontSize: 12,
                              color: AppColors.GRAY3,
                              fontWeight: FontWeight.w400,
                            ),
                          ],
                        ),
                        SizedBox(height: 10.h),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            MyContainerShape(
                              paddingHorizontal: 12,
                              paddingVertical: 4,
                              borderRadius: 30,
                              bgContainer: AppColors.BASE_COLOR,
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  SvgPicture.asset(
                                    'assets/images/ic_share.svg',
                                    width: 16.w,
                                  ),
                                  SizedBox(width: 4.w),
                                  MyText(
                                    title: AppLocalizations.of(context)!
                                        .shareMySite,
                                    fontSize: 16,
                                    color: AppColors.WHITE,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  )
                ],
              ),
              SizedBox(height: 20.h),
            ],
          ),
        ),
      ),
    );
  }
}
