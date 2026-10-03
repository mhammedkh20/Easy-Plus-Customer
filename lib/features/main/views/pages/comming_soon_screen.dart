import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:easy_plus_customer/core/widgets/my_app_bar.dart';
import 'package:easy_plus_customer/core/widgets/my_text.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class CommingSoonScreen extends StatelessWidget {
  const CommingSoonScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MyAppBar(elevation: 1),
      body: Stack(
        children: [
          Positioned(
            top: 150.h,
            left: 10.w,
            right: 10.w,
            child: LottieBuilder.asset(
              'assets/images/ic_json/ic_comming_soon.json',
            ),
          ),
          PositionedDirectional(
            start: 0,
            end: 0,
            top: 420.h,
            child: MyText(
              fontSize: 18,
              textAlign: TextAlign.center,
              title: AppLocalizations.of(context)!.soon,
            ),
          ),
        ],
      ),
    );
  }
}
