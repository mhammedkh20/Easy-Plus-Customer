import 'package:easy_plus_customer/core/utils/app_colors.dart';
import 'package:easy_plus_customer/core/utils/app_helpers.dart';
import 'package:easy_plus_customer/core/widgets/my_elevated_button.dart';
import 'package:easy_plus_customer/features/main/views/pages/main_screen.dart';
import 'package:easy_plus_customer/features/side_bar/views/pages/my_request_screens/details_progress_order_screen.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:easy_plus_customer/core/widgets/my_text.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:easy_plus_customer/core/widgets/my_app_bar.dart';
import 'package:flutter/material.dart';

class SuccessPaymentScreen extends StatelessWidget {
  const SuccessPaymentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MyAppBar(
        leading: const SizedBox(),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Image.asset(
                'assets/images/im_success_payment.png',
                width: double.infinity,
                height: 502.h,
              ),
              MyText(
                textAlign: TextAlign.center,
                fontSize: 20,
                fontWeight: FontWeight.bold,
                title: AppLocalizations.of(context)!
                    .weHaveBeenSuccessfullyDeliverTheRequest,
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Row(
            children: [
              Expanded(
                child: MyElevatedButton(
                  borderRaduis: 11,
                  title: AppLocalizations.of(context)!.orderDetails,
                  onPressed: () {
                    AppHelpers.navigationReplacementToPage(
                        context,
                        DetailsProgressOrderScreen(
                          orderId: '',
                        ));
                  },
                  fontWeight: FontWeight.bold,
                  background: AppColors.GREEN_LIGHT,
                  titleColor: AppColors.BLACK,
                ),
              ),
              SizedBox(width: 16.w),
              Expanded(
                child: MyElevatedButton(
                  borderRaduis: 11,
                  title: AppLocalizations.of(context)!.homePage,
                  onPressed: () {
                    AppHelpers.navigationToPageAndExitAll(
                      context,
                      MainScreen(),
                    );
                  },
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
