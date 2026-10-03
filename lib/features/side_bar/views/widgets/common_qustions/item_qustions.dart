import 'package:easy_plus_customer/features/side_bar/model/qustion.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../core/utils/app_colors.dart';
import '../../../../../../core/widgets/my_contianer_shape.dart';
import '../../../../../../core/widgets/my_text.dart';

class ItemQuestions extends StatefulWidget {
  final Qustion qustion;
  const ItemQuestions({super.key, required this.qustion});

  @override
  State<ItemQuestions> createState() => _ItemQuestionsState();
}

class _ItemQuestionsState extends State<ItemQuestions> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        MyContainerShape(
          topEndRaduis: 10,
          topStartRaduis: 10,
          bottomEndRaduis: isExpanded ? 0 : 10,
          bottomStartRaduis: isExpanded ? 0 : 10,
          paddingHorizontal: 12,
          height: 55.h,
          enableShadow: false,
          bgContainer: AppColors.WHITE2,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              MyText(
                title: widget.qustion.name.toString(),
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
              IconButton(
                padding: EdgeInsets.symmetric(horizontal: 4.r, vertical: 4.r),
                onPressed: () {
                  setState(() {
                    isExpanded = !isExpanded;
                  });
                },
                constraints: const BoxConstraints(),
                icon: Icon(
                  isExpanded ? Icons.remove : Icons.add,
                  color: AppColors.BLACK,
                ),
              ),
            ],
          ),
        ),
        AnimatedSize(
          duration: const Duration(milliseconds: 300),
          child: MyContainerShape(
            bottomEndRaduis: 10,
            bottomStartRaduis: 10,
            alignment: AlignmentDirectional.centerStart,
            paddingHorizontal: 12,
            enableShadow: false,
            bgContainer: AppColors.WHITE2,
            height: isExpanded ? null : 0,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                MyText(
                  textAlign: TextAlign.start,
                  title: widget.qustion.desc.toString(),
                ),
                SizedBox(height: 10.h),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
