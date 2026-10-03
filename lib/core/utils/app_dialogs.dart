import 'package:country_pickers/country.dart';
import 'package:country_pickers/country_picker_dialog.dart';
import 'package:country_pickers/country_pickers.dart';
import 'package:easy_plus_customer/core/utils/app_colors.dart';
import 'package:easy_plus_customer/core/widgets/my_contianer_shape.dart';
import 'package:easy_plus_customer/core/widgets/my_elevated_button.dart';
import 'package:easy_plus_customer/core/widgets/my_text.dart';
import 'package:easy_plus_customer/features/auth/views/manager/auth_cubit/auth_cubit.dart';
import 'package:easy_plus_customer/core/widgets/my_page_view.dart';
import 'package:easy_plus_customer/features/request_services/views/manager/evaluation_cubit/evaluation_cubit.dart';
import 'package:easy_plus_customer/features/side_bar/model/order/image_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:geolocator/geolocator.dart';
import 'package:lottie/lottie.dart';
import 'package:selectable_autolink_text/selectable_autolink_text.dart';

class AppDialogs {
  static showCountryPicker(BuildContext context) async {
    showDialog(
      context: context,
      builder: (context) => Theme(
        data: Theme.of(context).copyWith(primaryColor: Colors.pink),
        child: CountryPickerDialog(
          titlePadding: EdgeInsets.all(8.r),
          searchCursorColor: Colors.pinkAccent,
          searchInputDecoration:
              InputDecoration(hintText: AppLocalizations.of(context)!.search),
          isSearchable: true,
          title: MyText(
            title: AppLocalizations.of(context)!.selectYourPhoneCode,
          ),
          onValuePicked: (Country country) {
            print(country.isoCode);
            print(country.iso3Code);
            print(country.name);
            print(country.phoneCode);

            AuthCubit.get(context).selectCountry(country);
          },
          itemFilter: (c) => [
            'SA',
            'AE',
            'QA',
            'KW',
            'BH',
            'OM',
            'EG',
            'JO',
          ].contains(c.isoCode),
          priorityList: [
            CountryPickerUtils.getCountryByIsoCode('SA'),
          ],
          itemBuilder: (country) => Row(
            children: <Widget>[
              CountryPickerUtils.getDefaultFlagImage(country),
              SizedBox(width: 8.w),
              MyText(
                title: "+${country.phoneCode}",
                fontSize: 16,
              ),
              SizedBox(width: 8.w),
              MyText(
                title: country.name,
                fontSize: 16,
              ),
            ],
          ),
        ),
      ),
    );
  }

