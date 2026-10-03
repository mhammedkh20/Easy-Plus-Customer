// ignore_for_file: must_be_immutable

import 'package:easy_plus_customer/core/utils/app_colors.dart';
import 'package:easy_plus_customer/features/side_bar/views/manager/language_cubit/language_cubit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MyText extends StatelessWidget {
  String title;
  Color? color;
  double fontSize;
  double height;
  FontWeight fontWeight;
  TextAlign textAlign;
  bool lineThrough;
  bool typeLineThrough;
  bool textOverflow;
  int? maxLines;

  MyText({
    Key? key,
    required this.title,
    this.color = AppColors.BLACK,
    this.fontSize = 14,
    this.height = 1.4,
    this.fontWeight = FontWeight.w500,
    this.textAlign = TextAlign.start,
    this.lineThrough = false,
    this.textOverflow = false,
    this.typeLineThrough = false,
    this.maxLines,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LanguageCubit, LanguageState>(
      builder: (context, state) {
        bool langEn = LanguageCubit.get(context).indexLang == 1;
        return Text(
          title,
          textAlign: textAlign,
          overflow: textOverflow ? TextOverflow.ellipsis : null,
          maxLines: maxLines,
          style: TextStyle(
            color: color,
            fontSize: fontSize.sp,
            fontWeight: fontWeight,
            fontFamily: langEn ? 'ubuntu' : 'Montserrat',
            height: height,
            decorationThickness: 1,
            decoration: lineThrough
                ? typeLineThrough
                    ? TextDecoration.lineThrough
                    : TextDecoration.underline
                : null,
          ),
        );
      },
    );
  }
}
