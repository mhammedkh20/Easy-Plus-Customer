import 'dart:io';

import 'package:datetime_picker_formfield_new/datetime_picker_formfield.dart';
import 'package:easy_plus_customer/core/utils/app_colors.dart';
import 'package:easy_plus_customer/core/utils/app_helpers.dart';
import 'package:easy_plus_customer/core/widgets/custom_dropdown_menu2.dart';
import 'package:easy_plus_customer/core/widgets/loading_widget.dart';
import 'package:easy_plus_customer/core/widgets/my_app_bar.dart';
import 'package:easy_plus_customer/core/widgets/my_contianer_shape.dart';
import 'package:easy_plus_customer/core/widgets/my_elevated_button.dart';
import 'package:easy_plus_customer/core/widgets/my_text.dart';
import 'package:easy_plus_customer/core/widgets/my_text_field.dart';
import 'package:easy_plus_customer/features/side_bar/views/manager/compliants_cubit/complaints_cubit.dart';
import 'package:easy_plus_customer/features/side_bar/views/manager/side_bar_cubit/side_bar_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intl/intl.dart';

class ReportMissingScreen extends StatefulWidget {
  ReportMissingScreen({super.key});

  @override
  State<ReportMissingScreen> createState() => _ReportMissingScreenState();
}

class _ReportMissingScreenState extends State<ReportMissingScreen> {
  @override
  void initState() {
    if (ComplaintsCubit.get(context).orderIds.length == 0) {
      ComplaintsCubit.get(context).getShowOrderIds(context);
    }
    _timeOutController.text = DateFormat('yyyy-MM-dd').format(DateTime.now());

    super.initState();
  }

  @override
  void deactivate() {
    ComplaintsCubit.get(context).imagesLostItems.clear();
    super.deactivate();
  }

  final _keyForm = GlobalKey<FormState>();

  final TextEditingController _numberController = TextEditingController();

  final TextEditingController _timeOutController = TextEditingController();

  final TextEditingController _orderNumberController = TextEditingController();

