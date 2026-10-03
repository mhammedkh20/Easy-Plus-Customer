import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:country_pickers/country.dart';
import 'package:country_pickers/country_pickers.dart';
import 'package:easy_plus_customer/core/widgets/my_text.dart';
import 'package:flutter/material.dart';

class MyCountryCodeItem extends StatelessWidget {
  final Country country;
  const MyCountryCodeItem({
    super.key,
    required this.country,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        MyText(
          title: "+${country.phoneCode}",
          fontSize: 16,
        ),
        SizedBox(width: 8.w),
        CountryPickerUtils.getDefaultFlagImage(country),
        SizedBox(width: 10.w),
      ],
    );
  }
}
