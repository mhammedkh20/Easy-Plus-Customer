import 'package:dotted_dashed_line/dotted_dashed_line.dart';
import 'package:easy_plus_customer/core/utils/app_colors.dart';
import 'package:easy_plus_customer/core/widgets/my_contianer_shape.dart';
import 'package:easy_plus_customer/core/widgets/my_text.dart';
import 'package:easy_plus_customer/features/side_bar/model/order/order_response.dart';
import 'package:easy_plus_customer/features/side_bar/views/manager/my_request_cubit/my_request_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:geolocator/geolocator.dart';

class FromStartingAddressTo extends StatelessWidget {
  const FromStartingAddressTo({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    OrderResponse data = MyRequestCubit.get(context).dataOrderDetails!;
    return MyContainerShape(
      paddingHorizontal: 12,
      paddingVertical: 12,
      width: double.infinity,
      borderRadius: 11,
      child: Column(
        children: [
          Row(
            children: [
              Column(
                children: [
                  SvgPicture.asset(
                    'assets/images/ic_gps.svg',
                    color: AppColors.GRAY3,
                    width: 16.r,
                    height: 16.r,
                  ),
                  if (data.data!.endLat != null) ...[
                    const SizedBox(height: 3),
                    DottedDashedLine(
                      height: 46.h,
                      width: 0,
                      axis: Axis.vertical,
                    ),
                    const SizedBox(height: 3),
                    SvgPicture.asset(
                      'assets/images/ic_location.svg',
                      color: AppColors.GRAY3,
                      width: 16.r,
                      height: 16.r,
                    ),
                  ],
                ],
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    MyText(
                      title: AppLocalizations.of(context)!.startingAddress,
                      color: AppColors.GRAY3,
                    ),
                    SizedBox(height: 4.h),
                    data.data!.startAddress != null
                        ? MyText(
                            title: data.data!.startAddress ?? "",
                            color: AppColors.BLACK,
                            fontSize: 14,
                          )
                        : SizedBox(),
                    if (data.data!.endLat != null) ...[
                      SizedBox(height: 20.h),
                      MyText(
                        title: AppLocalizations.of(context)!.destinationAddress,
                        color: AppColors.GRAY3,
                      ),
                      SizedBox(height: 4.h),
                      data.data!.endAddress != null
                          ? MyText(
                              title: data.data!.endAddress ?? "",
                              color: AppColors.BLACK,
                              fontSize: 14,
                            )
                          : const SizedBox(),
                    ]
                  ],
                ),
              )
            ],
          ),
          if (data.data!.endAddress != null) ...[
            SizedBox(height: 20.h),
            Row(
              children: [
                MyText(
                  title: AppLocalizations.of(context)!.expectedDistance,
                  fontSize: 14,
                  color: AppColors.BLACK.withOpacity(.6),
                ),
                SizedBox(width: 20.w),
                MyText(
                  title: '${getDistanceInMeters(context).toString()} KM',
                  fontSize: 14,
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }

  int getDistanceInMeters(BuildContext context) {
    OrderResponse data = MyRequestCubit.get(context).dataOrderDetails!;

    double distance = Geolocator.distanceBetween(
      double.parse(data.data!.startLat!),
      double.parse(data.data!.startLng!),
      double.parse(data.data!.endLat!),
      double.parse(data.data!.endLng!),
    );

    return (distance + (distance * .16)) ~/ 1000;
  }
}
