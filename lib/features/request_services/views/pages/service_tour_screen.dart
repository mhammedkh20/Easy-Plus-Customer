import 'dart:math';
import 'package:datetime_picker_formfield_new/datetime_picker_formfield.dart';
import 'package:easy_plus_customer/core/utils/app_colors.dart';
import 'package:easy_plus_customer/core/utils/app_helpers.dart';
import 'package:easy_plus_customer/core/widgets/item_radio.dart';
import 'package:easy_plus_customer/core/widgets/loading_widget.dart';
import 'package:easy_plus_customer/core/widgets/my_contianer_shape.dart';
import 'package:easy_plus_customer/core/widgets/my_elevated_button.dart';
import 'package:easy_plus_customer/core/widgets/my_text.dart';
import 'package:easy_plus_customer/core/widgets/my_text_field.dart';
import 'package:easy_plus_customer/features/main/views/manager/main_cubit/main_cubit.dart';
import 'package:easy_plus_customer/core/widgets/my_page_view.dart';
import 'package:easy_plus_customer/features/request_services/model/order_model.dart';
import 'package:easy_plus_customer/features/request_services/views/manager/service_cubit/service_cubit.dart';
import 'package:easy_plus_customer/features/request_services/views/pages/location_confirmation/location_confirmation_screen.dart';
import 'package:easy_plus_customer/features/request_services/views/widgets/icon_navigation_range.dart';
import 'package:easy_plus_customer/features/side_bar/views/pages/my_request_screens/details_current_order_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:easy_plus_customer/core/widgets/my_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intl/intl.dart';

class ServiceTourScreen extends StatefulWidget {
  final int categoryId;

  ServiceTourScreen({super.key, required this.categoryId});

  @override
  State<ServiceTourScreen> createState() => _ServiceTourScreenState();
}

class _ServiceTourScreenState extends State<ServiceTourScreen> {
  var _keyForm = GlobalKey<FormState>();

  final TextEditingController _detailsController = TextEditingController();

  final TextEditingController _locationController = TextEditingController();

  final TextEditingController _initPriceController = TextEditingController();
  final TextEditingController _tourStartDateController =
      TextEditingController();

  DateTime selectedDate = DateTime.now();
  final format = DateFormat("yyyy-MM-dd - HH:mm:ss");
  double? lat;

  double? lng;

  int idTourType = 0;
  bool isLoad = true;

