import 'package:easy_plus_customer/core/utils/app_helpers.dart';
import 'package:easy_plus_customer/features/main/views/manager/main_cubit/main_cubit.dart';
import 'package:easy_plus_customer/features/side_bar/model/order/order_response.dart';
import 'package:easy_plus_customer/features/side_bar/views/manager/my_request_cubit/my_request_cubit.dart';
import 'package:easy_plus_customer/features/side_bar/views/widgets/details_order/order_data_widget.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:easy_plus_customer/core/utils/app_colors.dart';
import 'package:easy_plus_customer/core/utils/app_dialogs.dart';
import 'package:easy_plus_customer/core/widgets/my_elevated_button.dart';
import 'package:easy_plus_customer/features/side_bar/views/widgets/details_order/from_starting_address_to_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DetailsOrderWidget extends StatelessWidget {
  const DetailsOrderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    OrderResponse data = MyRequestCubit.get(context).dataOrderDetails!;
    return Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              children: [
                const FromStartingAddressTo(),
                SizedBox(height: 12.h),
                OrderDataWidget(data: data),
              ],
            ),
          ),
        ),
        BlocConsumer<MyRequestCubit, MyRequestState>(
          listener: (context, state) {
            if (state is ChangeOfferStatusLoading) {
              AppDialogs.showLoadingDialog(context);
            }
            if (state is ChangeOfferStatusSuccess) {
              Navigator.of(context).pop();
              AppHelpers.showSnackBar(
                context,
                message: state.message,
              );
              Navigator.pop(context);
            }
            if (state is ChangeOfferStatusFailed) {
              Navigator.of(context).pop();
              AppHelpers.showSnackBar(
                context,
                message: state.message,
                error: true,
              );
            }
          },
          builder: (context, state) {
            return MyElevatedButton(
              title: AppLocalizations.of(context)!.cancellingOrder,
              background: AppColors.WHITE,
              titleColor: AppColors.BLACK,
              borderColor: AppColors.BLACK,
              onPressed: () {
                OrderResponse data =
                    MyRequestCubit.get(context).dataOrderDetails!;

                int index = MainCubit.get(context)
                    .appConfig!
                    .categories!
                    .indexWhere(
                        (element) => element.id == data.data!.categoryId);

                String cancellationUser = MainCubit.get(context)
                        .appConfig!
                        .categories![index]
                        .cancellationUser ??
                    '0';

                double tax = double.parse(cancellationUser);

                double price = double.parse(data.data!.initialPrice!);
                AppDialogs.showDeleteOrderDialog(
                  context,
                  price: price * tax / 100,
                  orderTypeStatus: 'current',
                  onPressedNo: () {
                    Navigator.of(context).pop();
                  },
                  onPressedYes: () async {
                    Navigator.of(context).pop();
                    await MyRequestCubit.get(context).changeStatusOffer(
                      context,
                      operation: 2,
                      offerId: data.data!.id!,
                    );
                    // Navigator.pop(context);
                  },
                );
              },
            );
          },
        ),
        SizedBox(height: 30.h),
      ],
    );
  }
}
