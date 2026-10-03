import 'package:easy_plus_customer/core/utils/app_colors.dart';
import 'package:easy_plus_customer/core/widgets/my_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MyCheckBox extends StatefulWidget {
  final bool? initValue;
  final Function onChanged;
  final Color textColor;
  final String? title;
  final FontWeight fontWeight;
  final double fontSize;
  final double space;
  final bool notify;

  const MyCheckBox({
    Key? key,
    required this.onChanged,
    this.fontSize = 16,
    this.fontWeight = FontWeight.w500,
    this.textColor = AppColors.BLACK,
    this.space = 5,
    this.title,
    this.initValue,
    this.notify = false,
  }) : super(key: key);

  @override
  State<MyCheckBox> createState() => _MyCheckBoxState();
}

class _MyCheckBoxState extends State<MyCheckBox> {
  late bool value;
  @override
  void initState() {
    if (widget.initValue != null) {
      value = widget.initValue!;
    } else {
      value = false;
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.notify) {
      value = widget.initValue ?? false;
    }
    return GestureDetector(
      onTap: () {
        value = !value;

        setState(() {
          widget.onChanged(value);
        });
      },
      child: Row(
        children: [
          SizedBox(
            width: 24.r,
            height: 24.r,
            child: Checkbox(
              value: value,
              onChanged: (bool? enabled) {
                if (enabled != null) {
                  value = enabled;

                  setState(() {
                    widget.onChanged(value);
                  });
                }
              },
              hoverColor: AppColors.BASE_COLOR,
              side: BorderSide(
                color: value ? AppColors.BASE_COLOR : AppColors.GRAY,
                width: 1,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4.r),
              ),
            ),
          ),
          if (widget.title != null) ...[
            SizedBox(width: widget.space.w),
            MyText(
              title: widget.title!,
              fontSize: widget.fontSize,
              color: widget.textColor,
              fontWeight: widget.fontWeight,
            ),
          ]
        ],
      ),
    );
  }
}
