import 'package:easy_plus_customer/features/request_services/views/widgets/tracking/data_user_widget.dart';
import 'package:easy_plus_customer/core/utils/app_colors.dart';
import 'package:easy_plus_customer/core/widgets/my_app_bar.dart';
import 'package:easy_plus_customer/core/widgets/my_contianer_shape.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TrackingScreen extends StatelessWidget {
  const TrackingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: MyAppBar(
        backgroundColor: AppColors.TRANSPARENT,
        leadingWidth: 60.r,
        leading: Align(
          alignment: AlignmentDirectional.centerEnd,
          child: Material(
            color: AppColors.WHITE,
            borderRadius: BorderRadius.circular(50),
            child: InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              borderRadius: BorderRadius.circular(50),
              child: MyContainerShape(
                height: 44.r,
                width: 44.r,
                bgContainer: AppColors.TRANSPARENT,
                borderRadius: 50,
                child: Center(
                  child: Icon(
                    Icons.arrow_back,
                    size: 24.r,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
      body: Stack(
        children: [
          Image.asset(
            'assets/images/bg_google_maps.png',
            fit: BoxFit.fill,
            height: double.infinity,
            width: double.infinity,
          ),
          const DataUserWidget(),
        ],
      ),
    );
  }
}
