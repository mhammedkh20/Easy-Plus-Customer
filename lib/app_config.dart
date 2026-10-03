import 'package:easy_plus_customer/core/utils/app_colors.dart';
import 'package:easy_plus_customer/features/auth/views/manager/auth_cubit/auth_cubit.dart';
import 'package:easy_plus_customer/features/main/views/manager/main_cubit/main_cubit.dart';
import 'package:easy_plus_customer/features/on_boarding/views/manager/onboarding_cubit/on_boarding_cubit.dart';
import 'package:easy_plus_customer/features/request_services/views/manager/evaluation_cubit/evaluation_cubit.dart';
import 'package:easy_plus_customer/features/request_services/views/manager/service_cubit/service_cubit.dart';
import 'package:easy_plus_customer/features/side_bar/views/manager/compliants_cubit/complaints_cubit.dart';
import 'package:easy_plus_customer/features/side_bar/views/manager/language_cubit/language_cubit.dart';
import 'package:easy_plus_customer/features/side_bar/views/manager/my_account_cubit/my_account_cubit.dart';
import 'package:easy_plus_customer/features/side_bar/views/manager/my_request_cubit/my_request_cubit.dart';
import 'package:easy_plus_customer/features/side_bar/views/manager/side_bar_cubit/side_bar_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/src/bloc_provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AppConfig {
  static List<SingleChildWidget> providers = [
    BlocProvider(create: (context) => AuthCubit()),
    BlocProvider(create: (context) => MainCubit()),
    BlocProvider(create: (context) => ServiceCubit()),
    BlocProvider(create: (context) => MyAccountCubit()),
    BlocProvider(create: (context) => MyRequestCubit()),
    BlocProvider(create: (context) => LanguageCubit()),
    BlocProvider(create: (context) => EvaluationCubit()),
    BlocProvider(create: (context) => SideBarCubit()),
    BlocProvider(create: (context) => ComplaintsCubit()),
    BlocProvider(create: (context) => OnBoardingCubit()),
  ];

  static Iterable<LocalizationsDelegate<dynamic>> settingsLocalizations =
      const [
    AppLocalizations.delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
  ];

  static Iterable<Locale> supportedLocales = const [
    Locale('en'),
    Locale('ar'),
    Locale('ur'),
  ];

  static ThemeData? theme = ThemeData(
    primarySwatch: AppColors.APP_THEME,
    scaffoldBackgroundColor: AppColors.WHITE,
  );
}
