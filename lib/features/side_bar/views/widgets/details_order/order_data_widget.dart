// ignore_for_file: curly_braces_in_flow_control_structures

import 'package:easy_plus_customer/core/storage/pref/shared_pref_controller.dart';
import 'package:easy_plus_customer/features/side_bar/model/order/order_object.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:easy_plus_customer/core/utils/app_colors.dart';
import 'package:easy_plus_customer/core/widgets/my_contianer_shape.dart';
import 'package:easy_plus_customer/core/widgets/my_text.dart';
import 'package:easy_plus_customer/features/side_bar/model/order/order_response.dart';
import 'package:easy_plus_customer/features/side_bar/views/widgets/details_order/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class OrderDataWidget extends StatelessWidget {
  final OrderResponse data;
  const OrderDataWidget({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return MyContainerShape(
      paddingHorizontal: 12,
      paddingVertical: 12,
      borderRadius: 11,
      marginBottom: 24,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Wrap(
            children: [
              CustomText(
                  text1: AppLocalizations.of(context)!.typeOfRequest,
                  text2: data.data!.category ?? "",
                  textColor1: AppColors.BASE_COLOR,
                  textColor2: AppColors.BASE_COLOR),
              CustomText(
                text1: AppLocalizations.of(context)!.orderNumber,
                text2: data.data!.id.toString(),
                textColor1: AppColors.GRAY3,
                textColor2: AppColors.GRAY3,
              ),
              if (data.data!.carType != null)
                CustomText(
                  text1: AppLocalizations.of(context)!.typeOfCar,
                  text2: data.data!.carType ?? "",
                  textColor1: AppColors.GRAY3,
                  textColor2: AppColors.GRAY3,
                ),
              if (data.data!.driverGender != null)
                if (data.data!.categoryId == 5)
                  CustomText(
                    text1: AppLocalizations.of(context)!.driverGender,
                    text2: data.data!.driverGender != null
                        ? data.data!.driverGender!.toString()
                        : '',
                    textColor1: AppColors.GRAY3,
                    textColor2: AppColors.GRAY3,
                  ),
              if (data.data!.navRange != null)
                CustomText(
                  text1: AppLocalizations.of(context)!.navigationRange,
                  text2: data.data!.navRange != null
                      ? data.data!.navRange!.toString()
                      : '',
                  textColor1: AppColors.GRAY3,
                  textColor2: AppColors.GRAY3,
                ),
              if (data.data!.pickType != null)
                if (data.data!.categoryId == 5)
                  if (data.data!.duration == null)
                    CustomText(
                      text1: AppLocalizations.of(context)!.reservationType,
                      text2: data.data!.pickType ?? "",
                      textColor1: AppColors.GRAY3,
                      textColor2: AppColors.GRAY3,
                    ),
              // CustomText(
              //   text1: AppLocalizations.of(context)!.category,
              //   text2: data.data!.category ?? "",
              //   textColor1: AppColors.GRAY3,
              //   textColor2: AppColors.GRAY3,
              // ),

              if (data.data!.orderType != null &&
                  data.data!.orderType != 'null')
                CustomText(
                  text1: AppLocalizations.of(context)!.requestCategory,
                  text2: data.data!.orderType ?? "",
                  textColor1: AppColors.GRAY3,
                  textColor2: AppColors.GRAY3,
                ),
              // if (data.data!.isCash != null)
              //   CustomText(
              //     text1: AppLocalizations.of(context)!.paymentMethodAccepted,
              //     text2: data.data!.isCash != null
              //         ? data.data!.isCash!.toString()
              //         : '',
              //     textColor1: AppColors.GRAY3,
              //     textColor2: AppColors.GRAY3,
              //   ),

              if (data.data!.tourType != null)
                CustomText(
                  text1: AppLocalizations.of(context)!.tourType,
                  text2: data.data!.tourType != null
                      ? data.data!.tourType!.toString()
                      : '',
                  textColor1: AppColors.GRAY3,
                  textColor2: AppColors.GRAY3,
                ),
              if (data.data!.tourTypeStatus != null)
                if (data.data!.categoryId == 4)
                  CustomText(
                    text1: AppLocalizations.of(context)!.roundTypeCase,
                    text2: data.data!.tourTypeStatus != null
                        ? data.data!.tourTypeStatus!.toString()
                        : '',
                    textColor1: AppColors.GRAY3,
                    textColor2: AppColors.GRAY3,
                  ),
              if (data.data!.tourTime != null)
                CustomText(
                  text1: data.data!.duration == null
                      ? AppLocalizations.of(context)!.numberTour
                      : AppLocalizations.of(context)!.roundTime,
                  text2: getDurationText(context, data.data!),
                  textColor1: AppColors.GRAY3,
                  textColor2: AppColors.GRAY3,
                ),
              if (data.data!.revisionType != null)
                CustomText(
                  text1: AppLocalizations.of(context)!.reviewType,
                  text2: data.data!.revisionType != null
                      ? data.data!.revisionType!.toString()
                      : '',
                  textColor1: AppColors.GRAY3,
                  textColor2: AppColors.GRAY3,
                ),
              if (data.data!.shoppingTypeId != null)
                CustomText(
                  text1: AppLocalizations.of(context)!.shoppingType,
                  text2: data.data!.shoppingTypeId != null
                      ? data.data!.shoppingTypeId!.toString()
                      : '',
                  textColor1: AppColors.GRAY3,
                  textColor2: AppColors.GRAY3,
                ),
              if (data.data!.reviewer != null &&
                  data.data!.reviewer != 'null' &&
                  data.data!.categoryId == 2)
                CustomText(
                  text1: AppLocalizations.of(context)!.reviewer,
                  text2: data.data!.reviewer != null
                      ? data.data!.reviewer!.toString()
                      : '',
                  textColor1: AppColors.GRAY3,
                  textColor2: AppColors.GRAY3,
                ),
              if (data.data!.shoppingDestination != null &&
                  data.data!.shoppingDestination != 'null' &&
                  data.data!.categoryId == 3)
                CustomText(
                  text1: AppLocalizations.of(context)!.shoppingDestination,
                  text2: data.data!.shoppingDestination != null
                      ? data.data!.shoppingDestination!.toString()
                      : '',
                  textColor1: AppColors.GRAY3,
                  textColor2: AppColors.GRAY3,
                ),

              if (data.data!.categoryId == 4) ...[
                if (data.data!.seatsNumber != null)
                  if (data.data!.pickType != 'private' ||
                      data.data!.pickType != 'الخاص')
                    CustomText(
                      text1: getDurationText2(context, data.data),
                      text2: data.data!.seatsNumber != null
                          ? data.data!.seatsNumber!.toString()
                          : '',
                      textColor1: AppColors.GRAY3,
                      textColor2: AppColors.GRAY3,
                    ),
              ],
              if (data.data!.categoryId == 5) ...[
                if ((data.data!.pickType != 'private' &&
                        data.data!.pickType != 'خاص') &&
                    data.data!.duration == null)
                  CustomText(
                    text1: getDurationText2(context, data.data),
                    text2: data.data!.seatsNumber != null
                        ? data.data!.seatsNumber!.toString()
                        : '',
                    textColor1: AppColors.GRAY3,
                    textColor2: AppColors.GRAY3,
                  )
              ],
              if (data.data!.categoryId == 5) ...[
                if (data.data!.duration != null)
                  CustomText(
                    text1: getDurationText2(context, data.data),
                    text2: data.data!.seatsNumber != null
                        ? data.data!.seatsNumber!.toString()
                        : '',
                    textColor1: AppColors.GRAY3,
                    textColor2: AppColors.GRAY3,
                  ),
              ],
              if (data.data!.initialPrice != null) ...[
                if (double.parse(data.data!.initialPrice!) > 0)
                  CustomText(
                    text1: AppLocalizations.of(context)!.initialPrice,
                    text2: data.data!.initialPrice ?? "",
                    textColor1: AppColors.GRAY3,
                    textColor2: AppColors.GRAY3,
                  ),
              ],
              if (data.data!.daysCount != null &&
                  data.data!.daysCount != 'null' &&
                  data.data!.categoryId == 2) ...[
                CustomText(
                  text1: AppLocalizations.of(context)!.numberOfRevisions,
                  text2: data.data!.daysCount ?? "",
                  textColor1: AppColors.GRAY3,
                  textColor2: AppColors.GRAY3,
                ),
              ],

              getTimeWidget(context),
              if (data.data!.driverGenderId != null &&
                  data.data!.driverGenderId != 'null')
                CustomText(
                  text1: AppLocalizations.of(context)!.driverGender,
                  text2: data.data!.driverGenderId ?? "",
                  textColor1: AppColors.GRAY3,
                  textColor2: AppColors.GRAY3,
                ),
              if (data.data!.daysCount != null &&
                  data.data!.daysCount != 'null' &&
                  data.data!.categoryId == 3)
                CustomText(
                  text1: AppLocalizations.of(context)!.theNumberOfDays,
                  text2: data.data!.daysCount ?? "",
                  textColor1: AppColors.GRAY3,
                  textColor2: AppColors.GRAY3,
                ),
              if (data.data!.daysCount != null &&
                  data.data!.daysCount != 'null' &&
                  data.data!.categoryId == 1 &&
                  int.parse(data.data!.daysCount!) > 0) ...[
                CustomText(
                  text1: getDurationText2(context, data.data!),
                  text2: data.data!.daysCount ?? "",
                  textColor1: AppColors.GRAY3,
                  textColor2: AppColors.GRAY3,
                ),
              ],
            ],
          ),
          const Divider(
            height: 2,
            color: AppColors.GRAY,
          ),
          SizedBox(height: 8.h),
          Row(
            children: [
              MyText(
                title: AppLocalizations.of(context)!.orderStatus,
                fontSize: 16,
                color: AppColors.GRAY3,
              ),
              SizedBox(width: 8.w),
              MyText(
                title: data.data!.status ?? "",
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ],
          ),
          SizedBox(height: 8.h),
          const Divider(
            height: 2,
            color: AppColors.GRAY,
          ),
          SizedBox(height: 8.h),
          MyText(
            title: AppLocalizations.of(context)!.additionalDetails,
            fontSize: 16,
            color: AppColors.GRAY3,
          ),
          SizedBox(height: 4.h),
          MyText(
            title: data.data!.desc ?? "",
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ],
      ),
    );
  }

  String getDurationText(BuildContext context, OrderObject? data) {
    String? duration;
    if (data!.duration != null) {
      switch (data.duration!) {
        case 'day':
          duration = AppLocalizations.of(context)!.day;
          break;
        case 'hour':
          duration = AppLocalizations.of(context)!.hour;
          break;
      }
    }
    return duration != null ? '${data.tourTime!} $duration' : data.tourTime!;
  }

  String getDurationText2(BuildContext context, OrderObject? data) {
    String? duration;
    if (data!.duration != null) {
      switch (data.duration!) {
        case 'day':
          duration = AppLocalizations.of(context)!.theNumberOfDays;
          break;
        case 'hour':
          duration = AppLocalizations.of(context)!.theNumberOfHours;
          break;
      }
    }
    if (duration != null) {
      return duration;
    } else {
      return AppLocalizations.of(context)!.numberOfSeats;
    }
  }

  Widget getTimeWidget(BuildContext context) {
    DateFormat dateFormat2 =
        DateFormat('hh:mm , d MMM', SharedPrefController().getLang);
    DateTime date = DateTime.parse(data.data!.startDate ?? "");

    if (data.data!.startDate != null && data.data!.startDate != 'null') {
      if (data.data!.categoryId == 2 || data.data!.categoryId == 5) {
        // هان النوع : مجدول او فوري
        if (data.data!.reservationType != null &&
            data.data!.reservationType == 'tabular') {
          return CustomText(
            text1: AppLocalizations.of(context)!.schedulingStart,
            text2: dateFormat2.format(date),
            textColor1: AppColors.GRAY3,
            textColor2: AppColors.GRAY3,
          );
        }

        if (data.data!.categoryId == 2) {
          return CustomText(
            text1: AppLocalizations.of(context)!.beginningReview,
            text2: dateFormat2.format(date),
            textColor1: AppColors.GRAY3,
            textColor2: AppColors.GRAY3,
          );
        }
      }
      if (data.data!.categoryId == 4) {
        // هان النوع : مجدول او فوري

        return CustomText(
          text1: AppLocalizations.of(context)!.schedulingStart,
          text2: dateFormat2.format(date),
          textColor1: AppColors.GRAY3,
          textColor2: AppColors.GRAY3,
        );
      }

      if (data.data!.categoryId == 3) {
        return CustomText(
          text1: AppLocalizations.of(context)!.shoppingHistory,
          text2: dateFormat2.format(date),
          textColor1: AppColors.GRAY3,
          textColor2: AppColors.GRAY3,
        );
      }

      if (data.data!.categoryId == 1) {
        return CustomText(
          text1: AppLocalizations.of(context)!.dateOrderWasDelivered,
          text2: dateFormat2.format(date),
          textColor1: AppColors.GRAY3,
          textColor2: AppColors.GRAY3,
        );
      }
    }
    return SizedBox();
  }
}
