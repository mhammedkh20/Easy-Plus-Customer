import 'package:easy_plus_customer/core/utils/app_colors.dart';
import 'package:easy_plus_customer/core/utils/notification_api.dart';
import 'package:easy_plus_customer/features/auth/views/manager/auth_cubit/auth_cubit.dart';
import 'package:easy_plus_customer/features/main/views/manager/main_cubit/main_cubit.dart';
import 'package:easy_plus_customer/features/main/views/widgets/main_widget.dart';
import 'package:easy_plus_customer/features/main/views/widgets/my_drawer.dart';
import 'package:easy_plus_customer/features/side_bar/views/manager/language_cubit/language_cubit.dart';
import 'package:easy_plus_customer/features/side_bar/views/manager/my_account_cubit/my_account_cubit.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:tale_drawer/tale_drawer.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  void initState() {
    // MainCubit.get(context).getAppConfig(context);
    MyAccountCubit.get(context).getUserDataFromShared();
    MainCubit.get(context).getLastSeen(context);
    NotificationApi.init();
    NotificationApi.requestIOSPermissions();
    AuthCubit.get(context).getProfile(context);
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification? notification = message.notification;

      if (notification != null) {
        if (notification.title != null) {
          NotificationApi.showNotification(
            id: notification.hashCode,
            title: notification.title ?? "",
            body: notification.body ?? "",
            urlImage: notification.android == null
                ? null
                : notification.android!.imageUrl,
            // payload: 'mohammed',
          );
        }
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LanguageCubit, LanguageState>(
      builder: (context, state) {
        return Container(
          color: AppColors.BASE_COLOR,
          child: TaleDrawer(
            drawerBackground: AppColors.BASE_COLOR,
            type: TaleType.Guillotine,
            controller: MainCubit.get(context).drawerController,
            body: const MainWidget(),
            drawer: const MyDrawer(),
            sideState: LanguageCubit.get(context).indexLang == 0
                ? SideState.RIGHT
                : SideState.LEFT,
          ),
        );
      },
    );
  }
}
