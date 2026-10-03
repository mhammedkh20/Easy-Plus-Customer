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
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class MackComplaintScreen extends StatefulWidget {
  final int? orderId;

  MackComplaintScreen({
    super.key,
    this.orderId,
  });

  @override
  State<MackComplaintScreen> createState() => _MackComplaintScreenState();
}

class _MackComplaintScreenState extends State<MackComplaintScreen> {
  final _keyForm = GlobalKey<FormState>();

  final TextEditingController _orderNumberController = TextEditingController();

  final TextEditingController _descController = TextEditingController();

  @override
  void initState() {
    if (ComplaintsCubit.get(context).orderIds.length == 0) {
      ComplaintsCubit.get(context).getShowOrderIds(context);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.orderId != null) {
      _orderNumberController.text = widget.orderId.toString();
    }
    return Scaffold(
      backgroundColor: AppColors.BG_SCAFOLLD,
      appBar: MyAppBar(
        backgroundColor: AppColors.BG_SCAFOLLD,
        title: AppLocalizations.of(context)!.complaintRequest,
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
                    if (widget.orderId != null) ...{
                      MyTextField(
                        controller: _orderNumberController,
                        textHint: AppLocalizations.of(context)!
                            .pleaseEnterTheOrderNumber,
                        filledColor: true,
                        readOnly: widget.orderId != null,
                        isBorder: true,
                        colorBorder: AppColors.WHITE2,
                        validator: (String? s) {
                          if (s == null || s.isEmpty) {
                            return AppLocalizations.of(context)!
                                .pleaseEnterTheOrderNumber;
                          }

                          return null;
                        },
                      ),
                    } else ...{
                      BlocBuilder<ComplaintsCubit, ComplaintsState>(
                        builder: (context, state) {
                          if (state is OrderIdsLoading) {
                            return LoadingWidget();
                          }
                          if (ComplaintsCubit.get(context).orderIds.length ==
                              0) {
                            return SizedBox();
                          }
                          _orderNumberController.text =
                              ComplaintsCubit.get(context)
                                  .orderIds[0]
                                  .toString();
                          return CustomDropdownMenu2<int>(
                            isExpanded: true,
                            alignment: AlignmentDirectional.centerStart,
                            listItems: ComplaintsCubit.get(context).orderIds,
                            onChanged: <int>(int selected) {
                              _orderNumberController.text = selected.toString();
                            },
                          );
                        },
                      )
                    },
                    SizedBox(height: 12.h),
                    MyText(
                      title: AppLocalizations.of(context)!.disputeDetails,
                      fontSize: 12,
                      color: AppColors.BLACK,
                      fontWeight: FontWeight.bold,
                    ),
                    SizedBox(height: 12.h),
                    MyTextField(
                      controller: _descController,
                      textHint: AppLocalizations.of(context)!.disputeDetails,
                      filledColor: true,
                      isBorder: true,
                      colorBorder: AppColors.WHITE2,
                      maxLines: 12,
                      paddingHorizontal: 12,
                      paddingVertical: 12,
                      validator: (String? s) {
                        if (s == null || s.isEmpty) {
                          return AppLocalizations.of(context)!
                              .pleaseEnterTheDetails;
                        }

                        return null;
                      },
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 32.h),
            BlocConsumer<ComplaintsCubit, ComplaintsState>(
              listener: (context, state) {
                if (state is ComplaintPostFailed) {
                  AppHelpers.showSnackBar(context,
                      message: state.message, error: true);
                }
                if (state is ComplaintPostSuccess) {
                  AppHelpers.showSnackBar(
                    context,
                    message: state.message,
                  );

                  _descController.clear();
                  _orderNumberController.clear();
                  ComplaintsCubit.get(context).addCompaint(state.complaint);
                  Navigator.pop(context);
                }
              },
              builder: (context, state) {
                if (state is ComplaintPostLoading) {
                  return LoadingWidget();
                }
                return MyElevatedButton(
                  title: AppLocalizations.of(context)!.send,
                  onPressed: () async {
                    print(_orderNumberController.text);
                    if (_keyForm.currentState!.validate()) {
                      await ComplaintsCubit.get(context).sendComplaint(
                        context,
                        desc: _descController.text.trim(),
                        orderId: AppHelpers.getNumberEnglish(
                            _orderNumberController.text.trim()),
                      );
                    }
                  },
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
