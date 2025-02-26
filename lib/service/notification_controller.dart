import 'dart:io';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:mqtt_test/screen/firstpage%20copy.dart';

class NotificationController {
  static FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  InitializationSettings? initializationSettings;
  AndroidInitializationSettings? androidInitializationSettings;

  static Future<void> _requestPermissions() async {
    if (Platform.isIOS || Platform.isMacOS) {
      await NotificationController.flutterLocalNotificationsPlugin
          .resolvePlatformSpecificImplementation<
              IOSFlutterLocalNotificationsPlugin>()
          ?.requestPermissions(
            alert: true,
            badge: true,
            sound: true,
          );
      await NotificationController.flutterLocalNotificationsPlugin
          .resolvePlatformSpecificImplementation<
              MacOSFlutterLocalNotificationsPlugin>()
          ?.requestPermissions(
            alert: true,
            badge: true,
            sound: true,
          );
    } else if (Platform.isAndroid) {
      final androidImplementation = NotificationController
          .flutterLocalNotificationsPlugin
          .resolvePlatformSpecificImplementation<
              AndroidFlutterLocalNotificationsPlugin>();

      final bool? grantedNotificationPermission =
          await androidImplementation?.requestNotificationsPermission();
      // setState(() {
      //   _notificationsEnabled = grantedNotificationPermission ?? false;
      // });
    }
  }

  static void initialization() {
    const initializationSettings = InitializationSettings(
      android: AndroidInitializationSettings(
          '@mipmap/ic_launcher'), // Replace with your icon
      iOS: DarwinInitializationSettings(), // Or relevant platform settings
    );

    flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      // onDidReceiveNotificationResponse:
      //     (){}, // Add this if you haven't already
    );

    _isAndroidPermissionGranted();
    _requestPermissions();
    // _configureSelectNotificationSubject();
  }

  static Future<void> _isAndroidPermissionGranted() async {
    if (Platform.isAndroid) {
      final bool granted = await NotificationController
              .flutterLocalNotificationsPlugin
              .resolvePlatformSpecificImplementation<
                  AndroidFlutterLocalNotificationsPlugin>()
              ?.areNotificationsEnabled() ??
          false;

      // setState(() {
      //   _notificationsEnabled = granted;
      // });
    }
  }
  // void _configureSelectNotificationSubject() {
  //   selectNotificationStream.stream.listen((String? payload) async {
  //     // await Navigator.of(context).push(MaterialPageRoute<void>(
  //     //   builder: (BuildContext context) => SecondPage(payload),
  //     // ));
  //   });
  // }

  static sendNotification({required String inputMsg}) async {
    const AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails('001', 'TestApp',
            channelDescription: 'NCSA channel',
            importance: Importance.max,
            priority: Priority.high,
            ticker: 'ticker');
    const DarwinNotificationDetails darwinNotificationDetails =
        DarwinNotificationDetails(subtitle: "TestApp");
    const NotificationDetails notificationDetails = NotificationDetails(
        android: androidNotificationDetails, iOS: darwinNotificationDetails);
    try {
      await NotificationController.flutterLocalNotificationsPlugin.show(
          1, 'THCert Helpdesk', inputMsg, notificationDetails,
          payload: 'item x');
    } catch (e) {
      logger.e(e);
    }
  }
}
