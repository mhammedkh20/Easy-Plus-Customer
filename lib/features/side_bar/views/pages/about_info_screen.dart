import 'package:easy_plus_customer/core/utils/app_colors.dart';
import 'package:easy_plus_customer/core/widgets/my_app_bar.dart';
import 'package:easy_plus_customer/core/widgets/my_contianer_shape.dart';
import 'package:easy_plus_customer/core/widgets/my_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AboutInfoScreen extends StatefulWidget {
  const AboutInfoScreen({super.key});

  @override
  State<AboutInfoScreen> createState() => _AboutInfoScreenState();
}

class _AboutInfoScreenState extends State<AboutInfoScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.BASE_COLOR,
      extendBody: true,
      appBar: MyAppBar(
        backgroundColor: AppColors.BASE_COLOR,
        textColor: AppColors.WHITE,
        title: AppLocalizations.of(context)!.aboutUs,
        elevation: 0,
      ),
      body: Stack(
        children: [
          PositionedDirectional(
            top: 0,
            end: 0,
            start: 0,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(height: 16.h),
                Image.asset(
                  'assets/images/ic_app.png',
                  width: 125.r,
                  height: 125.r,
                ),
                SizedBox(height: 16.h),
                MyText(
                  title: 'Easy Plus',
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  height: 0,
                  color: AppColors.WHITE,
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
          PositionedDirectional(
            top: 207.h,
            end: 0,
            start: 0,
            bottom: 0,
            child: MyContainerShape(
              topEndRaduis: 32,
              topStartRaduis: 32,
              paddingHorizontal: 16,
              child: ListView(
                children: [
                  SizedBox(height: 43.h),
                  MyText(
                    title:
                        'هذا نص تجريبي لاختبار شكل و حجم النصوص و طريقة عرضهاi في هذا المكان و حجم و لون الخط حيث يتم التحكم في هذا النص وامكانية تغييرة في اي وقت عن طريق ادارة الموقع . يتم اضافة هذا النص كنص تجريبي للمعاينة .',
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: AppColors.GRAY3,
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
