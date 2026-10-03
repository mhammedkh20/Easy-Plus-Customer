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
import 'package:easy_plus_customer/features/main/model/response_app_config.dart';
import 'package:easy_plus_customer/features/main/views/manager/main_cubit/main_cubit.dart';
import 'package:easy_plus_customer/core/widgets/my_page_view.dart';
import 'package:easy_plus_customer/features/request_services/model/order_model.dart';
import 'package:easy_plus_customer/features/request_services/views/manager/service_cubit/service_cubit.dart';
import 'package:easy_plus_customer/features/request_services/views/pages/location_confirmation/location_confirmation_screen.dart';
import 'package:easy_plus_customer/features/request_services/views/widgets/custom_widget.dart';
import 'package:easy_plus_customer/features/request_services/views/widgets/icon_navigation_range.dart';
import 'package:easy_plus_customer/features/side_bar/views/pages/my_request_screens/details_current_order_screen.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:easy_plus_customer/core/widgets/my_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intl/intl.dart';

class ServiceOrderScreen extends StatefulWidget {
  final int categoryId;
  ServiceOrderScreen({super.key, required this.categoryId});

  @override
  State<ServiceOrderScreen> createState() => _ServiceOrderScreenState();
}

class _ServiceOrderScreenState extends State<ServiceOrderScreen> {
  var _keyForm = GlobalKey<FormState>();

  final TextEditingController _detailsController = TextEditingController();

  final TextEditingController _startLocationController =
      TextEditingController();
  final TextEditingController _dateOrderDeliveredController =
      TextEditingController();

  double? startLat;

  double? startLng;

  final TextEditingController _endLocationController = TextEditingController();

  final TextEditingController _initPriceController = TextEditingController();
  double? endLat;
  double? endLng;
  int idDeliveryType = 0;
  int idNavigationRangeType = 0;
  DateTime selectedDate = DateTime.now();
  final format = DateFormat("yyyy-MM-dd - HH:mm:ss");

