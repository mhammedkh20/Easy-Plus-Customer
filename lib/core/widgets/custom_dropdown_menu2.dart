import 'package:easy_plus_customer/core/utils/app_colors.dart';
import 'package:easy_plus_customer/core/widgets/my_contianer_shape.dart';
import 'package:easy_plus_customer/core/widgets/my_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomDropdownMenu2<T> extends StatefulWidget {
  final List<T> listItems;
  final double? width;
  final double? height;
  final bool enabledBorder;
  final AlignmentDirectional alignment;
  final double paddingHorizontal;
  final Color textColor;
  final Color background;
  final bool isDense;
  final Widget? iconDropdown;
  final bool isExpanded;
  final bool textDirectionLTR;
  final bool notify;
  final T? initValue;
  final void Function<T>(T) onChanged;

  CustomDropdownMenu2({
    super.key,
    required this.listItems,
    required this.onChanged,
    this.enabledBorder = true,
    this.isDense = false,
    this.alignment = AlignmentDirectional.center,
    this.width = null,
    this.height,
    this.paddingHorizontal = 20,
    this.textColor = AppColors.BLACK,
    this.iconDropdown,
    this.isExpanded = false,
    this.textDirectionLTR = false,
    this.notify = false,
    this.initValue,
    this.background = AppColors.TRANSPARENT,
  });

  @override
  State<CustomDropdownMenu2> createState() => _CustomDropdownMenu2State<T>();
}

class _CustomDropdownMenu2State<T> extends State<CustomDropdownMenu2> {
  late T initValue;
  @override
  void initState() {
    initValue = widget.listItems[0];
    if (widget.notify) {
      initValue =
          widget.initValue == '' ? widget.listItems[0] : widget.initValue;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MyContainerShape(
      width: widget.width,
      height: widget.height,
      paddingHorizontal: widget.paddingHorizontal.w,
      alignment: widget.alignment,
      enableRadius: true,
      enableBorder: widget.enabledBorder,
      enableShadow: false,
      bgContainer: widget.background,
      borderRadius: 10.r,
      topEndRaduis: 10.r,
      topStartRaduis: 10.r,
      bottomEndRaduis: 10.r,
      bottomStartRaduis: 10.r,
      widthBorder: 1,
      child: DropdownButton<T>(
        borderRadius: BorderRadius.circular(10.r),
        alignment: widget.alignment,
        underline: const SizedBox(),
        isExpanded: widget.isExpanded,
        value: initValue,
        isDense: widget.isDense,
        icon: setIcon(),
        dropdownColor: AppColors.WHITE,
        items: widget.listItems.map((items) {
          return DropdownMenuItem<T>(
            value: (items as T),
            alignment: widget.alignment,
            child: widget.textDirectionLTR
                ? Directionality(
                    textDirection: TextDirection.ltr,
                    child: MyText(
                      textAlign: TextAlign.center,
                      title: items.toString(),
                      fontSize: 14,
                      color: widget.textColor,
                    ),
                  )
                : MyText(
                    textAlign: TextAlign.center,
                    title: items.toString(),
                    fontSize: 14,
                    color: widget.textColor,
                  ),
          );
        }).toList(),
        onChanged: (T? s) {
          if (s != null) {
            initValue = s;
            widget.onChanged(s);

            setState(() {});
          }
        },
      ),
    );
  }

  Widget setIcon() {
    if (widget.iconDropdown != null) {
      return widget.iconDropdown!;
    }
    return SvgPicture.asset(
      'assets/images/arrows/ic_arrow_down.svg',
      width: 6.r,
      height: 6.r,
    );
  }
}