  @override
  void initState() {
    ServiceCubit.get(context).getSlider(context, categoryId: widget.categoryId);
    _tourStartDateController.text =
        DateFormat('yyyy-MM-dd - HH:mm:ss').format(DateTime.now());

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.BG_SCAFOLLD,
      appBar: MyAppBar(
        title: AppLocalizations.of(context)!.tour,
        backgroundColor: AppColors.BG_SCAFOLLD,
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 0),
        children: [
          SizedBox(height: 12.h),
          BlocConsumer<ServiceCubit, ServiceState>(
            listener: (context, state) {
              if (state is SliderFailed) {
                AppHelpers.showSnackBar(context,
                    message: state.message, error: true);
              }
            },
            builder: (context, state) {
              if (state is SliderLoading) {
                return SizedBox(
                  height: 180.h,
                );
              }
              List<String> images = ServiceCubit.get(context).slider;
              if (images.length == 0) {
                return SizedBox(
                  height: 180.h,
                );
              }
              return MyPageView(
                images: images,
                withAnimation: true,
              );
            },
          ),
          SizedBox(height: 14.h),
          Form(
            key: _keyForm,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                MyTextField(
                  controller: _locationController,
                  textHint: AppLocalizations.of(context)!
                      .theMeetingAddressToStartTheTour,
                  filledColor: true,
                  isBorder: true,
                  colorBorder: AppColors.WHITE2,
                  fillColor: AppColors.WHITE,
                  fillColor2: AppColors.WHITE,
                  borderSide: AppColors.WHITE,
                  readOnly: true,
                  prefixIcon: Padding(
                    padding: EdgeInsetsDirectional.only(start: 9.w, end: 5.w),
                    child: SvgPicture.asset(
                      'assets/images/ic_location.svg',
                      width: 19.w,
                      height: 19.h,
                    ),
                  ),
                  onTap: () async {
                    Map<String, dynamic>? locationData =
                        await AppHelpers.navigationToPage(
                      context,
                      LocationConfirmationScreen(),
                    );
                    if (locationData != null) {
                      _locationController.text =
                          locationData['details_location'];
                      lat = locationData['lat'];
                      lng = locationData['lng'];
                    }
                    _locationController.selection = TextSelection.fromPosition(
                        TextPosition(offset: _locationController.text.length));
                  },
                  validator: (String? s) {
                    if (s == null || s.trim().isEmpty) {
                      return AppLocalizations.of(context)!.pleaseSelectLocation;
                    }

                    return null;
                  },
                ),
                SizedBox(height: 6.h),
                MyText(
                  title: AppLocalizations.of(context)!.tourType,
                  color: AppColors.GRAY3,
                ),
                SizedBox(height: 16.h),
                BlocBuilder<ServiceCubit, ServiceState>(
                  builder: (context, state) {
                    int indexSelected = ServiceCubit.get(context).indexTourType;
                    return Row(
                      children: [
                        IconNavigationRange(
                          isSelected: indexSelected == 0,
                          title:
                              AppLocalizations.of(context)!.entertainmentTour,
                          width: 150,
                          onTap: () {
                            ServiceCubit.get(context).changeTourType(0);
                          },
                        ),
                        SizedBox(width: 16.w),
                        IconNavigationRange(
                          isSelected: indexSelected == 1,
                          width: 150,
                          title: AppLocalizations.of(context)!.trainingTour,
                          onTap: () {
                            ServiceCubit.get(context).changeTourType(1);
                          },
                        ),
                      ],
                    );
                  },
                ),
                SizedBox(height: 23.h),
                BlocBuilder<ServiceCubit, ServiceState>(
                  builder: (context, state) {
                    int indexSelected =
                        ServiceCubit.get(context).indexRoundCategory;
                    bool statusExpanded =
                        ServiceCubit.get(context).isExpandedTourType;
                    idTourType = MainCubit.get(context)
                        .appConfig!
                        .tourTypes![indexSelected]
                        .id!;

                    int indexType = ServiceCubit.get(context).indexTourType;

                    if (isLoad) {
                      isLoad = false;
                      if (MainCubit.get(context).appConfig!.tourTypes!.length >
                          0) {
                        String? gender = MainCubit.get(context)
                            .appConfig!
                            .tourTypes![
                                ServiceCubit.get(context).indexRoundCategory]
                            .driverGender;
                        if ((gender == 'Female' || gender == 'انثى')) {
                          ServiceCubit.get(context).changeDriversGender(1);
                        } else if (gender == 'Male' || gender == 'ذكر') {
                          ServiceCubit.get(context).changeDriversGender(0);
                        } else {
                          ServiceCubit.get(context).changeDriversGender(2);
                        }
                      }
                    }
                    return MyContainerShape(
                      bgContainer: AppColors.WHITE,
                      paddingHorizontal: 0,
                      paddingVertical: 0,
                      enableShadow: false,
                      borderRadius: 11,
                      child: Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 12.w, vertical: 10.h),
                            child: Row(
                              children: [
                                SvgPicture.asset(
                                  'assets/images/ic_motorcycle.svg',
                                  width: 16.r,
                                ),
                                SizedBox(width: 8.w),
                                MyText(
                                  title: AppLocalizations.of(context)!
                                      .roundCategory,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: AppColors.ICON_COLOR,
                                ),
                                const Spacer(),
                                IconButton(
                                  constraints: const BoxConstraints(),
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 4.r, vertical: 4.r),
                                  splashColor: AppColors.TRANSPARENT,
                                  onPressed: () {
                                    ServiceCubit.get(context)
                                        .changeIsExpandedTourType(
                                            !statusExpanded);
                                  },
                                  icon: Transform.rotate(
                                    angle: statusExpanded
                                        ? pi * (4 / 4)
                                        : pi * (0 / 4),
                                    child: SvgPicture.asset(
                                      'assets/images/arrows/ic_arrow_up.svg',
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                          Divider(
                            height: 1,
                            thickness: 1,
                            color: AppColors.ICON_COLOR.withOpacity(.3),
                          ),
                          Padding(
                            padding: EdgeInsetsDirectional.only(start: 35.w),
                            child: AnimatedSize(
                              duration: const Duration(milliseconds: 300),
                              child: SizedBox(
                                height: statusExpanded ? null : 0,
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    SizedBox(height: 12.h),
                                    indexType == 1
                                        ? ListView.builder(
                                            padding: EdgeInsets.zero,
                                            physics:
                                                const NeverScrollableScrollPhysics(),
                                            shrinkWrap: true,
                                            itemCount: MainCubit.get(context)
                                                .appConfig!
                                                .tourTypes!
                                                .length,
                                            itemBuilder: (context, index) {
                                              if (indexType == 1 &&
                                                  MainCubit.get(context)
                                                          .appConfig!
                                                          .tourTypes![index]
                                                          .type ==
                                                      'training') {
                                                return ItemRadio(
                                                  title: MainCubit.get(context)
                                                          .appConfig!
                                                          .tourTypes![index]
                                                          .name ??
                                                      "",
                                                  onChanged: (int? index) {
                                                    if (index != null) {
                                                      ServiceCubit.get(context)
                                                          .changeRoundCategory(
                                                              index);
                                                    }
                                                  },
                                                  value: indexSelected,
                                                  indexKey: index,
                                                );
                                              } else {
                                                return SizedBox();
                                              }
                                            },
                                          )
                                        : ListView.builder(
                                            padding: EdgeInsets.zero,
                                            physics:
                                                const NeverScrollableScrollPhysics(),
                                            shrinkWrap: true,
                                            itemCount: MainCubit.get(context)
                                                .appConfig!
                                                .tourTypes!
                                                .length,
                                            itemBuilder: (context, index) {
                                              if (indexType == 0 &&
                                                  MainCubit.get(context)
                                                          .appConfig!
                                                          .tourTypes![index]
                                                          .type ==
                                                      'entertainment') {
                                                return ItemRadio(
                                                  title: MainCubit.get(context)
                                                          .appConfig!
                                                          .tourTypes![index]
                                                          .name ??
                                                      "",
                                                  onChanged: (int? index) {
                                                    if (index != null) {
                                                      ServiceCubit.get(context)
                                                          .changeRoundCategory(
                                                              index);
                                                      String? gender = MainCubit
                                                              .get(context)
                                                          .appConfig!
                                                          .tourTypes![ServiceCubit
                                                                  .get(context)
                                                              .indexRoundCategory]
                                                          .driverGender;
                                                      if ((gender == 'Female' ||
                                                          gender == 'انثى')) {
                                                        ServiceCubit.get(
                                                                context)
                                                            .changeDriversGender(
                                                                1);
                                                      } else if (gender ==
                                                              'Male' ||
                                                          gender == 'ذكر') {
                                                        ServiceCubit.get(
                                                                context)
                                                            .changeDriversGender(
                                                                0);
                                                      } else {
                                                        ServiceCubit.get(
                                                                context)
                                                            .changeDriversGender(
                                                                2);
                                                      }
                                                    }
                                                  },
                                                  value: indexSelected,
                                                  indexKey: index,
                                                );
                                              } else {
                                                return SizedBox();
                                              }
                                            },
                                          ),
                                    SizedBox(height: 14.h),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
                SizedBox(height: 12.h),
                Align(
                  alignment: AlignmentDirectional.centerStart,
                  child: MyText(
                    title: AppLocalizations.of(context)!.tourStartDate,
                    color: AppColors.GRAY3,
                  ),
                ),
                SizedBox(height: 12.h),
                DateTimeField(
                  decoration: InputDecoration(
                    hintStyle: TextStyle(
                      fontFamily: 'Montserrat',
                      fontSize: 14.sp,
                      color: AppColors.GRAY,
                    ),
                    hintText: AppLocalizations.of(context)!.reviewDate,
                    fillColor: AppColors.WHITE,
                    filled: true,
                    enabledBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: AppColors.TRANSPARENT),
                    ),
                    focusedBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: AppColors.BASE_COLOR),
                    ),
                    errorBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: AppColors.RED),
                    ),
                  ),
                  controller: _tourStartDateController,
                  format: format,
                  onShowPicker: (context, currentValue) async {
                    return await showDatePicker(
                      context: context,
                      firstDate: DateTime(1900),
                      initialDate: currentValue ?? DateTime.now(),
                      lastDate: DateTime(2100),
                    ).then((DateTime? date) async {
                      if (date != null) {
                        final time = await showTimePicker(
                          context: context,
                          initialTime: TimeOfDay.fromDateTime(
                              currentValue ?? DateTime.now()),
                        );
                        selectedDate = DateTimeField.combine(date, time);
                        _tourStartDateController.text =
                            DateFormat('yyyy-MM-dd HH:mm:ss')
                                .format(DateTimeField.combine(date, time));
                        return DateTimeField.combine(date, time);
                      } else {
                        return currentValue;
                      }
                    });
                  },
                ),
                SizedBox(height: 16.h),
                BlocBuilder<ServiceCubit, ServiceState>(
                  builder: (context, state) {
                    int indexSelected =
                        ServiceCubit.get(context).indexDriversGender;
                    String? gender = MainCubit.get(context)
                        .appConfig!
                        .tourTypes![
                            ServiceCubit.get(context).indexRoundCategory]
                        .driverGender;

                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        MyText(
                          title: ServiceCubit.get(context).indexTourType == 0
                              ? AppLocalizations.of(context)!.driverGender
                              : AppLocalizations.of(context)!.coachGender,
                          color: AppColors.GRAY3,
                        ),
                        SizedBox(height: 12.h),
                        Row(
                          children: [
                            if (gender == null ||
                                gender == 'All' ||
                                gender == 'الكل') ...[
                              IconNavigationRange(
                                isSelected: indexSelected == 2,
                                title: AppLocalizations.of(context)!.all,
                                onTap: () {
                                  ServiceCubit.get(context)
                                      .changeDriversGender(2);
                                },
                              ),
                              SizedBox(width: 10.w),
                            ],
                            if (gender == null ||
                                gender == 'Female' ||
                                gender == 'انثى') ...[
                              IconNavigationRange(
                                isSelected: indexSelected == 1,
                                title: AppLocalizations.of(context)!.female,
                                onTap: () {
                                  ServiceCubit.get(context)
                                      .changeDriversGender(1);
                                },
                              ),
                            ],
                            if (gender == null ||
                                gender == 'Male' ||
                                gender == 'ذكر') ...[
                              SizedBox(width: 10.w),
                              IconNavigationRange(
                                isSelected: indexSelected == 0,
                                title: AppLocalizations.of(context)!.male,
                                onTap: () {
                                  ServiceCubit.get(context)
                                      .changeDriversGender(0);
                                },
                              ),
                            ],
                          ],
                        ),
                      ],
                    );
                  },
                ),
                SizedBox(height: 16.h),
                MyText(
                  title: AppLocalizations.of(context)!.reservationPeriod,
                  color: AppColors.GRAY3,
                ),
                SizedBox(height: 12.h),
                BlocBuilder<ServiceCubit, ServiceState>(
                  builder: (context, state) {
                    int indexSelected =
                        ServiceCubit.get(context).indexReservationPeriod;
                    return Row(
                      children: [
                        IconNavigationRange(
                          isSelected: indexSelected == 0,
                          title: AppLocalizations.of(context)!.tour, //جولة
                          onTap: () {
                            ServiceCubit.get(context)
                                .changeReservationPeriod(0);
                          },
                        ),
                        SizedBox(width: 16.w),
                        IconNavigationRange(
                          isSelected: indexSelected == 1,
                          title: AppLocalizations.of(context)!.hour,
                          onTap: () {
                            ServiceCubit.get(context)
                                .changeReservationPeriod(1);
                          },
                        ),
                        SizedBox(width: 16.w),
                        IconNavigationRange(
                          isSelected: indexSelected == 2,
                          title: AppLocalizations.of(context)!.day,
                          onTap: () {
                            ServiceCubit.get(context)
                                .changeReservationPeriod(2);
                          },
                        ),
                      ],
                    );
                  },
                ),
                SizedBox(height: 12.h),
                MyContainerShape(
                  paddingHorizontal: 12,
                  paddingVertical: 10,
                  borderRadius: 11,
                  enableShadow: false,
                  child: Row(
                    children: [
                      SvgPicture.asset('assets/images/ic_clock.svg'),
                      SizedBox(width: 8.w),
                      BlocBuilder<ServiceCubit, ServiceState>(
                        builder: (context, state) {
                          return MyText(
                            title: getText(
                              context,
                              ServiceCubit.get(context).indexReservationPeriod,
                            ),
                            color: AppColors.GRAY3,
                            fontSize: 12,
                          );
                        },
                      ),
                      const Spacer(),
                      IconButton(
                        splashColor: AppColors.TRANSPARENT,
                        constraints: const BoxConstraints(),
                        padding: EdgeInsets.symmetric(
                            horizontal: 4.r, vertical: 4.r),
                        onPressed: () {
                          ServiceCubit.get(context).increaseHours();
                        },
                        icon: const Icon(
                          Icons.add,
                          color: AppColors.ICON_PLUS,
                        ),
                      ),
                      SizedBox(width: 5.w),
                      MyContainerShape(
                        height: 32.r,
                        width: 32.r,
                        bgContainer: AppColors.GRAY3,
                        enableShadow: false,
                        borderRadius: 50,
                        child: BlocBuilder<ServiceCubit, ServiceState>(
                          builder: (context, state) {
                            return MyText(
                              title:
                                  '${ServiceCubit.get(context).numberOfHours}',
                              color: AppColors.WHITE,
                              fontSize: 14,
                            );
                          },
                        ),
                      ),
                      SizedBox(width: 5.w),
                      IconButton(
                        splashColor: AppColors.TRANSPARENT,
                        constraints: const BoxConstraints(),
                        padding: EdgeInsets.symmetric(
                            horizontal: 4.r, vertical: 4.r),
                        onPressed: () {
                          ServiceCubit.get(context).decreaseHours();
                        },
                        icon: const Icon(
                          Icons.remove,
                          color: AppColors.ICON_PLUS,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 16.h),
                MyTextField(
                  controller: _initPriceController,
                  textHint: AppLocalizations.of(context)!.initialPrice,
                  filledColor: true,
                  fillColor2: AppColors.WHITE,
                  fillColor: AppColors.WHITE,
                  colorBorder: AppColors.WHITE,
                  keyboardType: TextInputType.number,
                  borderSide: AppColors.WHITE,
                  paddingHorizontal: 14.w,
                  paddingVertical: 10.h,
                  isBorder: true,
                ),
                SizedBox(height: 12.h),
                MyTextField(
                  controller: _detailsController,
                  textHint: AppLocalizations.of(context)!.details,
                  filledColor: true,
                  fillColor2: AppColors.WHITE,
                  fillColor: AppColors.WHITE,
                  maxLines: 8,
                  colorBorder: AppColors.WHITE,
                  borderSide: AppColors.WHITE,
                  paddingHorizontal: 14.w,
                  paddingVertical: 10.h,
                  isBorder: true,
                ),
              ],
            ),
          ),
          SizedBox(height: 32.h),
          BlocConsumer<ServiceCubit, ServiceState>(
            listener: (context, state) {
              if (state is SendOrderSuccess) {
                AppHelpers.showSnackBar(context, message: state.message);
                AppHelpers.navigationReplacementToPage(
                  context,
                  DetailsCurrentOrderScreen(
                    orderId: state.orderId.toString(),
                  ),
                );

                AppHelpers.showSnackBar(
                  context,
                  message: AppLocalizations.of(context)!.waitingReceiveOffers,
                );
              }
              if (state is SendOrderFailed) {
                print('state.orderId ');

                AppHelpers.showSnackBar(
                  context,
                  message: state.message,
                  error: true,
                );
              }
            },
            builder: (context, state) {
              if (state is SendOrderLoading) {
                return const LoadingWidget();
              }
              return MyElevatedButton(
                title: AppLocalizations.of(context)!.sendRequest,
                onPressed: () async {
                  if (_keyForm.currentState!.validate()) {
                    await ServiceCubit.get(context).sendOrder(
                      context,
                      order: OrderModel(
                        categoryId: widget.categoryId,
                        startLng: lng,
                        startLat: lat,
                        tourTypeId: idTourType,
                        tourType: ServiceCubit.get(context).indexTourType == 0
                            ? 'entertainment'
                            : 'training',
                        tourTime: ServiceCubit.get(context).numberOfHours,
                        desc: _detailsController.text.trim().isNotEmpty
                            ? AppHelpers.getTextWithoutNum(
                                _detailsController.text.trim())
                            : null,
                        duration: AppHelpers.getDuration(context),
                        startAddress: _locationController.text,
                        initilPrice: _initPriceController.text.isNotEmpty
                            ? double.parse(
                                AppHelpers.getNumberEnglish(
                                    _initPriceController.text),
                              )
                            : 0,
                        driverGenderId: ServiceCubit.get(context)
                                    .indexDriversGender ==
                                0
                            ? 1
                            : ServiceCubit.get(context).indexDriversGender == 1
                                ? 2
                                : 3,
                        startDate: selectedDate,
                      ),
                    );
                  }
                },
              );
            },
          ),
          SizedBox(height: 40.h),
        ],
      ),
    );
  }

  String getText(BuildContext context, int index) {
    if (index == 0) {
      return AppLocalizations.of(context)!.pleaseAddNumberRounds;
    } else if (index == 1) {
      return AppLocalizations.of(context)!.pleaseAddNumberHours;
    } else {
      return AppLocalizations.of(context)!.pleaseAddNumberDays;
    }
  }
}
