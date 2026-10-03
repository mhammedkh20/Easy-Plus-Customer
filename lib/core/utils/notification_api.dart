import 'dart:developer';
import 'dart:io';
import 'package:firebase_core/firebase_core.dart';
import 'package:rxdart/subjects.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

//  android and ios
Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  log('my token Device ${await FirebaseMessaging.instance.getToken()}');
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
}

class NotificationApi {
  static final _notification = FlutterLocalNotificationsPlugin();
  static final onNotification = BehaviorSubject<String?>();

  static const AndroidNotificationChannel channel = AndroidNotificationChannel(
    'high_importance_channel', // id
    'High Importance Notifications', // title
    importance: Importance.max,
    playSound: true,
  );

  static void requestIOSPermissions() {
    if (Platform.isIOS) {
      _notification
          .resolvePlatformSpecificImplementation<
              IOSFlutterLocalNotificationsPlugin>()
          ?.requestPermissions(
            alert: true,
            badge: true,
            sound: true,
          );
    }
  }

  // static const InboxStyleInformation _inboxStyleInformation =
  //     InboxStyleInformation(
  //   ['mohammed', 'khaled', 'alseqaly'], //listMessages
  //   contentTitle: '3 messages', //dynamic
  //   summaryText: 'janedoe@example.com', // gmail
  // );

  static Future _notificationDetails({String? urlImage}) async {
    // String sound = 'sound_notification.wav'; // add sound to notificaiton
    return NotificationDetails(
      android: AndroidNotificationDetails(
        channel.id,
        channel.name,
        channelDescription: channel.description,
        importance: Importance.max,
        icon: '@mipmap/launcher_icon',
        largeIcon: const DrawableResourceAndroidBitmap('@mipmap/launcher_icon'),
        enableVibration: false,
      ),
      iOS: DarwinNotificationDetails(),
    );
  }

  Future initNotification() async {
    await Firebase.initializeApp();
    FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);

    await _notification
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);

    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions();
  }

  static Future init() async {
    log('my token Device ${await FirebaseMessaging.instance.getToken()}');
    NotificationAppLaunchDetails? details =
        await _notification.getNotificationAppLaunchDetails();

    // when app is closed
    if (details != null && details.didNotificationLaunchApp) {
      onNotification.add(details.notificationResponse!.payload);
    }

    AndroidInitializationSettings android =
        const AndroidInitializationSettings('@mipmap/launcher_icon');
    DarwinInitializationSettings ios = const DarwinInitializationSettings();

    InitializationSettings settings = InitializationSettings(
      android: android,
      iOS: ios,
    );

    _notification.initialize(settings);
  }

  static Future showNotification({
    int id = 0,
    String? title,
    String? body,
    String? payload,
    String? urlImage,
  }) async {
    _notification.show(
      id,
      title,
      body,
      await _notificationDetails(urlImage: urlImage),
      payload: payload,
    );
  }

  Future cancelNotificationById(int id) async {
    await _notification.cancel(id);
  }

  Future cancelAllNotification() async {
    await _notification.cancelAll();
  }
}
