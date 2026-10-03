import 'package:easy_plus_customer/core/utils/app_colors.dart';
import 'package:easy_plus_customer/core/widgets/my_contianer_shape.dart';
import 'package:easy_plus_customer/core/widgets/my_text.dart';
import 'package:easy_plus_customer/features/main/model/notification_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

class ItemNotification extends StatelessWidget {
  final NotificationModel data;

  const ItemNotification({
    super.key,
    required this.data,
  });

  @override
  Widget build(BuildContext context) {
    return MyContainerShape(
      bgContainer: AppColors.WHITE,
      borderRadius: 12,
      paddingHorizontal: 10,
      paddingVertical: 10,
      child: Row(
        children: [
          if (data.user != null) ...[
            if (data.user!.image != null)
              MyContainerShape(
                borderRadius: 50,
                child: Image.network(
                  data.user!.image!,
                  width: 55.r,
                  fit: BoxFit.cover,
                  height: 55.r,
                ),
              )
            else
              Image.asset(
                'assets/images/ic_user3.png',
                width: 55.r,
                height: 55.r,
              ),
          ] else ...[
            Image.asset(
              'assets/images/ic_user3.png',
              width: 55.r,
              height: 55.r,
            ),
          ],
          SizedBox(width: 13.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    if (data.user != null)
                      if (data.user!.name != null)
                        MyText(
                          title: data.user!.name.toString(),
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                        ),
                    MyText(
                      title: data.createdAt != null
                          ? DateFormat('HH-mm \n yyyy-MM-dd')
                              .format(DateTime.parse(data.createdAt!))
                          : "",
                      textAlign: TextAlign.end,
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: AppColors.GRAY2,
                    ),
                  ],
                ),
                SizedBox(height: 4.h),
                MyText(
                  title: data.title ?? "",
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: AppColors.GRAY3,
                  textOverflow: true,
                ),
                SizedBox(height: 4.h),
                MyText(
                  title: data.body ?? "",
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: AppColors.GRAY3,
                  textOverflow: true,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
