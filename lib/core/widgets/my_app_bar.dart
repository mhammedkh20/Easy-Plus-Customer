import 'package:easy_plus_customer/core/utils/app_colors.dart';
import 'package:easy_plus_customer/core/widgets/my_text.dart';
import 'package:flutter/material.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Widget? leading;
  final List<Widget>? actions;
  final String title;
  final double? leadingWidth;
  final Color textColor;
  final Color backgroundColor;
  final double? elevation;

  const MyAppBar({
    Key? key,
    this.leading,
    this.actions,
    this.title = '',
    this.leadingWidth,
    this.textColor = AppColors.BLACK,
    this.backgroundColor = AppColors.WHITE,
    this.elevation,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: backgroundColor,
      elevation: elevation ?? (title == '' ? 0 : 1),
      leading: leading,
      iconTheme: IconThemeData(color: textColor),
      centerTitle: true,
      leadingWidth: leadingWidth,
      title: MyText(
        title: title,
        fontSize: 16,
        color: textColor,
        fontWeight: FontWeight.w500,
      ),
      actions: actions,
    );
  }

  @override
  Size get preferredSize => AppBar().preferredSize;
}
