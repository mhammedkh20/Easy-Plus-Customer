import 'package:easy_plus_customer/app_config.dart';
import 'package:easy_plus_customer/core/storage/pref/shared_pref_controller.dart';
import 'package:easy_plus_customer/core/utils/notification_api.dart';
import 'package:easy_plus_customer/features/on_boarding/views/pages/splash_screen.dart';
import 'package:easy_plus_customer/features/side_bar/views/manager/language_cubit/language_cubit.dart';
import 'package:easy_plus_customer/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SharedPrefController().initSharedPref();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await NotificationApi().initNotification();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: AppConfig.providers,
      child: ScreenUtilInit(
        designSize: const Size(390, 844),
        minTextAdapt: true,
        useInheritedMediaQuery: true,
        splitScreenMode: true,
        builder: (context, child) {
          return BlocBuilder<LanguageCubit, LanguageState>(
            builder: (context, state) {
              String lang = SharedPrefController().getLang;
              LanguageCubit.get(context).changeIndexLang(lang == 'ar'
                  ? 0
                  : lang == 'en'
                      ? 1
                      : 2);
              return MaterialApp(
                title: 'Easy Plus Custommer',
                debugShowCheckedModeBanner: false,
                theme: AppConfig.theme,
                localizationsDelegates: AppConfig.settingsLocalizations,
                supportedLocales: AppConfig.supportedLocales,
                locale: Locale(lang),
                home: const SplashScreen(),
              );
            },
          );
        },
      ),
    );
  }
}
