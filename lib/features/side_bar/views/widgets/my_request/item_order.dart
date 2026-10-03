import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:easy_plus_customer/core/utils/app_colors.dart';
import 'package:easy_plus_customer/core/widgets/my_contianer_shape.dart';
import 'package:easy_plus_customer/core/widgets/my_text.dart';
import 'package:easy_plus_customer/features/side_bar/model/my_orders_response.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ItemOrder extends StatelessWidget {
  final Function()? onTap;
  final Data data;
  final int status;

  const ItemOrder({
    super.key,
    required this.onTap,
    required this.data,
    required this.status,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: MyContainerShape(
        paddingHorizontal: 12,
        paddingVertical: 12,
        marginBottom: 12,
        borderRadius: 11,
        blur: 5,
        child: Row(
          children: [
            MyContainerShape(
              height: 55.r,
              width: 55.r,
              borderRadius: 55,
              bgContainer: AppColors.GREEN_LIGHT,
              enableShadow: false,
              child: Image.network(
                data.category!.icon ?? '',
              ),
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: MyText(
                          title: data.category!.name ?? '',
                          fontSize: 14,
                          maxLines: 1,
                          textOverflow: true,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SvgPicture.asset(
                        'assets/images/ic_clock.svg',
                        width: 10.r,
                      ),
                      SizedBox(width: 4.w),
                      MyText(
                        title: data.createdAt ?? "",
                        fontSize: 10,
                        fontWeight: FontWeight.w400,
                        color: AppColors.GRAY3,
                      ),
                    ],
                  ),
                  if (status == 0) ...[
                    Row(
                      children: [
                        MyText(
                          title: data.offersCount.toString(),
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: AppColors.BLACK,
                        ),
                        SizedBox(width: 4.w),
                        MyText(
                          title: AppLocalizations.of(context)!.numberOfOffers,
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          color: AppColors.GRAY,
                        ),
                      ],
                    ),
                    SizedBox(height: 5.h),
                  ],
                  Row(
                    children: [
                      SvgPicture.asset(
                        'assets/images/ic_signal.svg',
                        width: 14.r,
                      ),
                      SizedBox(width: 4.w),
                      MyText(
                        title: data.id != null ? data.id.toString() : '',
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        color: AppColors.GRAY3,
                      ),
                      const Spacer(),
                      const Icon(Icons.arrow_forward),
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
