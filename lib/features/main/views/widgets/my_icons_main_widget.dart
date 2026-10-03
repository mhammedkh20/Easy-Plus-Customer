import 'dart:math';
import 'package:easy_plus_customer/features/main/views/pages/comming_soon_screen.dart';
import 'package:easy_plus_customer/core/utils/app_colors.dart';
import 'package:easy_plus_customer/core/utils/app_helpers.dart';
import 'package:easy_plus_customer/features/main/views/manager/main_cubit/main_cubit.dart';
import 'package:easy_plus_customer/features/main/views/widgets/my_icon_main.dart';
import 'package:easy_plus_customer/features/request_services/views/pages/ride_screen.dart';
import 'package:easy_plus_customer/features/request_services/views/pages/service_order_screen.dart';
import 'package:easy_plus_customer/features/request_services/views/pages/service_tour_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../request_services/views/pages/service_reviewer_screen.dart';
import '../../../request_services/views/pages/service_shopper_screen.dart';

class MyIconsMainWidget extends StatefulWidget {
  const MyIconsMainWidget({super.key});

  @override
  State<MyIconsMainWidget> createState() => _MyIconsMainWidgetState();
}

class _MyIconsMainWidgetState extends State<MyIconsMainWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation _animation;

  Alignment alignment1 = Alignment.bottomCenter;
  Alignment alignment2 = Alignment.bottomCenter;
  Alignment alignment3 = Alignment.bottomCenter;
  Alignment alignment4 = Alignment.bottomCenter;
  Alignment alignment5 = Alignment.bottomCenter;

  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 350),
      reverseDuration: const Duration(milliseconds: 275),
    );
    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
      reverseCurve: Curves.easeIn,
    );
    _animation.addListener(() {
      MainCubit.get(context).notify();
    });
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PositionedDirectional(
      end: 0,
      start: 0,
      bottom: 30.h,
      child: Container(
        height: 200.h,
        alignment: Alignment.bottomCenter,
        child: BlocConsumer<MainCubit, MainState>(
          listener: (context, state) {
            if (state is CategoriesFailed) {
              AppHelpers.showSnackBar(
                context,
                message: state.message,
                error: true,
              );
            }
          },
          builder: (context, state) {
            if (MainCubit.get(context).isLoading) {
              return const CircularProgressIndicator.adaptive();
            }
            bool toggle = MainCubit.get(context).toggleMain;

            return Stack(
              children: [
                MyIconMain(
                  toggle: toggle,
                  alignment: alignment1,
                  title:
                      MainCubit.get(context).appConfig!.categories![0].name ??
                          "",
                  iconPath:
                      MainCubit.get(context).appConfig!.categories![0].icon ??
                          "",
                  isSvg: true,
                  onTap:
                      MainCubit.get(context).appConfig!.categories![0].status!
                          ? () {
                              toggle = !toggle;
                              _controller.reverse();
                              _alignmentBottomCenter();
                              MainCubit.get(context).changeToggle(toggle);

                              _goToScreen(
                                  context: context,
                                  catId: MainCubit.get(context)
                                      .appConfig!
                                      .categories![0]
                                      .id!);
                            }
                          : () {
                              AppHelpers.navigationToPage(
                                  context, const CommingSoonScreen());
                            },
                ),
                MyIconMain(
                  toggle: toggle,
                  alignment: alignment2,
                  title:
                      MainCubit.get(context).appConfig!.categories![3].name ??
                          "",
                  iconPath:
                      MainCubit.get(context).appConfig!.categories![3].icon ??
                          "",
                  isSvg: false,
                  onTap:
                      MainCubit.get(context).appConfig!.categories![3].status!
                          ? () {
                              toggle = !toggle;
                              _controller.reverse();
                              _alignmentBottomCenter();

                              MainCubit.get(context).changeToggle(toggle);
                              _goToScreen(
                                  context: context,
                                  catId: MainCubit.get(context)
                                      .appConfig!
                                      .categories![3]
                                      .id!);
                            }
                          : () {
                              AppHelpers.navigationToPage(
                                  context, const CommingSoonScreen());
                            },
                ),
                MyIconMain(
                  toggle: toggle,
                  alignment: alignment3,
                  title:
                      MainCubit.get(context).appConfig!.categories![2].name ??
                          "",
                  iconPath:
                      MainCubit.get(context).appConfig!.categories![2].icon ??
                          "",
                  isSvg: false,
                  onTap:
                      MainCubit.get(context).appConfig!.categories![2].status!
                          ? () {
                              toggle = !toggle;
                              _controller.reverse();
                              _alignmentBottomCenter();

                              MainCubit.get(context).changeToggle(toggle);
                              _goToScreen(
                                  context: context,
                                  catId: MainCubit.get(context)
                                      .appConfig!
                                      .categories![2]
                                      .id!);
                            }
                          : () {
                              AppHelpers.navigationToPage(
                                  context, CommingSoonScreen());
                            },
                ),
                MyIconMain(
                  toggle: toggle,
                  alignment: alignment4,
                  title:
                      MainCubit.get(context).appConfig!.categories![1].name ??
                          "",
                  iconPath:
                      MainCubit.get(context).appConfig!.categories![1].icon ??
                          "",
                  isSvg: false,
                  onTap:
                      MainCubit.get(context).appConfig!.categories![1].status!
                          ? () {
                              toggle = !toggle;
                              _controller.reverse();
                              _alignmentBottomCenter();

                              MainCubit.get(context).changeToggle(toggle);

                              _goToScreen(
                                  context: context,
                                  catId: MainCubit.get(context)
                                      .appConfig!
                                      .categories![1]
                                      .id!);
                            }
                          : () {
                              AppHelpers.navigationToPage(
                                  context, CommingSoonScreen());
                            },
                ),
                MyIconMain(
                  toggle: toggle,
                  alignment: alignment5,
                  title:
                      MainCubit.get(context).appConfig!.categories![4].name ??
                          "",
                  iconPath:
                      MainCubit.get(context).appConfig!.categories![4].icon ??
                          "",
                  isSvg: true,
                  onTap:
                      MainCubit.get(context).appConfig!.categories![4].status!
                          ? () {
                              toggle = !toggle;
                              _controller.reverse();
                              _alignmentBottomCenter();
                              MainCubit.get(context).changeToggle(toggle);
                              _goToScreen(
                                  context: context,
                                  catId: MainCubit.get(context)
                                      .appConfig!
                                      .categories![4]
                                      .id!);
                            }
                          : () {
                              AppHelpers.navigationToPage(
                                  context, CommingSoonScreen());
                            },
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Transform.rotate(
                    angle: _animation.value * pi * (3 / 4),
                    child: AnimatedContainer(
                      curve: Curves.easeOut,
                      duration: const Duration(milliseconds: 375),
                      height: toggle ? 70.r : 60.r,
                      width: toggle ? 70.r : 60.r,
                      decoration: BoxDecoration(
                        color: AppColors.BASE_COLOR,
                        borderRadius: BorderRadius.circular(60),
                      ),
                      child: Material(
                        color: AppColors.TRANSPARENT,
                        child: IconButton(
                          splashRadius: toggle ? 31 : 25,
                          onPressed: () {
                            if (toggle) {
                              toggle = !toggle;
                              _controller.forward();

                              alignment1 = const Alignment(-.5, -.4);
                              alignment2 = const Alignment(0, -.8);
                              alignment3 = const Alignment(.5, -.4);
                              alignment4 = const Alignment(.7, 1);
                              alignment5 = const Alignment(-.7, 1);
                            } else {
                              toggle = !toggle;
                              _controller.reverse();
                              _alignmentBottomCenter();
                            }
                            MainCubit.get(context).changeToggle(toggle);
                          },
                          icon: Icon(
                            Icons.add,
                            size: 40.r,
                            color: AppColors.WHITE,
                          ),
                        ),
                      ),
                    ),
                  ),
                )
              ],
            );
          },
        ),
      ),
    );
  }

  void _alignmentBottomCenter() {
    alignment1 = Alignment.bottomCenter;
    alignment2 = Alignment.bottomCenter;
    alignment3 = Alignment.bottomCenter;
    alignment4 = Alignment.bottomCenter;
    alignment5 = Alignment.bottomCenter;
  }
}

void _goToScreen({required BuildContext context, required int catId}) {
  switch (catId) {
    case 1:
      AppHelpers.navigationToPage(
          context, ServiceOrderScreen(categoryId: catId));
      break;
    case 2:
      AppHelpers.navigationToPage(
          context, ServiceReviewerScreen(categoryId: catId));
      break;
    case 3:
      AppHelpers.navigationToPage(
          context, ServiceShopperScreen(categoryId: catId));
      break;
    case 4:
      AppHelpers.navigationToPage(
          context, ServiceTourScreen(categoryId: catId));
      break;
    case 5:
      AppHelpers.navigationToPage(context, RideScreen(categoryId: catId));
      break;
  }
}
