import 'dart:io';
import 'package:easy_plus_customer/core/utils/app_colors.dart';
import 'package:easy_plus_customer/core/widgets/my_contianer_shape.dart';
import 'package:easy_plus_customer/features/side_bar/views/manager/my_account_cubit/my_account_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PickImageUser extends StatelessWidget {
  const PickImageUser({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return PositionedDirectional(
      end: 0,
      start: 0,
      bottom: 0,
      child: Center(
        child: SizedBox(
          height: 119.r,
          width: 119.r,
          child: Stack(
            children: [
              Material(
                color: AppColors.WHITE,
                borderRadius: BorderRadius.circular(100),
                child: InkWell(
                  borderRadius: BorderRadius.circular(100),
                  onTap: () async {
                    await MyAccountCubit.get(context).pickImageUser();
                  },
                  child: BlocBuilder<MyAccountCubit, MyAccountState>(
                    builder: (context, state) {
                      return MyContainerShape(
                        boxShape: BoxShape.circle,
                        enableRadius: false,
                        bgContainer: AppColors.TRANSPARENT,
                        height: 119.r,
                        width: 119.r,
                        child: MyAccountCubit.get(context).picked
                            ? Image.file(
                                File(MyAccountCubit.get(context).pathImage!),
                                fit: BoxFit.cover,
                                width: double.infinity,
                                height: double.infinity,
                              )
                            : MyAccountCubit.get(context).userData!.image !=
                                    null
                                ? Image.network(
                                    MyAccountCubit.get(context)
                                        .userData!
                                        .image!,
                                    width: double.infinity,
                                    height: double.infinity,
                                    fit: BoxFit.cover,
                                  )
                                : MyAccountCubit.get(context).pathImage == null
                                    ? Image.asset(
                                        'assets/images/ic_user2.png',
                                        width: 50.w,
                                        height: 76.h,
                                      )
                                    : Image.file(
                                        File(MyAccountCubit.get(context)
                                            .pathImage!),
                                        fit: BoxFit.cover,
                                        width: double.infinity,
                                        height: double.infinity,
                                      ),
                      );
                    },
                  ),
                ),
              ),
              PositionedDirectional(
                bottom: 10.h,
                start: 5.w,
                child: MyContainerShape(
                  boxShape: BoxShape.circle,
                  enableRadius: false,
                  height: 20.r,
                  width: 20.r,
                  bgContainer: AppColors.BASE_COLOR,
                  child: Icon(
                    Icons.add,
                    color: AppColors.WHITE,
                    size: 20.r,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
