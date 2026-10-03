import 'package:custom_refresh_indicator/custom_refresh_indicator.dart';
import 'package:easy_plus_customer/core/utils/app_colors.dart';
import 'package:easy_plus_customer/core/utils/app_helpers.dart';
import 'package:easy_plus_customer/core/widgets/loading_widget.dart';
import 'package:easy_plus_customer/core/widgets/my_app_bar.dart';
import 'package:easy_plus_customer/core/widgets/my_contianer_shape.dart';
import 'package:easy_plus_customer/core/widgets/my_text.dart';
import 'package:easy_plus_customer/features/side_bar/model/qustion.dart';
import 'package:easy_plus_customer/features/side_bar/views/manager/side_bar_cubit/side_bar_cubit.dart';
import 'package:easy_plus_customer/features/side_bar/views/widgets/common_qustions/item_qustions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:lottie/lottie.dart';

class CommonQuestionsScreen extends StatefulWidget {
  const CommonQuestionsScreen({super.key});

  @override
  State<CommonQuestionsScreen> createState() => _CommonQuestionsScreenState();
}

class _CommonQuestionsScreenState extends State<CommonQuestionsScreen> {
  var _scrollController = ScrollController();

  @override
  void initState() {
    if (SideBarCubit.get(context).listQustion.length == 0) {
      SideBarCubit.get(context).getQustion(context);
    }
    _scrollController.addListener(pagination);
    super.initState();
  }

  void pagination() async {
    if ((_scrollController.position.pixels ==
            _scrollController.position.maxScrollExtent) &&
        (SideBarCubit.get(context).listQustion.length <
            SideBarCubit.get(context).total)) {
      await SideBarCubit.get(context).getQustion(context, loadPagination: true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.BG_SCAFOLLD,
      appBar: MyAppBar(
        backgroundColor: AppColors.BG_SCAFOLLD,
        title: AppLocalizations.of(context)!.commonQuestions,
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 16.w),
          child: Column(
            children: [
              Expanded(
                child: MyContainerShape(
                  borderRadius: 11,
                  paddingHorizontal: 12,
                  paddingVertical: 12,
                  child: BlocConsumer<SideBarCubit, SideBarState>(
                    listener: (context, state) {
                      if (state is FailedQustionData) {
                        AppHelpers.showSnackBar(
                          context,
                          message: state.message,
                          error: true,
                        );
                      }
                    },
                    builder: (context, state) {
                      if (state is LoadingQustionData) {
                        return LoadingWidget();
                      }
                      if (state is FailedQustionData) {
                        return Center(
                          child: LottieBuilder.asset(
                            'assets/images/ic_json/faild.json',
                          ),
                        );
                      }

                      List<Qustion> listQustion =
                          SideBarCubit.get(context).listQustion;
                      return Column(
                        children: [
                          if (listQustion.length > 0) ...[
                            Expanded(
                              child: CustomRefreshIndicator(
                                leadingScrollIndicatorVisible: true,
                                trailingScrollIndicatorVisible: true,
                                builder: AppHelpers.getIndecatorDelegate(),
                                onRefresh: () async {
                                  SideBarCubit.get(context).getQustion(context);
                                },
                                child: ListView.builder(
                                  controller: _scrollController,
                                  physics: AlwaysScrollableScrollPhysics(),
                                  itemCount: listQustion.length,
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 16.w),
                                  itemBuilder: (context, index) {
                                    return Column(
                                      children: [
                                        ItemQuestions(
                                            qustion: listQustion[index]),
                                        SizedBox(height: 12.h),
                                      ],
                                    );
                                  },
                                ),
                              ),
                            ),
                          ] else ...[
                            Center(
                              child: MyText(
                                title: AppLocalizations.of(context)!.noData,
                              ),
                            )
                          ],
                          (state is QustionLoadingPagination)
                              ? const LoadingWidget()
                              : const SizedBox(),
                        ],
                      );
                    },
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
