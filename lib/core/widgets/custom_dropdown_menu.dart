import 'package:easy_plus_customer/core/utils/app_colors.dart';
import 'package:easy_plus_customer/core/widgets/my_contianer_shape.dart';
import 'package:easy_plus_customer/core/widgets/my_text.dart';
import 'package:easy_plus_customer/features/main/model/response_app_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomDropdownMenu extends StatefulWidget {
  final List<CustomClass> listItems;
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
  final CustomClass? initValue;
  final Function onChanged;

  CustomDropdownMenu({
    super.key,
    required this.listItems,
    required this.onChanged,
    this.enabledBorder = true,
    this.isDense = false,
    this.alignment = AlignmentDirectional.center,
    this.width,
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
  State<CustomDropdownMenu> createState() => _CustomDropdownMenuState();
}

class _CustomDropdownMenuState extends State<CustomDropdownMenu> {
  late CustomClass initValue;
  @override
  void initState() {
    initValue = widget.listItems[0];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.notify) {
      initValue =
          (widget.initValue != null ? widget.listItems[0] : widget.initValue)!;
    }
    return MyContainerShape(
      width: widget.width,
      height: widget.height,
      paddingHorizontal: widget.paddingHorizontal,
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
      child: DropdownButton<CustomClass>(
        borderRadius: BorderRadius.circular(10.r),
        alignment: widget.alignment,
        underline: const SizedBox(),
        isExpanded: widget.isExpanded,
        value: initValue,
        isDense: widget.isDense,
        icon: setIcon(),
        dropdownColor: AppColors.WHITE,
        items: widget.listItems.map((CustomClass items) {
          return DropdownMenuItem<CustomClass>(
            value: items,
            alignment: widget.alignment,
            child: widget.textDirectionLTR
                ? Directionality(
                    textDirection: TextDirection.ltr,
                    child: MyText(
                      textAlign: TextAlign.center,
                      title: items.title ?? "",
                      fontSize: 14,
                      color: widget.textColor,
                    ),
                  )
                : MyText(
                    textAlign: TextAlign.center,
                    title: items.title ?? "",
                    fontSize: 14,
                    color: widget.textColor,
                  ),
          );
        }).toList(),
        onChanged: (CustomClass? s) {
          if (s != null) {
            initValue = s;
            setState(() {
              widget.onChanged(s);
            });
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
      'assets/images/arrow-down.svg',
      width: 12.r,
    );
  }
}
