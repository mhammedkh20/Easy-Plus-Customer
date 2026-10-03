import 'dart:async';

import 'package:easy_plus_customer/core/utils/app_colors.dart';
import 'package:easy_plus_customer/core/utils/app_dialogs.dart';
import 'package:easy_plus_customer/core/widgets/my_contianer_shape.dart';
import 'package:easy_plus_customer/core/widgets/my_elevated_button.dart';
import 'package:easy_plus_customer/core/widgets/my_text.dart';
import 'package:easy_plus_customer/features/side_bar/model/order/offer.dart';
import 'package:easy_plus_customer/features/side_bar/views/widgets/my_request/progress.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intl/intl.dart';

class ItemOffersSubmitted extends StatefulWidget {
  final bool detailsCar;
  final Offers data;
  final String showTime;
  final Function() onPressedOfferRejected;
  final Function() onPressedOfferAccepted;

  const ItemOffersSubmitted({
    super.key,
    this.detailsCar = true,
    required this.onPressedOfferRejected,
    required this.onPressedOfferAccepted,
    required this.data,
    required this.showTime,
  });

  @override
  State<ItemOffersSubmitted> createState() => _ItemOffersSubmittedState();
}

class _ItemOffersSubmittedState extends State<ItemOffersSubmitted> {
  double? proggress;
  DateTime? endDate;
  int? secondsDifference;

  @override
  void initState() {
    int totalSecound = int.parse(widget.showTime) * 60;
    print(widget.showTime);
    DateTime startDate =
        DateFormat('yyyy-MM-dd HH:mm:ss').parse(widget.data.createdAt!);

    endDate = startDate.add(Duration(seconds: totalSecound));

    proggress = 100;

    Timer.periodic(const Duration(seconds: 1), (timer) {
      Duration elapsedTime = DateTime.now().difference(startDate);

      if (endDate!.isAfter(DateTime.now())) {
        secondsDifference = elapsedTime.inSeconds;

        proggress = (secondsDifference! / totalSecound) * 100;
        secondsDifference = totalSecound - secondsDifference!;
        setState(() {});
      } else {
        proggress = proggress! + 1.0;
        timer.cancel();
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MyContainerShape(
      paddingHorizontal: 12,
      paddingVertical: 12,
      borderRadius: 11,
      child: Column(
        children: [
          Row(
            children: [
              widget.data.driver!.image != null
                  ? Container(
                      clipBehavior: Clip.antiAlias,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100)),
                      child: Image.network(
                        widget.data.driver!.image!,
                        width: 55.r,
                        height: 55.r,
                        fit: BoxFit.cover,
                      ),
                    )
                  : Image.asset(
                      'assets/images/ic_user4.png',
                      width: 55.r,
                      height: 55.r,
                      fit: BoxFit.cover,
                    ),
              SizedBox(width: 12.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        MyText(
                          title: widget.data.driver!.name ?? "",
                          fontWeight: FontWeight.w500,
                          fontSize: 16,
                        ),
                        SizedBox(width: 4.w),
                        if (widget.data.driver!.rate != null) ...[
                          MyText(
                            title: widget.data.driver!.rate!.round().toString(),
                            fontWeight: FontWeight.w500,
                            fontSize: 12,
                          ),
                          SizedBox(width: 2.w),
                          const Icon(
                            Icons.star,
                            color: AppColors.ORANGE,
                          ),
                        ]
                      ],
                    ),
                    MyText(
                      title: '15ك',
                      fontSize: 12,
                      color: AppColors.GRAY3,
                    ),
                    if (widget.data.price != null)
                      MyText(
                        title: widget.data.price.toString(),
                        fontSize: 15,
                      ),
                  ],
                ),
              ),
              if (widget.detailsCar) ...[
                if (widget.data.driver != null)
                  if (widget.data.driver!.carImages!.length > 0) ...[
                    GestureDetector(
                      onTap: () {
                        AppDialogs.showPageViewDialog(
                            context, widget.data.driver!.carImages!);
                      },
                      child: Image.network(
                        widget.data.driver!.carImages![0].image!,
                        width: 60.r,
                      ),
                    ),
                  ]
              ],
            ],
          ),
          if (widget.detailsCar) ...[
            SizedBox(height: 12.h),
            SizedBox(
              height: 30.h,
              child: Row(
                children: [
                  if (widget.data.driver!.carModel != null) ...[
                    MyContainerShape(
                      height: 30.h,
                      enableShadow: false,
                      borderRadius: 20,
                      paddingHorizontal: 10,
                      bgContainer: AppColors.WHITE3,
                      child: MyText(
                        title: widget.data.driver!.carModel ?? "",
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: AppColors.GRAY3,
                      ),
                    ),
                    SizedBox(width: 8.w),
                  ],
                  if (widget.data.driver!.carYear != null) ...[
                    MyContainerShape(
                      height: 30.h,
                      enableShadow: false,
                      borderRadius: 20,
                      paddingHorizontal: 10,
                      bgContainer: AppColors.WHITE3,
                      child: MyText(
                        title: widget.data.driver!.carYear ?? "4",
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: AppColors.GRAY3,
                      ),
                    ),
                    SizedBox(width: 8.w),
                  ],
                  if (widget.data.isCash != null)
                    MyContainerShape(
                      height: 30.h,
                      enableShadow: false,
                      borderRadius: 20,
                      paddingHorizontal: 10,
                      bgContainer: AppColors.WHITE3,
                      child: MyText(
                        title: widget.data.isCash! == '1'
                            ? "الدفع كاش"
                            : 'الدفع اونلاين',
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: AppColors.GRAY3,
                      ),
                    ),
                ],
              ),
            ),
          ],
          SizedBox(height: 12.h),
          FAProgressBar(
            maxValue: 100,
            currentValue: proggress!,
            displayText: secondsDifference != null
                ? '$secondsDifference ${AppLocalizations.of(context)!.second}'
                : AppLocalizations.of(context)!.finishTime,
            size: 17,
            animatedDuration: Duration.zero,
            backgroundColor: AppColors.WHITE3,
            borderRadius: BorderRadius.circular(10),
            progressColor: AppColors.BASE_COLOR,
          ),
          SizedBox(height: 16.h),
          Row(
            children: [
              Expanded(
                child: MyElevatedButton(
                  height: 40,
                  onPressed: secondsDifference != null
                      ? widget.onPressedOfferAccepted
                      : null,
                  title: AppLocalizations.of(context)!.offerAccepted,
                  titleColor: secondsDifference != null
                      ? AppColors.BLACK.withOpacity(.8)
                      : null,
                  background:
                      secondsDifference != null ? AppColors.TRANSPARENT : null,
                  fontSize: 14,
                  borderColor: secondsDifference != null
                      ? AppColors.GRAY3
                      : AppColors.TRANSPARENT,
                  enabledBorder: true,
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: MyElevatedButton(
                  height: 40,
                  onPressed: secondsDifference != null
                      ? widget.onPressedOfferRejected
                      : null,
                  title: AppLocalizations.of(context)!.offerRejected,
                  titleColor: secondsDifference != null
                      ? AppColors.BLACK.withOpacity(.8)
                      : null,
                  background:
                      secondsDifference != null ? AppColors.WHITE3 : null,
                  fontSize: 14,
                  borderColor: AppColors.TRANSPARENT,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
