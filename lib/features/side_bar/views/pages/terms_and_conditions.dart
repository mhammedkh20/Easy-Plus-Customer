import 'package:easy_plus_customer/core/utils/app_helpers.dart';
import 'package:easy_plus_customer/core/widgets/loading_widget.dart';
import 'package:easy_plus_customer/features/main/model/response_privacy.dart';
import 'package:easy_plus_customer/features/side_bar/views/manager/side_bar_cubit/side_bar_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:lottie/lottie.dart';

import '../../../../../../core/utils/app_colors.dart';
import '../../../../../../core/widgets/my_app_bar.dart';
import '../../../../../../core/widgets/my_text.dart';

class TermsAndConditionsScreen extends StatefulWidget {
  const TermsAndConditionsScreen({super.key});

  @override
  State<TermsAndConditionsScreen> createState() =>
      _TermsAndConditionsScreenState();
}

class _TermsAndConditionsScreenState extends State<TermsAndConditionsScreen> {
  @override
  void initState() {
    if (SideBarCubit.get(context).responseTerms == null) {
      SideBarCubit.get(context).getTermsOfUse(context);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.BG_SCAFOLLD,
      appBar: MyAppBar(
        backgroundColor: AppColors.BG_SCAFOLLD,
        title: AppLocalizations.of(context)!.termsAndConditions,
      ),
      body: Directionality(
        textDirection: TextDirection.ltr,
        child: SafeArea(
          child: BlocConsumer<SideBarCubit, SideBarState>(
            listener: (context, state) {
              if (state is PrivacyPolicyFailed) {
                AppHelpers.showSnackBar(
                  context,
                  message: state.message,
                  error: true,
                );
              }
            },
            builder: (context, state) {
              if (state is PrivacyPolicyLoading) {
                return const Center(child: LoadingWidget());
              }
              ResponsePrivacy? response =
                  SideBarCubit.get(context).responseTerms;
              if (response == null) {
                return Center(
                  child: LottieBuilder.asset(
                    'assets/images/ic_json/faild.json',
                  ),
                );
              }

              return SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: 16.h,
                    horizontal: 16.w,
                  ),
                  child: MyText(
                    title: response.data ?? "",
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