  @override
  void initState() {
    ServiceCubit.get(context).getSlider(context, categoryId: widget.categoryId);
    _dateOrderDeliveredController.text =
        DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now());
    ServiceCubit.get(context).indexDriversGender = 0;
    ServiceCubit.get(context).indexReservationPeriod = 2;
    super.initState();
  }

  @override
  void deactivate() {
    ServiceCubit.get(context).indexDriversGender = 0;
    super.deactivate();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.BG_SCAFOLLD,
      appBar: MyAppBar(
        title: AppLocalizations.of(context)!.delivery,
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
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                MyTextField(
                  controller: _startLocationController,
                  textHint: AppLocalizations.of(context)!
                      .theAddressOfReceivingTheRequest,
                  filledColor: true,
                  isBorder: true,
                  colorBorder: AppColors.WHITE2,
                  fillColor: AppColors.WHITE,
                  fillColor2: AppColors.WHITE,
                  readOnly: true,
                  prefixIcon: Padding(
                    padding: EdgeInsetsDirectional.only(start: 9.w, end: 5.w),
                    child: SvgPicture.asset(
                      'assets/images/ic_gps.svg',
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
                      _startLocationController.text =
                          locationData['details_location'];
                      startLat = locationData['lat'];
                      startLng = locationData['lng'];
                    }
                    _startLocationController.selection =
                        TextSelection.fromPosition(TextPosition(
                            offset: _startLocationController.text.length));
                  },
                  validator: (String? s) {
                    if (s == null || s.trim().isEmpty) {
                      return AppLocalizations.of(context)!.pleaseSelectLocation;
                    }

                    return null;
                  },
                ),
                SizedBox(height: 16.h),
                MyTextField(
                  controller: _endLocationController,
                  textHint: AppLocalizations.of(context)!
                      .theDeliveryAddressOfTheOrder,
                  filledColor: true,
                  isBorder: true,
                  colorBorder: AppColors.WHITE2,
                  fillColor: AppColors.WHITE,
                  fillColor2: AppColors.WHITE,
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
                      _endLocationController.text =
                          locationData['details_location'];
                      endLat = locationData['lat'];
                      endLng = locationData['lng'];
                    }
                    _endLocationController.selection =
                        TextSelection.fromPosition(TextPosition(
                            offset: _endLocationController.text.length));
                  },
                  validator: (String? s) {
                    if (s == null || s.trim().isEmpty) {
                      return AppLocalizations.of(context)!.pleaseSelectLocation;
                    }

                    return null;
                  },
                ),
                BlocBuilder<ServiceCubit, ServiceState>(
                  builder: (context, state) {
                    int indexSelected =
                        ServiceCubit.get(context).indexReservationPeriod;

                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SizedBox(height: 16.h),
                        MyText(
                          title: AppLocalizations.of(context)!
                              .implementationPeriod,
                          color: AppColors.GRAY3,
                        ),
                        SizedBox(height: 12.h),
                        Row(
                          children: [
                            IconNavigationRange(
                              width: 100,
                              isSelected: indexSelected == 2,
                              title: AppLocalizations.of(context)!.day,
                              onTap: () {
                                ServiceCubit.get(context)
                                    .changeReservationPeriod(2);
                              },
                            ),
                            SizedBox(width: 16.w),
                            IconNavigationRange(
                              width: 100,
                              isSelected: indexSelected == 1,
                              title: AppLocalizations.of(context)!.hour,
                              onTap: () {
                                ServiceCubit.get(context)
                                    .changeReservationPeriod(1);
                              },
                            ),
                          ],
                        ),
                        SizedBox(height: 12.h),
                        CustomWidget(
                          title: indexSelected == 2
                              ? AppLocalizations.of(context)!.theNumberOfDays
                              : AppLocalizations.of(context)!.theNumberOfHours,
                          iconPath: 'assets/images/ic_number_of_seats.svg',
                          onPressedDecrease: () {
                            ServiceCubit.get(context).decreaseHours();
                          },
                          onPressedIncrease: () {
                            ServiceCubit.get(context).increaseHours();
                          },
                          value: ServiceCubit.get(context).numberOfHours,
                        ),
                      ],
                    );
                  },
                ),
                SizedBox(height: 16.h),
                BlocBuilder<ServiceCubit, ServiceState>(
                  builder: (context, state) {
                    int indexSelected =
                        ServiceCubit.get(context).indexRequestCategory;
                    bool statusExpanded =
                        ServiceCubit.get(context).isExpandedRequestCategory;

                    idDeliveryType = MainCubit.get(context)
                        .appConfig!
                        .ordersTypes![indexSelected]
                        .id!;

                    List<CustomClass>? ordersTypes =
                        MainCubit.get(context).appConfig!.ordersTypes!;
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
                                  'assets/images/ic_product.svg',
                                  width: 16.r,
                                ),
                                SizedBox(width: 8.w),
                                MyText(
                                  title: AppLocalizations.of(context)!
                                      .requestCategory,
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
                                        .changeIsExpandedRequestCategory(
                                            !statusExpanded);
                                  },
                                  icon: Transform.rotate(
                                    angle: statusExpanded
                                        ? pi * (0 / 4)
                                        : pi * (4 / 4),
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
                                    ListView.builder(
                                      padding: EdgeInsets.zero,
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      shrinkWrap: true,
                                      itemCount: ordersTypes.length,
                                      itemBuilder: (context, index) {
                                        return ItemRadio(
                                          title: MainCubit.get(context)
                                                  .appConfig!
                                                  .ordersTypes![index]
                                                  .name ??
                                              "",
                                          onChanged: (int? index) {
                                            if (index != null) {
                                              ServiceCubit.get(context)
                                                  .indexDriversGender = 0;

                                              ServiceCubit.get(context)
                                                  .changeRequestCategory(index);
                                            }
                                          },
                                          value: indexSelected,
                                          indexKey: index,
                                        );
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
                SizedBox(height: 16.h),
                BlocBuilder<ServiceCubit, ServiceState>(
                  builder: (context, state) {
                    int indexSelected =
                        ServiceCubit.get(context).indexDriversGender;
                    List<CustomClass> genders = MainCubit.get(context)
                            .appConfig!
                            .ordersTypes![
                                ServiceCubit.get(context).indexRequestCategory]
                            .driverGender2 ??
                        [];
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        MyText(
                          title: AppLocalizations.of(context)!.driverGender,
                          color: AppColors.GRAY3,
                        ),
                        SizedBox(height: 12.h),
                        genders.length != 0
                            ? SizedBox(
                                height: 40.h,
                                child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: genders.length,
                                  itemBuilder: (context, index) {
                                    return Row(
                                      children: [
                                        IconNavigationRange(
                                          width: 100,
                                          isSelected: indexSelected == index,
                                          title: genders[index].name ?? "",
                                          onTap: () {
                                            ServiceCubit.get(context)
                                                .changeDriversGender(index);
                                          },
                                        ),
                                        SizedBox(width: 10.w),
                                      ],
                                    );
                                  },
                                ),
                              )
                            : Row(
                                children: [
                                  IconNavigationRange(
                                    isSelected: indexSelected == 2,
                                    title: AppLocalizations.of(context)!.all,
                                    onTap: () {
                                      ServiceCubit.get(context)
                                          .changeDriversGender(2);
                                    },
                                  ),
                                  SizedBox(width: 10.w),
                                  IconNavigationRange(
                                    isSelected: indexSelected == 0,
                                    title: AppLocalizations.of(context)!.male,
                                    onTap: () {
                                      ServiceCubit.get(context)
                                          .changeDriversGender(0);
                                    },
                                  ),
                                  SizedBox(width: 10.w),
                                  IconNavigationRange(
                                    isSelected: indexSelected == 1,
                                    title: AppLocalizations.of(context)!.female,
                                    onTap: () {
                                      ServiceCubit.get(context)
                                          .changeDriversGender(1);
                                    },
                                  ),
                                ],
                              ),
                      ],
                    );
                  },
                ),
                SizedBox(height: 16.h),
                MyText(
                  title: AppLocalizations.of(context)!.navigationRange,
                  color: AppColors.GRAY3,
                ),
                SizedBox(height: 12.h),
                BlocBuilder<ServiceCubit, ServiceState>(
                  builder: (context, state) {
                    int indexSelected =
                        ServiceCubit.get(context).indexTypeNavigationRange;
                    idNavigationRangeType = MainCubit.get(context)
                        .appConfig!
                        .navRangeTypes![indexSelected]
                        .id!;

                    return SizedBox(
                      height: 40.h,
                      child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: MainCubit.get(context)
                              .appConfig!
                              .navRangeTypes!
                              .length,
                          itemBuilder: (context, index) {
                            return Row(
                              children: [
                                IconNavigationRange(
                                  width: 100,
                                  isSelected: indexSelected == index,
                                  title: MainCubit.get(context)
                                          .appConfig!
                                          .navRangeTypes![index]
                                          .name ??
                                      "",
                                  onTap: () {
                                    ServiceCubit.get(context)
                                        .indexRequestCategory = 0;
                                    ServiceCubit.get(context)
                                        .changeTypeNavigationRange(index);
                                  },
                                ),
                                SizedBox(width: 16.w),
                              ],
                            );
                          }),
                    );
                  },
                ),
                SizedBox(height: 16.h),
                MyText(
                  title: AppLocalizations.of(context)!.dateOrderDelivered,
                  color: AppColors.GRAY3,
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
                  controller: _dateOrderDeliveredController,
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
                        _dateOrderDeliveredController.text =
                            DateFormat('yyyy-MM-dd HH:mm:ss')
                                .format(DateTimeField.combine(date, time));
                        return DateTimeField.combine(date, time);
                      } else {
                        return currentValue;
                      }
                    });
                  },
                ),
                SizedBox(height: 11.h),
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
                  validator: (String? s) {
                    if (s == null || s.isEmpty) {
                      return AppLocalizations.of(context)!.pleaseEnterDetails;
                    }

                    return null;
                  },
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
                        message:
                            AppLocalizations.of(context)!.waitingReceiveOffers,
                      );
                    }
                    if (state is SendOrderFailed) {
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
                          print(selectedDate.toString());
                          await ServiceCubit.get(context).sendOrder(
                            context,
                            order: OrderModel(
                              categoryId: widget.categoryId,
                              startLng: startLng,
                              startLat: startLat,
                              endLat: endLat,
                              endLng: endLng,
                              orderTypeId: idDeliveryType,
                              navRangeId: idNavigationRangeType,
                              desc: _detailsController.text.trim().isNotEmpty
                                  ? AppHelpers.getTextWithoutNum(
                                      _detailsController.text.trim())
                                  : null,
                              driverGenderId: ServiceCubit.get(context)
                                          .indexDriversGender ==
                                      0
                                  ? 1
                                  : ServiceCubit.get(context)
                                              .indexDriversGender ==
                                          1
                                      ? 2
                                      : 3,
                              startDate: selectedDate,
                              startAddress: _startLocationController.text,
                              duration: AppHelpers.getDuration(context),
                              daysCount: ServiceCubit.get(context)
                                  .numberOfHours
                                  .toString(),
                              endAddress: _endLocationController.text,
                              initilPrice: _initPriceController.text.isNotEmpty
                                  ? double.parse(AppHelpers.getNumberEnglish(
                                      _initPriceController.text))
                                  : 0,
                            ),
                          );
                        }
                      },
                    );
                  },
                ),
              ],
            ),
          ),
          SizedBox(height: 40.h),
        ],
      ),
    );
  }
}
