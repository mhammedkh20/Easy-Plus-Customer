import 'package:easy_plus_customer/core/utils/app_colors.dart';
import 'package:easy_plus_customer/core/utils/app_helpers.dart';
import 'package:easy_plus_customer/core/widgets/my_app_bar.dart';
import 'package:easy_plus_customer/core/widgets/my_contianer_shape.dart';
import 'package:easy_plus_customer/core/widgets/my_elevated_button.dart';
import 'package:easy_plus_customer/core/widgets/my_text.dart';
import 'package:easy_plus_customer/core/widgets/my_page_view.dart';
import 'package:easy_plus_customer/features/request_services/views/pages/pay_details/success_payment_screen.dart';
import 'package:easy_plus_customer/features/side_bar/views/widgets/details_order/custom_text.dart';
import 'package:easy_plus_customer/features/side_bar/views/widgets/details_order/from_starting_address_to_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class PayDetailsScreen extends StatelessWidget {
  const PayDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.BG_SCAFOLLD,
      appBar: MyAppBar(
        backgroundColor: AppColors.BG_SCAFOLLD,
        title: AppLocalizations.of(context)!.pay,
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: 16.h),
                const FromStartingAddressTo(),
                SizedBox(height: 16.h),
                MyContainerShape(
                  paddingHorizontal: 12,
                  paddingVertical: 12,
                  borderRadius: 11,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      GridView.builder(
                        padding: EdgeInsets.zero,
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: 8,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisSpacing: 10,
                          crossAxisSpacing: 0,
                          childAspectRatio: 1 / .2,
                        ),
                        itemBuilder: (context, index) {
                          return Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              CustomText(
                                text1: 'نوع الطلب',
                                text2: 'مشوار',
                                textColor1: index == 0
                                    ? AppColors.BASE_COLOR
                                    : AppColors.GRAY3,
                                textColor2: index == 0
                                    ? AppColors.BASE_COLOR
                                    : AppColors.GRAY3,
                              ),
                              const Divider(
                                height: 0,
                                color: AppColors.GRAY,
                              ),
                            ],
                          );
                        },
                      ),
                      SizedBox(height: 8.h),
                      MyText(
                        title: 'تفاصيل اضافية',
                        fontSize: 16,
                        color: AppColors.GRAY3,
                      ),
                      SizedBox(height: 4.h),
                      MyText(
                        title: 'نرجو من سيادتكم الالتزام في الموعد وكل الحب',
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 16.h),
                MyContainerShape(
                  paddingHorizontal: 12,
                  paddingVertical: 12,
                  borderRadius: 11,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Image.asset(
                            'assets/images/ic_user4.png',
                            width: 40.r,
                            height: 40.r,
                            fit: BoxFit.cover,
                          ),
                          SizedBox(width: 12.w),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(height: 3.h),
                                Row(
                                  children: [
                                    MyText(
                                      title: 'عبدالله ابو القمبز',
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                    ),
                                    MyText(
                                      title: '5.4',
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500,
                                    ),
                                    SizedBox(width: 2.w),
                                    const Icon(
                                      Icons.star,
                                      color: AppColors.ORANGE,
                                    ),
                                    const Spacer(),
                                    MyText(
                                      title: 'الاثنين ، 16 فبراير',
                                      fontSize: 12,
                                      color: AppColors.GRAY3,
                                    )
                                  ],
                                ),
                                MyText(
                                  title: 'ذكر',
                                  fontSize: 12,
                                  color: AppColors.GRAY3,
                                  fontWeight: FontWeight.w400,
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                      GridView.builder(
                        padding: EdgeInsets.zero,
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: 4,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisSpacing: 10,
                          crossAxisSpacing: 0,
                          childAspectRatio: 1 / .2,
                        ),
                        itemBuilder: (context, index) {
                          return Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: const [
                              CustomText(
                                text1: 'نوع الطلب',
                                text2: 'مشوار',
                                fontSize1: 14,
                                fontSize2: 14,
                              ),
                              Divider(
                                height: 0,
                                color: AppColors.GRAY,
                              ),
                            ],
                          );
                        },
                      ),
                      SizedBox(height: 8.h),
                      MyText(
                        title: 'صورة المركبة',
                        fontSize: 14,
                        color: AppColors.GRAY3,
                      ),
                      SizedBox(height: 4.h),
                      MyPageView(
                        images: [],
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 12.h),
                MyContainerShape(
                  paddingHorizontal: 12,
                  paddingVertical: 20,
                  borderRadius: 11,
                  child: Column(
                    children: [
                      _customText(
                        keyy: AppLocalizations.of(context)!.orderPrice,
                        value: '50 ر.س',
                      ),
                      SizedBox(height: 8.h),
                      const Divider(height: 1, thickness: 1),
                      SizedBox(height: 10.h),
                      _customText(
                        keyy: AppLocalizations.of(context)!.applicationFee,
                        value: '10 ر.س',
                      ),
                      SizedBox(height: 8.h),
                      const Divider(height: 1, thickness: 1),
                      SizedBox(height: 10.h),
                      _customText(
                        keyy: AppLocalizations.of(context)!.total,
                        value: '60 ر.س',
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 12.h),
                Row(
                  children: [
                    MyText(
                      title: AppLocalizations.of(context)!.note,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: AppColors.RED,
                    ),
                    MyText(
                      title:
                          "/${AppLocalizations.of(context)!.theServiceAcceptsCashPaymentsOnly}",
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: AppColors.GRAY3,
                    ),
                  ],
                ),
                SizedBox(height: 32.h),
                MyElevatedButton(
                  title:
                      '${AppLocalizations.of(context)!.paymentConfirmation} 60 ر.س',
                  onPressed: () {
                    AppHelpers.navigationToPageAndExitAllWithoutFirst(context);
                    AppHelpers.navigationToPage(
                        context, SuccessPaymentScreen());
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _customText({
    required String keyy,
    required String value,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        MyText(
          title: keyy,
          fontSize: 14,
          color: AppColors.GRAY3,
        ),
        MyText(
          title: value,
          fontSize: 14,
          fontWeight: FontWeight.w700,
        ),
      ],
    );
  }
}
