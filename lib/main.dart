import 'package:flutter/material.dart';

import 'package:mqtt_test/screen/firstpage.dart';
import 'package:mqtt_test/service/notification_controller.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  NotificationController.initialization();

  // await initializeService();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: FirstScr(),
    );
  }
}
