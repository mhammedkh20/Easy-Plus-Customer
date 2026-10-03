import 'package:easy_plus_customer/core/utils/app_colors.dart';
import 'package:easy_plus_customer/core/widgets/my_contianer_shape.dart';
import 'package:easy_plus_customer/core/widgets/my_text.dart';
import 'package:easy_plus_customer/features/request_services/views/manager/service_cubit/service_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomWidget extends StatelessWidget {
  final String title;
  final String iconPath;
  final Function()? onPressedIncrease;
  final Function()? onPressedDecrease;
  final int value;

  const CustomWidget({
    super.key,
    required this.iconPath,
    required this.title,
    required this.onPressedDecrease,
    required this.onPressedIncrease,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return MyContainerShape(
      paddingHorizontal: 12,
      paddingVertical: 10,
      borderRadius: 11,
      enableShadow: false,
      child: Row(
        children: [
          SvgPicture.asset(iconPath),
          SizedBox(width: 8.w),
          BlocBuilder<ServiceCubit, ServiceState>(
            builder: (context, state) {
              return MyText(
                title: title,
                color: AppColors.GRAY3,
                fontSize: 14,
              );
            },
          ),
          const Spacer(),
          IconButton(
            hoverColor: AppColors.TRANSPARENT,
            splashColor: AppColors.TRANSPARENT,
            highlightColor: AppColors.TRANSPARENT,
            constraints: const BoxConstraints(),
            padding: EdgeInsets.symmetric(horizontal: 4.r, vertical: 4.r),
            onPressed: onPressedIncrease,
            icon: const Icon(
              Icons.add,
              color: AppColors.ICON_PLUS,
            ),
          ),
          SizedBox(width: 5.w),
          MyContainerShape(
            height: 32.r,
            width: 32.r,
            bgContainer: AppColors.GRAY3,
            enableShadow: false,
            borderRadius: 50,
            child: BlocBuilder<ServiceCubit, ServiceState>(
              builder: (context, state) {
                return MyText(
                  title: '$value',
                  color: AppColors.WHITE,
                  fontSize: 14,
                );
              },
            ),
          ),
          SizedBox(width: 5.w),
          IconButton(
            hoverColor: AppColors.TRANSPARENT,
            splashColor: AppColors.TRANSPARENT,
            highlightColor: AppColors.TRANSPARENT,
            constraints: const BoxConstraints(),
            padding: EdgeInsets.symmetric(horizontal: 4.r, vertical: 4.r),
            onPressed: onPressedDecrease,
            icon: const Icon(
              Icons.remove,
              color: AppColors.ICON_PLUS,
            ),
          ),
        ],
      ),
    );
  }
}
