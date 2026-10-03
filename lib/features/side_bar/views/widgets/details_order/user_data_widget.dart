import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:easy_plus_customer/core/widgets/my_page_view.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:easy_plus_customer/core/utils/app_colors.dart';
import 'package:easy_plus_customer/core/widgets/my_contianer_shape.dart';
import 'package:easy_plus_customer/core/widgets/my_text.dart';
import 'package:easy_plus_customer/features/side_bar/model/order/order_response.dart';
import 'package:easy_plus_customer/features/side_bar/views/widgets/details_order/custom_text.dart';
import 'package:flutter/material.dart';

class UserDataWidget extends StatelessWidget {
  final OrderResponse data;
  const UserDataWidget({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    List<String> images = [];
    if (data.data!.driver != null) {
      if (data.data!.driver!.carImages!.length > 0) {
        for (int i = 0; i < data.data!.driver!.carImages!.length; i++) {
          images.add(data.data!.driver!.carImages![i].image!);
        }
      }
    }
    return data.data!.driver == null
        ? SizedBox()
        : MyContainerShape(
            paddingHorizontal: 12,
            paddingVertical: 12,
            borderRadius: 11,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    MyContainerShape(
                      borderRadius: 30,
                      child: data.data!.driver!.image != null
                          ? Image.network(
                              data.data!.driver!.image!,
                              width: 40.r,
                              height: 40.r,
                              fit: BoxFit.cover,
                            )
                          : Image.asset(
                              'assets/images/ic_user4.png',
                              width: 40.r,
                              height: 40.r,
                              fit: BoxFit.cover,
                            ),
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
                                title: data.data!.driver!.name ?? "",
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                              if (data.data!.driver!.rate != null) ...[
                                MyText(
                                  title: data.data!.driver!.rate!
                                      .round()
                                      .toString(),
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                ),
                                SizedBox(width: 2.w),
                                const Icon(
                                  Icons.star,
                                  color: AppColors.ORANGE,
                                ),
                              ],
                              const Spacer(),
                              MyText(
                                title: 'الاثنين ، 16 فبراير',
                                fontSize: 12,
                                color: AppColors.GRAY3,
                              )
                            ],
                          ),
                          MyText(
                            title: data.data!.driver!.gender ?? '',
                            fontSize: 12,
                            color: AppColors.GRAY3,
                            fontWeight: FontWeight.w400,
                          ),
                        ],
                      ),
                    )
                  ],
                ),
                Wrap(
                  children: [
                    if (data.data!.driver!.carModel != null)
                      CustomText(
                          text1: AppLocalizations.of(context)!.carModel,
                          text2: data.data!.driver!.carModel ?? "",
                          textColor1: AppColors.GRAY3,
                          textColor2: AppColors.GRAY3),
                    if (data.data!.driver!.carColor != null)
                      CustomText(
                        text1: AppLocalizations.of(context)!.carColor,
                        text2: data.data!.driver!.carColor ?? "",
                        textColor1: AppColors.GRAY3,
                        textColor2: AppColors.GRAY3,
                      ),
                    if (data.data!.driver!.carMake != null)
                      CustomText(
                        text1: AppLocalizations.of(context)!.carMake,
                        text2: data.data!.driver!.carMake ?? "",
                        textColor1: AppColors.GRAY3,
                        textColor2: AppColors.GRAY3,
                      ),
                    if (data.data!.driver!.plateNumber != null)
                      CustomText(
                        text1: AppLocalizations.of(context)!.plateNumber,
                        text2: data.data!.driver!.plateNumber ?? "",
                        textColor1: AppColors.GRAY3,
                        textColor2: AppColors.GRAY3,
                      ),
                    if (data.data!.driver!.carYear != null)
                      CustomText(
                        text1: AppLocalizations.of(context)!.carYear,
                        text2: data.data!.driver!.carYear ?? "",
                        textColor1: AppColors.GRAY3,
                        textColor2: AppColors.GRAY3,
                      ),
                  ],
                ),
                if (data.data!.driver!.carImages!.length > 0) ...[
                  SizedBox(height: 8.h),
                  MyText(
                    title: AppLocalizations.of(context)!.vehicleImage,
                    fontSize: 14,
                    color: AppColors.GRAY3,
                  ),
                  SizedBox(height: 4.h),
                  MyPageView(
                    images: images,
                  ),
                ],
              ],
            ),
          );
  }
}