  static showPageViewDialog(BuildContext context, List<ImageModel> carImages) {
    List<String> cars = [];
    for (int i = 0; i < carImages.length; i++) {
      cars.add(carImages[i].image!);
    }
    AlertDialog alert = AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(11.r)),
      backgroundColor: AppColors.WHITE,
      contentPadding: EdgeInsets.zero,
      titlePadding: EdgeInsets.zero,
      buttonPadding: EdgeInsets.zero,
      iconPadding: EdgeInsets.zero,
      insetPadding: EdgeInsets.zero,
      actionsPadding: EdgeInsets.zero,
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width - 40.w,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const IconButton(
                onPressed: null,
                icon: Icon(Icons.close, color: AppColors.TRANSPARENT),
              ),
              MyText(
                title: AppLocalizations.of(context)!.vehiclePhotos,
                fontWeight: FontWeight.bold,
              ),
              IconButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                hoverColor: AppColors.TRANSPARENT,
                highlightColor: AppColors.TRANSPARENT,
                splashColor: AppColors.TRANSPARENT,
                icon: MyContainerShape(
                  bgContainer: AppColors.WHITE3,
                  borderRadius: 40,
                  child: const Icon(Icons.close),
                ),
              ),
            ],
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width - 40.w,
            child: MyPageView(
              images: cars,
              withAnimation: false,
            ),
          ),
          SizedBox(height: 20.h),
        ],
      ),
    );

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  static showDeleteOrderDialog(
    BuildContext context, {
    required double? price,
    required Function()? onPressedNo,
    required Function()? onPressedYes,
    String? orderTypeStatus,
  }) {
    AlertDialog alert = AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(11.r)),
      backgroundColor: AppColors.WHITE,
      contentPadding: EdgeInsets.zero,
      titlePadding: EdgeInsets.zero,
      buttonPadding: EdgeInsets.zero,
      iconPadding: EdgeInsets.zero,
      insetPadding: EdgeInsets.zero,
      actionsPadding: EdgeInsets.zero,
      content: SizedBox(
        width: MediaQuery.of(context).size.width - 40.w,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Lottie.asset(
                'assets/images/ic_json/ic_delete.json',
                width: 150.r,
                height: 150.r,
              ),
              MyText(
                title:
                    AppLocalizations.of(context)!.areYouSureToCancelTheRequest,
                fontWeight: FontWeight.bold,
              ),
              if (orderTypeStatus == null) ...[
                SizedBox(height: 5.h),
                MyText(
                  title: AppLocalizations.of(context)!.willBeDeducted +
                      price.toString() +
                      AppLocalizations.of(context)!.dueCancellationOrder,
                  fontSize: 13,
                  color: AppColors.GRAY3,
                ),
              ],
              SizedBox(height: 50.h),
              Row(
                children: [
                  Expanded(
                    child: MyElevatedButton(
                      borderRaduis: 30,
                      height: 50,
                      title: AppLocalizations.of(context)!.yes,
                      onPressed: onPressedYes,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      background: AppColors.RED,
                    ),
                  ),
                  SizedBox(width: 12.w),
                  Expanded(
                    child: MyElevatedButton(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      borderRaduis: 30,
                      height: 50,
                      titleColor: AppColors.BLACK,
                      background: AppColors.GREEN_LIGHT,
                      title: AppLocalizations.of(context)!.no,
                      onPressed: onPressedNo,
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  static showBlockFromAdminDialog(BuildContext context,
      {required Function()? onPressedOk}) {
    AlertDialog alert = AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(11.r)),
      backgroundColor: AppColors.WHITE,
      contentPadding: EdgeInsets.zero,
      titlePadding: EdgeInsets.zero,
      buttonPadding: EdgeInsets.zero,
      iconPadding: EdgeInsets.zero,
      insetPadding: EdgeInsets.zero,
      actionsPadding: EdgeInsets.zero,
      content: SizedBox(
        width: MediaQuery.of(context).size.width - 40.w,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Lottie.asset(
                'assets/images/ic_json/faild.json',
                width: 110.r,
                height: 110.r,
              ),
              MyText(
                title: AppLocalizations.of(context)!.descBlockAccount,
                fontSize: 13,
                textAlign: TextAlign.center,
                color: AppColors.GRAY3,
              ),
              SelectableAutoLinkText(
                'easyplus.sa@gmail.com',
                linkStyle: TextStyle(
                    color: Colors.blueAccent,
                    fontSize: 18.sp,
                    fontFamily: 'Montserrat'),
                highlightedLinkStyle: TextStyle(
                  fontFamily: 'Montserrat',
                  fontSize: 18.sp,
                  color: Colors.blueAccent,
                  backgroundColor: Colors.blueAccent.withAlpha(0x33),
                ),
              ),
              SizedBox(height: 50.h),
              MyElevatedButton(
                borderRaduis: 30,
                title: AppLocalizations.of(context)!.ok,
                onPressed: onPressedOk,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              )
            ],
          ),
        ),
      ),
    );

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  static showLocationDetailsDialog(
    BuildContext context, {
    required Function()? onPressedNo,
    required Function()? onPressedYes,
  }) {
    AlertDialog alert = AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(11.r)),
      backgroundColor: AppColors.WHITE,
      contentPadding: EdgeInsets.zero,
      titlePadding: EdgeInsets.zero,
      buttonPadding: EdgeInsets.zero,
      iconPadding: EdgeInsets.zero,
      insetPadding: EdgeInsets.zero,
      actionsPadding: EdgeInsets.zero,
      content: SizedBox(
        width: MediaQuery.of(context).size.width - 40.w,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              MyText(
                title: AppLocalizations.of(context)!.locationDetails,
                fontSize: 20,
              ),
              MyText(
                title: AppLocalizations.of(context)!
                    .areYouSureAboutTheReturnProcess,
              ),
              SizedBox(height: 20.h),
              Row(
                children: [
                  Expanded(
                    child: MyElevatedButton(
                      height: 40,
                      borderRaduis: 8,
                      title: AppLocalizations.of(context)!.yes,
                      onPressed: onPressedYes,
                      background: AppColors.TRANSPARENT,
                      titleColor: AppColors.GRAY3,
                      borderColor: AppColors.GRAY3,
                    ),
                  ),
                  SizedBox(width: 20.w),
                  Expanded(
                    child: MyElevatedButton(
                      height: 40,
                      borderRaduis: 8,
                      title: AppLocalizations.of(context)!.no,
                      onPressed: onPressedNo,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  static showChoosePaymentMethodDialog(
    BuildContext context, {
    required Function()? onPressedNo,
    required Function()? onPressedYes,
  }) {
    AlertDialog alert = AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(11.r)),
      backgroundColor: AppColors.WHITE,
      contentPadding: EdgeInsets.zero,
      titlePadding: EdgeInsets.zero,
      buttonPadding: EdgeInsets.zero,
      iconPadding: EdgeInsets.zero,
      insetPadding: EdgeInsets.zero,
      actionsPadding: EdgeInsets.zero,
      content: SizedBox(
        width: MediaQuery.of(context).size.width - 40.w,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              MyText(
                title: AppLocalizations.of(context)!.paymentConfirmation,
                fontSize: 20,
              ),
              MyText(
                title: AppLocalizations.of(context)!.paymentConfirmationDesc,
              ),
              SizedBox(height: 20.h),
              Row(
                children: [
                  Expanded(
                    child: MyElevatedButton(
                      height: 40,
                      borderRaduis: 8,
                      title: AppLocalizations.of(context)!.confirm,
                      onPressed: onPressedYes,
                    ),
                  ),
                  SizedBox(width: 20.w),
                  Expanded(
                    child: MyElevatedButton(
                      height: 40,
                      borderRaduis: 8,
                      title: AppLocalizations.of(context)!.cancel,
                      onPressed: onPressedNo,
                      background: AppColors.TRANSPARENT,
                      titleColor: AppColors.GRAY3,
                      borderColor: AppColors.GRAY3,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  static showDidYouDeliverDialog(
    BuildContext context, {
    required Function()? onPressedNo,
    required Function()? onPressedYes,
  }) {
    AlertDialog alert = AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(11.r)),
      backgroundColor: AppColors.TRANSPARENT,
      contentPadding: EdgeInsets.zero,
      titlePadding: EdgeInsets.zero,
      buttonPadding: EdgeInsets.zero,
      iconPadding: EdgeInsets.zero,
      insetPadding: EdgeInsets.zero,
      actionsPadding: EdgeInsets.zero,
      content: SizedBox(
        width: MediaQuery.of(context).size.width - 40.w,
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Positioned(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
                width: MediaQuery.of(context).size.width - 40.w,
                decoration: BoxDecoration(
                  color: AppColors.WHITE,
                  borderRadius: BorderRadius.circular(16.r),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(height: 60.h),
                    Image.asset(
                      'assets/images/ic_tax.png',
                      width: 180.w,
                    ),
                    SizedBox(height: 20.h),
                    MyText(
                      title:
                          AppLocalizations.of(context)!.wasItActuallyDelivered,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                    SizedBox(height: 5.h),
                    MyText(
                      title: AppLocalizations.of(context)!
                          .theDriverHasFinishedTrip,
                      fontSize: 13,
                      color: AppColors.GRAY3,
                    ),
                    SizedBox(height: 50.h),
                    Row(
                      children: [
                        Expanded(
                          child: MyElevatedButton(
                            borderRaduis: 11,
                            height: 50,
                            title: AppLocalizations.of(context)!.yes,
                            onPressed: onPressedYes,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(width: 12.w),
                        Expanded(
                          child: MyElevatedButton(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            borderRaduis: 11,
                            height: 50,
                            titleColor: AppColors.BLACK,
                            background: AppColors.GREEN_LIGHT,
                            title: AppLocalizations.of(context)!.no,
                            onPressed: onPressedNo,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
            PositionedDirectional(
              top: -35.r,
              start: 0,
              end: 0,
              child: Center(
                child: MyContainerShape(
                  width: 70.r,
                  height: 70.r,
                  borderRadius: 100,
                  child: Image.asset(
                    'assets/images/ic_user5.png',
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  static showEvaluationDialog(
    BuildContext context, {
    Function()? onPressedIsDone,
  }) {
    AlertDialog alert = AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(11.r)),
      backgroundColor: AppColors.TRANSPARENT,
      contentPadding: EdgeInsets.zero,
      titlePadding: EdgeInsets.zero,
      buttonPadding: EdgeInsets.zero,
      iconPadding: EdgeInsets.zero,
      insetPadding: EdgeInsets.zero,
      actionsPadding: EdgeInsets.zero,
      content: SizedBox(
        width: MediaQuery.of(context).size.width - 40.w,
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Positioned(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
                width: MediaQuery.of(context).size.width - 40.w,
                decoration: BoxDecoration(
                  color: AppColors.WHITE,
                  borderRadius: BorderRadius.circular(16.r),
                ),
                child: BlocBuilder<EvaluationCubit, EvaluationState>(
                  builder: (context, state) {
                    bool arriveOnTime =
                        EvaluationCubit.get(context).arriveOnTime;
                    bool vehicleCleanliness =
                        EvaluationCubit.get(context).vehicleCleanliness;

                    bool satisfactionWithService =
                        EvaluationCubit.get(context).satisfactionWithService;
                    return Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SizedBox(height: 30.h),
                        MyText(
                          title: AppLocalizations.of(context)!.evaluation,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                        SizedBox(height: 15.h),
                        MyText(
                          title:
                              AppLocalizations.of(context)!.didYouArriveOnTime,
                          fontSize: 14,
                        ),
                        SizedBox(height: 8.h),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            MyElevatedButton(
                              borderRaduis: 11,
                              height: 30,
                              width: 70,
                              title: AppLocalizations.of(context)!.yes,
                              onPressed: () {
                                EvaluationCubit.get(context)
                                    .changeArriveOnTime(true);
                              },
                              fontSize: 16,
                              background: arriveOnTime
                                  ? AppColors.GRAY3
                                  : AppColors.WHITE4,
                              titleColor: arriveOnTime
                                  ? AppColors.WHITE
                                  : AppColors.BLACK,
                              fontWeight: FontWeight.bold,
                            ),
                            SizedBox(width: 12.w),
                            MyElevatedButton(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              borderRaduis: 11,
                              height: 30,
                              width: 70,
                              titleColor: !arriveOnTime
                                  ? AppColors.WHITE
                                  : AppColors.BLACK,
                              background: !arriveOnTime
                                  ? AppColors.GRAY3
                                  : AppColors.WHITE4,
                              title: AppLocalizations.of(context)!.no,
                              onPressed: () {
                                EvaluationCubit.get(context)
                                    .changeArriveOnTime(false);
                              },
                            ),
                          ],
                        ),
                        SizedBox(height: 15.h),
                        MyText(
                          title: AppLocalizations.of(context)!
                              .areYouSatisfiedWithVehiclesCleanliness,
                          fontSize: 14,
                        ),
                        SizedBox(height: 8.h),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            MyElevatedButton(
                              borderRaduis: 11,
                              height: 30,
                              width: 70,
                              title: AppLocalizations.of(context)!.yes,
                              onPressed: () {
                                EvaluationCubit.get(context)
                                    .changeVehicleCleanliness(true);
                              },
                              fontSize: 16,
                              background: vehicleCleanliness
                                  ? AppColors.GRAY3
                                  : AppColors.WHITE4,
                              titleColor: vehicleCleanliness
                                  ? AppColors.WHITE
                                  : AppColors.BLACK,
                              fontWeight: FontWeight.bold,
                            ),
                            SizedBox(width: 12.w),
                            MyElevatedButton(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              borderRaduis: 11,
                              height: 30,
                              width: 70,
                              titleColor: !vehicleCleanliness
                                  ? AppColors.WHITE
                                  : AppColors.BLACK,
                              background: !vehicleCleanliness
                                  ? AppColors.GRAY3
                                  : AppColors.WHITE4,
                              title: AppLocalizations.of(context)!.no,
                              onPressed: () {
                                EvaluationCubit.get(context)
                                    .changeVehicleCleanliness(false);
                              },
                            ),
                          ],
                        ),
                        SizedBox(height: 15.h),
                        MyText(
                          title: AppLocalizations.of(context)!
                              .areYouSatisfiedWithService,
                          fontSize: 14,
                        ),
                        SizedBox(height: 8.h),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            MyElevatedButton(
                              borderRaduis: 11,
                              height: 30,
                              width: 70,
                              title: AppLocalizations.of(context)!.yes,
                              onPressed: () {
                                EvaluationCubit.get(context)
                                    .changeSatisfactionWithService(true);
                              },
                              fontSize: 16,
                              background: satisfactionWithService
                                  ? AppColors.GRAY3
                                  : AppColors.WHITE4,
                              titleColor: satisfactionWithService
                                  ? AppColors.WHITE
                                  : AppColors.BLACK,
                              fontWeight: FontWeight.bold,
                            ),
                            SizedBox(width: 12.w),
                            MyElevatedButton(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              borderRaduis: 11,
                              height: 30,
                              width: 70,
                              titleColor: !satisfactionWithService
                                  ? AppColors.WHITE
                                  : AppColors.BLACK,
                              background: !satisfactionWithService
                                  ? AppColors.GRAY3
                                  : AppColors.WHITE4,
                              title: AppLocalizations.of(context)!.no,
                              onPressed: () {
                                EvaluationCubit.get(context)
                                    .changeSatisfactionWithService(false);
                              },
                            ),
                          ],
                        ),
                        SizedBox(height: 30.h),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            MyElevatedButton(
                              height: 40,
                              width: 180,
                              title: AppLocalizations.of(context)!.done,
                              onPressed: onPressedIsDone,
                            ),
                          ],
                        ),
                      ],
                    );
                  },
                ),
              ),
            ),
            PositionedDirectional(
              top: -35.r,
              start: 0,
              end: 0,
              child: Center(
                child: MyContainerShape(
                  width: 70.r,
                  height: 70.r,
                  borderRadius: 100,
                  child: Image.asset(
                    'assets/images/ic_user5.png',
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  static showLoadingMapDialog(BuildContext context) {
    AlertDialog alert = AlertDialog(
      shadowColor: AppColors.TRANSPARENT,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(11.r)),
      backgroundColor: AppColors.TRANSPARENT,
      contentPadding: EdgeInsets.zero,
      titlePadding: EdgeInsets.zero,
      buttonPadding: EdgeInsets.zero,
      iconPadding: EdgeInsets.zero,
      insetPadding: EdgeInsets.zero,
      actionsPadding: EdgeInsets.zero,
      content: Center(
        child: SizedBox(
          width: 250.r,
          height: 250.r,
          child:
              LottieBuilder.asset('assets/images/ic_json/ic_loading_map.json'),
        ),
      ),
    );

    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  static showLoadingDialog(BuildContext context) {
    AlertDialog alert = AlertDialog(
      shadowColor: AppColors.TRANSPARENT,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(11.r)),
      backgroundColor: AppColors.TRANSPARENT,
      contentPadding: EdgeInsets.zero,
      titlePadding: EdgeInsets.zero,
      buttonPadding: EdgeInsets.zero,
      iconPadding: EdgeInsets.zero,
      insetPadding: EdgeInsets.zero,
      actionsPadding: EdgeInsets.zero,
      content: Center(
        child: LottieBuilder.asset(
          'assets/images/ic_json/loading2.json',
          width: 200.r,
        ),
      ),
    );

    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  static customDialog(
    BuildContext context, {
    required Function()? onPressedBack,
    required Function()? onPressedDelete,
    Color? iconColor = AppColors.RED,
    Color? baceColor = AppColors.RED,
    Color? desc1Color = AppColors.GRAY,
    double sizeHeader = 100,
    String? titleBace,
    double iconSize = 24,
    String? iconHeader = 'assets/images/ic_delete.svg',
    required String? titleHeader,
    bool png = false,
    bool isHeader = true,
    String? desc1,
    String? desc2,
    TextAlign textAlignDisk1 = TextAlign.start,
  }) {
    AlertDialog alert = AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.r)),
      backgroundColor: AppColors.WHITE,
      contentPadding: EdgeInsets.zero,
      titlePadding: EdgeInsets.zero,
      buttonPadding: EdgeInsets.zero,
      iconPadding: EdgeInsets.zero,
      insetPadding: EdgeInsets.zero,
      actionsPadding: EdgeInsets.zero,
      content: SizedBox(
        width: MediaQuery.of(context).size.width - 52.w,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (isHeader) ...[
              SizedBox(
                height: sizeHeader.h,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    iconHeader == null
                        ? const SizedBox()
                        : png
                            ? Image.asset(
                                iconHeader,
                                width: iconSize.w,
                                color: iconColor,
                              )
                            : SvgPicture.asset(
                                iconHeader,
                                width: 24.w,
                                color: iconColor,
                              ),
                    titleHeader != null && iconHeader != null
                        ? SizedBox(height: 10.h)
                        : const SizedBox(),
                    titleHeader == null
                        ? const SizedBox()
                        : MyText(
                            title: titleHeader,
                            fontSize: 14,
                            color: AppColors.RED,
                          ),
                  ],
                ),
              ),
              Divider(
                color: AppColors.BORDER,
                height: 1.h,
                thickness: 1,
              ),
            ],
            Container(
              padding: EdgeInsets.symmetric(horizontal: 14.w),
              decoration: BoxDecoration(
                color: AppColors.WHITE2,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(10.r),
                  bottomRight: Radius.circular(10.r),
                  topLeft:
                      isHeader ? Radius.circular(0) : Radius.circular(10.r),
                  topRight:
                      isHeader ? Radius.circular(0) : Radius.circular(10.r),
                ),
              ),
              child: Column(
                children: [
                  SizedBox(height: 20.h),
                  if (desc1 != null) ...[
                    MyText(
                      title: desc1,
                      textAlign: textAlignDisk1,
                      fontSize: 14,
                      color: desc1Color,
                    ),
                    SizedBox(height: 20.h),
                  ],
                  if (desc2 != null) ...[
                    MyText(
                      title: desc2,
                      fontSize: 14,
                    ),
                    SizedBox(height: 20.h),
                  ],
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      MyElevatedButton(
                        title: AppLocalizations.of(context)!.cancel,
                        width: 85,
                        fontSize: 14,
                        height: 35,
                        onPressed: onPressedBack,
                        background: AppColors.NAVY_BLUE,
                      ),
                      SizedBox(width: 20.w),
                      MyElevatedButton(
                        title: titleBace ?? AppLocalizations.of(context)!.yes,
                        width: 85,
                        height: 35,
                        fontSize: 14,
                        onPressed: onPressedDelete,
                        background: baceColor,
                      ),
                    ],
                  ),
                  SizedBox(height: 20.h),
                ],
              ),
            )
          ],
        ),
      ),
    );

    showDialog(
      barrierDismissible: true,
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  static Future enabledLocation(BuildContext context) async {
    showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: MyText(title: AppLocalizations.of(context)!.enableLocation),
        content: MyText(
          title: AppLocalizations.of(context)!
              .pleaseEnableLocationServicesToUseThisFeature,
          fontSize: 14,
          fontWeight: FontWeight.w400,
          color: AppColors.GRAY,
        ),
        actions: [
          TextButton(
            child: MyText(
              title: AppLocalizations.of(context)!.ok,
              fontWeight: FontWeight.w400,
              fontSize: 14,
            ),
            onPressed: () async {
              Navigator.of(context).pop();
              // Open the device's location settings
              await Geolocator.openLocationSettings();
            },
          ),
        ],
      ),
    );
  }

  static updateApplication(
    BuildContext context, {
    required Function()? onTap,
  }) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (_) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          title:
              MyText(title: AppLocalizations.of(context)!.updateTheApplication),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              MyText(
                title: AppLocalizations.of(context)!.descUpdateApp,
              ),
              const SizedBox(height: 20),
              GestureDetector(
                onTap: onTap,
                child: MyText(
                  title: AppLocalizations.of(context)!.updateTheApplication,
                  fontSize: 20,
                  color: AppColors.BASE_COLOR,
                ),
              )
            ],
          ),
        );
      },
    );
  }

  static showReorderDialog(
    BuildContext context, {
    required Function()? onPressedNo,
    required Function()? onPressedYes,
  }) {
    AlertDialog alert = AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(11.r)),
      backgroundColor: AppColors.TRANSPARENT,
      contentPadding: EdgeInsets.zero,
      titlePadding: EdgeInsets.zero,
      buttonPadding: EdgeInsets.zero,
      iconPadding: EdgeInsets.zero,
      insetPadding: EdgeInsets.zero,
      actionsPadding: EdgeInsets.zero,
      content: SizedBox(
        width: MediaQuery.of(context).size.width - 40.w,
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Positioned(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
                width: MediaQuery.of(context).size.width - 40.w,
                decoration: BoxDecoration(
                  color: AppColors.WHITE,
                  borderRadius: BorderRadius.circular(16.r),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(height: 20.h),
                    MyText(
                      title: AppLocalizations.of(context)!.doYouWantToReorder,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                    SizedBox(height: 50.h),
                    Row(
                      children: [
                        Expanded(
                          child: MyElevatedButton(
                            borderRaduis: 11,
                            height: 50,
                            title: AppLocalizations.of(context)!.yes,
                            onPressed: onPressedYes,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(width: 12.w),
                        Expanded(
                          child: MyElevatedButton(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            borderRaduis: 11,
                            height: 50,
                            titleColor: AppColors.BLACK,
                            background: AppColors.GREEN_LIGHT,
                            title: AppLocalizations.of(context)!.no,
                            onPressed: onPressedNo,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
            PositionedDirectional(
              top: -35.r,
              start: 0,
              end: 0,
              child: Center(
                child: MyContainerShape(
                  width: 70.r,
                  height: 70.r,
                  borderRadius: 100,
                  child: Image.asset(
                    'assets/images/ic_user5.png',
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
