import 'dart:async';

import 'package:easy_plus_customer/core/widgets/my_text.dart';
import 'package:easy_plus_customer/features/request_services/model/places/response_predictions.dart';
import 'package:easy_plus_customer/features/request_services/views/manager/service_cubit/service_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:easy_plus_customer/core/utils/app_colors.dart';
import 'package:easy_plus_customer/core/widgets/my_contianer_shape.dart';
import 'package:easy_plus_customer/core/widgets/my_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class ItemSearchLocation extends StatelessWidget {
  final TextEditingController controller;
  const ItemSearchLocation({
    required this.controller,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return MyContainerShape(
      borderRadius: 11,
      paddingHorizontal: 16,
      enableShadow: false,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              SvgPicture.asset(
                'assets/images/ic_search.svg',
                width: 17.r,
              ),
              SizedBox(width: 8.w),
              Expanded(
                child: MySearch(controller: controller),
              ),
            ],
          ),
          BlocBuilder<ServiceCubit, ServiceState>(
            builder: (context, state) {
              List<Predictions>? predictions =
                  ServiceCubit.get(context).predictions ?? [];
              return AnimatedSize(
                duration: const Duration(milliseconds: 200),
                child: SizedBox(
                  height: predictions.length > 0 ? 100.h : 0,
                  child: ListView.separated(
                    itemCount: predictions.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          ServiceCubit.get(context).getPlaceDetails(context,
                              placeId: predictions[index].placeId!);
                          controller.text =
                              predictions[index].description ?? "";
                        },
                        child: Row(
                          children: [
                            SvgPicture.asset(
                              'assets/images/ic_location.svg',
                              width: 24.r,
                              height: 24.r,
                              color: AppColors.RED,
                            ),
                            SizedBox(width: 8.w),
                            Expanded(
                              child: MyText(
                                title: predictions[index].description ?? "",
                                fontSize: 12,
                                color: AppColors.BLACK,
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                    separatorBuilder: (BuildContext context, int index) {
                      return Divider();
                    },
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

Timer? searchOnStoppedTyping;

class MySearch extends StatelessWidget {
  const MySearch({
    super.key,
    required this.controller,
  });

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return MyTextField(
      controller: controller,
      paddingHorizontal: 0,
      onTap: () {
        controller.clear();
      },
      textHint: AppLocalizations.of(context)!.findAddress,
      onChange: (String str) async {
        const duration = Duration(milliseconds: 800);
        if (searchOnStoppedTyping != null) {
          searchOnStoppedTyping!.cancel();
        }
        searchOnStoppedTyping = Timer(duration, () {
          if (controller.text.trim().length > 0) {
            ServiceCubit.get(context)
                .getPredictions(context, input: controller.text);
          }
        });
      },
      suffixWidget: BlocBuilder<ServiceCubit, ServiceState>(
        builder: (context, state) {
          return GestureDetector(
            onTap: () {
              controller.text = '';
              ServiceCubit.get(context).clearPredictions();
            },
            child: ServiceCubit.get(context).predictions != null
                ? const Icon(
                    Icons.close,
                    color: AppColors.BLACK,
                  )
                : const SizedBox(),
          );
        },
      ),
    );
  }
}