  final TextEditingController _messageController = TextEditingController();
  final format = DateFormat("yyyy-MM-dd HH:mm:ss");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.BG_SCAFOLLD,
      appBar: MyAppBar(
        backgroundColor: AppColors.BG_SCAFOLLD,
        title: AppLocalizations.of(context)!.reportMissing,
      ),
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          children: [
            SizedBox(height: 16.h),
            MyContainerShape(
              paddingHorizontal: 12,
              paddingVertical: 12,
              borderRadius: 11,
              child: MyText(
                title: AppLocalizations.of(context)!.descReportMissing,
                fontSize: 16,
                color: AppColors.GRAY3,
              ),
            ),
            SizedBox(height: 16.h),
            MyContainerShape(
              paddingHorizontal: 12,
              paddingVertical: 12,
              borderRadius: 11,
              child: Form(
                key: _keyForm,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    MyText(
                      title: AppLocalizations.of(context)!.orderNumber,
                      fontSize: 12,
                      color: AppColors.BLACK,
                      fontWeight: FontWeight.bold,
                    ),
                    SizedBox(height: 12.h),
                    BlocBuilder<ComplaintsCubit, ComplaintsState>(
                      builder: (context, state) {
                        if (state is OrderIdsLoading) {
                          return LoadingWidget();
                        }
                        if (ComplaintsCubit.get(context).orderIds.length == 0) {
                          return SizedBox();
                        }
                        _orderNumberController.text =
                            ComplaintsCubit.get(context).orderIds[0].toString();
                        return CustomDropdownMenu2<int>(
                          isExpanded: true,
                          alignment: AlignmentDirectional.centerStart,
                          listItems: ComplaintsCubit.get(context).orderIds,
                          onChanged: <int>(int selected) {
                            _orderNumberController.text = selected.toString();
                          },
                        );
                      },
                    ),
                    SizedBox(height: 12.h),
                    MyText(
                      title: AppLocalizations.of(context)!.timeLoss,
                      fontSize: 12,
                      color: AppColors.BLACK,
                      fontWeight: FontWeight.bold,
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
                        fillColor: AppColors.WHITE2,
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
                      controller: _timeOutController,
                      format: format,
                      validator: (DateTime? value) {
                        if (value == null) {
                          return AppLocalizations.of(context)!
                              .pleaseThisFieldRequired;
                        }

                        return null;
                      },
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
                            _timeOutController.text =
                                DateFormat('yyyy-MM-dd HH:mm:ss')
                                    .format(DateTimeField.combine(date, time));
                            return DateTimeField.combine(date, time);
                          } else {
                            return currentValue;
                          }
                        });
                      },
                    ),
                    SizedBox(height: 12.h),
                    MyText(
                      title: AppLocalizations.of(context)!.contactNumber,
                      fontSize: 12,
                      color: AppColors.BLACK,
                      fontWeight: FontWeight.bold,
                    ),
                    SizedBox(height: 12.h),
                    MyTextField(
                      controller: _numberController,
                      textHint: AppLocalizations.of(context)!
                          .pleaseAddYourContactNumber,
                      filledColor: true,
                      isBorder: true,
                      keyboardType: TextInputType.number,
                      colorBorder: AppColors.WHITE2,
                      validator: (String? s) {
                        if (s == null || s.isEmpty) {
                          return AppLocalizations.of(context)!
                              .pleaseEnterYourPhoneNumber;
                        }

                        return null;
                      },
                    ),
                    SizedBox(height: 12.h),
                    MyText(
                      title: AppLocalizations.of(context)!
                          .descriptionOfTheLostItems,
                      fontSize: 12,
                      color: AppColors.BLACK,
                      fontWeight: FontWeight.bold,
                    ),
                    SizedBox(height: 12.h),
                    MyTextField(
                      controller: _messageController,
                      textHint: AppLocalizations.of(context)!.message,
                      filledColor: true,
                      isBorder: true,
                      colorBorder: AppColors.WHITE2,
                      maxLines: 12,
                      paddingHorizontal: 12,
                      paddingVertical: 12,
                      validator: (String? s) {
                        if (s == null || s.isEmpty) {
                          return AppLocalizations.of(context)!
                              .pleaseEnterYourMessage;
                        }

                        return null;
                      },
                    ),
                    SizedBox(height: 16.h),
                    MyText(
                      title: AppLocalizations.of(context)!
                          .picturesMissingItemsOptional,
                      fontSize: 12,
                      color: AppColors.BLACK,
                      fontWeight: FontWeight.bold,
                    ),
                    SizedBox(height: 12.h),
                    SizedBox(
                      height: 90.r,
                      child: BlocBuilder<ComplaintsCubit, ComplaintsState>(
                        builder: (context, state) {
                          if (ComplaintsCubit.get(context)
                                  .imagesLostItems
                                  .length ==
                              0) {
                            return Material(
                              borderRadius: BorderRadius.circular(8),
                              color: AppColors.GRAY2.withOpacity(.1),
                              child: InkWell(
                                borderRadius: BorderRadius.circular(8),
                                onTap: () {
                                  ComplaintsCubit.get(context).pickImageItems();
                                },
                                child: MyContainerShape(
                                  width: double.infinity,
                                  height: double.infinity,
                                  borderRadius: 8,
                                  bgContainer: AppColors.TRANSPARENT,
                                  child: MyText(
                                    title: AppLocalizations.of(context)!
                                        .choosePhotos,
                                  ),
                                ),
                              ),
                            );
                          } else {
                            return Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Expanded(
                                  child: ListView.builder(
                                    padding:
                                        EdgeInsets.symmetric(vertical: 5.h),
                                    itemCount: ComplaintsCubit.get(context)
                                        .imagesLostItems
                                        .length,
                                    scrollDirection: Axis.horizontal,
                                    itemBuilder: (context, index) {
                                      return MyContainerShape(
                                        height: 80.r,
                                        width: 80.r,
                                        borderRadius: 4,
                                        marginEnd: 8.w,
                                        child: Stack(
                                          children: [
                                            Image.file(
                                              File(
                                                ComplaintsCubit.get(context)
                                                    .imagesLostItems[index],
                                              ),
                                              height: double.infinity,
                                              fit: BoxFit.cover,
                                              width: double.infinity,
                                            ),
                                            GestureDetector(
                                                onTap: () {
                                                  ComplaintsCubit.get(context)
                                                      .deleteImageItem(index);
                                                },
                                                child: const Icon(Icons.close)),
                                          ],
                                        ),
                                      );
                                    },
                                  ),
                                ),
                                SizedBox(width: 10.w),
                                GestureDetector(
                                  onTap: () {
                                    if (ComplaintsCubit.get(context)
                                            .imagesLostItems
                                            .length <
                                        3) {
                                      ComplaintsCubit.get(context)
                                          .pickImageItems();
                                    } else {
                                      AppHelpers.showSnackBar(context,
                                          message: AppLocalizations.of(context)!
                                              .maximumNumberPhotos3,
                                          error: true);
                                    }
                                  },
                                  child: MyContainerShape(
                                    width: 70.r,
                                    borderRadius: 10,
                                    enableBorder: true,
                                    height: 70.r,
                                    child: Icon(Icons.add),
                                  ),
                                )
                              ],
                            );
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 32.h),
          ],
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: BlocConsumer<SideBarCubit, SideBarState>(
          listener: (context, state) {
            if (state is ContactUsSuccess) {
              AppHelpers.showSnackBar(context, message: state.message);
              _messageController.clear();
              _numberController.clear();
              _timeOutController.clear();
              ComplaintsCubit.get(context).imagesLostItems.clear();
              Navigator.pop(context);
            }
            if (state is ContactUsFailed) {
              AppHelpers.showSnackBar(
                context,
                message: state.message,
                error: true,
              );
            }
          },
          builder: (context, state) {
            if (state is ContactUsLoading) {
              return const LoadingWidget();
            }
            return Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
              child: MyElevatedButton(
                title: AppLocalizations.of(context)!.send,
                onPressed: () async {
                  if (_keyForm.currentState!.validate()) {
                    await SideBarCubit.get(context).reportMissing(
                      context,
                      phone: _numberController.text.trim(),
                      message: _messageController.text.trim(),
                      missingTime: _timeOutController.text.trim(),
                      orderId: _orderNumberController.text,
                      items:
                          ComplaintsCubit.get(context).imagesLostItems.length ==
                                  0
                              ? null
                              : ComplaintsCubit.get(context).imagesLostItems,
                    );
                  }
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
