import 'package:easy_plus_customer/core/utils/app_helpers.dart';
import 'package:easy_plus_customer/core/widgets/loading_widget.dart';
import 'package:easy_plus_customer/core/widgets/my_app_bar.dart';
import 'package:easy_plus_customer/core/widgets/my_text.dart';
import 'package:easy_plus_customer/features/side_bar/model/transactions.dart';
import 'package:easy_plus_customer/features/side_bar/views/manager/side_bar_cubit/side_bar_cubit.dart';
import 'package:easy_plus_customer/features/side_bar/views/widgets/wallet/item_action_wallet.dart';
import 'package:easy_plus_customer/features/side_bar/views/widgets/wallet/item_wallet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_svg/svg.dart';

class WalletScreen extends StatefulWidget {
  const WalletScreen({super.key});

  @override
  State<WalletScreen> createState() => _WalletScreenState();
}

class _WalletScreenState extends State<WalletScreen> {
  @override
  void initState() {
    SideBarCubit.get(context).getTransactions(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        title: AppLocalizations.of(context)!.wallet,
      ),
      body: BlocConsumer<SideBarCubit, SideBarState>(
        listener: (context, state) {
          if (state is WalletFailed) {
            AppHelpers.showSnackBar(context,
                message: state.message, error: true);
          }
        },
        builder: (context, state) {
          if (state is WalletLoading) {
            return const LoadingWidget();
          }
          List<Transactions> transactions =
              SideBarCubit.get(context).listTransactions;
          return ListView(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
            children: [
              const ItemWallet(),
              SizedBox(height: 40.h),
              Row(
                children: [
                  SvgPicture.asset(
                    'assets/images/ic_history.svg',
                    width: 20.r,
                  ),
                  SizedBox(width: 8.w),
                  MyText(
                    fontSize: 15,
                    title: AppLocalizations.of(context)!
                        .recordFinancialTransactions,
                  ),
                ],
              ),
              SizedBox(height: 30.h),
              ListView.builder(
                itemCount: transactions.length,
                padding: EdgeInsets.zero,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return ItemActionWallet(data: transactions[index]);
                },
              ),
            ],
          );
        },
      ),
    );
  }
}
