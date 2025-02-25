import "dart:async";
import "dart:io";

import "package:flutter/material.dart";
import "package:flutter_local_notifications/flutter_local_notifications.dart";
import "package:logger/logger.dart";
import "package:mqtt_client/mqtt_server_client.dart";

import "package:mqtt_test/service/mqtt_service.dart";

import "package:mqtt_test/util/appstyle.dart";

final logger = Logger();

enum MqttCurrentConnectionState {
  IDLE,
  CONNECTING,
  CONNECTED,
  DISCONNECTED,
  ERROR_WHEN_CONNECTING
}

enum MqttSubscriptionState { IDLE, SUBSCRIBED }

class FirstScr extends StatefulWidget {
  const FirstScr({super.key});

  @override
  State<FirstScr> createState() => _FirstScrState();
}

class _FirstScrState extends State<FirstScr> {
  String status = "initialize";
  bool _notificationsEnabled = false;
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  InitializationSettings? initializationSettings;
  AndroidInitializationSettings? androidInitializationSettings;

  TextEditingController msgController = TextEditingController();

  int notid = 0;

  Future<void> initializMqttServer() async {
    try {
      MQTTClientWrapper().prepareMqttClient();
    } catch (e) {
      logger.e(e);
    }
  }

  @override
  void initState() {
    super.initState();
    initializMqttServer();

    initializationSettings = const InitializationSettings(
      android: AndroidInitializationSettings(
          '@mipmap-hdpi/ic_launcher'), // Replace with your icon
      iOS: DarwinInitializationSettings(), // Or relevant platform settings
    );

    flutterLocalNotificationsPlugin.initialize(
      initializationSettings!,
      onDidReceiveNotificationResponse:
          onSelectNotification, // Add this if you haven't already
    );

    _isAndroidPermissionGranted();
    _requestPermissions();
    _configureSelectNotificationSubject();
  }

  @override
  void dispose() {
    selectNotificationStream.close();
    super.dispose();
  }

  void onSelectNotification(NotificationResponse notificationResponse) async {
    // Handle notification tap
    if (notificationResponse.payload != null) {
      logger.i('Notification payload: ${notificationResponse.payload}');
      // Navigate to another screen or perform an action
    }
  }

  final StreamController<String?> selectNotificationStream =
      StreamController<String?>.broadcast();
  void _configureSelectNotificationSubject() {
    selectNotificationStream.stream.listen((String? payload) async {
      // await Navigator.of(context).push(MaterialPageRoute<void>(
      //   builder: (BuildContext context) => SecondPage(payload),
      // ));
    });
  }

  Future<void> _requestPermissions() async {
    if (Platform.isIOS || Platform.isMacOS) {
      await flutterLocalNotificationsPlugin
          .resolvePlatformSpecificImplementation<
              IOSFlutterLocalNotificationsPlugin>()
          ?.requestPermissions(
            alert: true,
            badge: true,
            sound: true,
          );
      await flutterLocalNotificationsPlugin
          .resolvePlatformSpecificImplementation<
              MacOSFlutterLocalNotificationsPlugin>()
          ?.requestPermissions(
            alert: true,
            badge: true,
            sound: true,
          );
    } else if (Platform.isAndroid) {
      final AndroidFlutterLocalNotificationsPlugin? androidImplementation =
          flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<
              AndroidFlutterLocalNotificationsPlugin>();

      final bool? grantedNotificationPermission =
          await androidImplementation?.requestNotificationsPermission();
      setState(() {
        _notificationsEnabled = grantedNotificationPermission ?? false;
      });
    }
  }

  Future<void> _isAndroidPermissionGranted() async {
    if (Platform.isAndroid) {
      final bool granted = await flutterLocalNotificationsPlugin
              .resolvePlatformSpecificImplementation<
                  AndroidFlutterLocalNotificationsPlugin>()
              ?.areNotificationsEnabled() ??
          false;

      setState(() {
        _notificationsEnabled = granted;
      });
    }
  }

  Future<void> showNotification() async {
    const AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails('001', 'TestApp',
            channelDescription: 'your channel description',
            importance: Importance.max,
            priority: Priority.high,
            ticker: 'ticker');
    const DarwinNotificationDetails darwinNotificationDetails =
        DarwinNotificationDetails(subtitle: "TestApp");
    const NotificationDetails notificationDetails = NotificationDetails(
        android: androidNotificationDetails, iOS: darwinNotificationDetails);
    try {
      await flutterLocalNotificationsPlugin.show(
          1, 'mqtt_test', msgController.text.toString(), notificationDetails,
          payload: 'item x');
    } catch (e) {
      logger.e(e);
    }
  }

  updateStatus({required String status}) {
    setState(() {
      this.status = status;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("MQTT", style: Main_Style().textBtn1),
        centerTitle: true,
        backgroundColor: Colors.blue.shade500,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Status: $status",
                style: Main_Style().normalText,
              ),
              Expanded(
                  child: Container(
                width: 100,
              )),
              TextFormField(
                controller: msgController,
                decoration:
                    InputDecoration(labelText: "ใส่ข้อความที่ต้องการเตือน"),
              ),
              ElevatedButton(
                style: Main_Style().buttonStyle1,
                onPressed: () {
                  //showAppToast(context: context, msg: "noti");
                  FocusScope.of(context).unfocus();
                  setState(() {
                    showNotification();
                  });
                },
                child:
                    Text("Notification Testing", style: Main_Style().textBtn1),
              ),
              SizedBox(
                height: 50.0,
              )
            ],
          ),
        ),
      ),
    );
  }
}
