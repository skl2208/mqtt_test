import "dart:async";
import "package:flutter/material.dart";
import "package:flutter_local_notifications/flutter_local_notifications.dart";
import "package:logger/logger.dart";
import "package:mqtt_test/main.dart";
import "package:mqtt_test/model/mqtt_model.dart";
import "package:mqtt_test/service/mqtt_controller.dart";
import "package:mqtt_test/service/notification_controller.dart";
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
  TextEditingController msgController = TextEditingController();
  MqttConfig mqttConfig = MqttConfig(
    broker: "dev.worldinfinity.co.th",
    username: "admin",
    password: "admin",
    pid: "123456789",
    topicname: "user/123456789/message",
    clientID: "1100702035898",
    port: 1883,
  );
  //late MqttServerClient client;
  // static final pid = "123456789";
  // static final broker = "1d7b11a752bc4061bcf4bba4559c8155.s1.eu.hivemq.cloud";
  // static final username = "lsukuem";
  // static final password = "an4@3J83K9V3zHq";
  // static final topicName = "User/Msg/$pid";
  // static final pid = mqttConfig.pid;
  // static final broker = "dev.worldinfinity.co.th";
  // static final username = "admin";
  // static final password = "admin";
  // static final clientID = "1100702035898";
  // static final topicName = "user/$pid/message";
  String msgFromMqtt = "";
  MqttCurrentConnectionState connectionState = MqttCurrentConnectionState.IDLE;
  MqttSubscriptionState subscriptionState = MqttSubscriptionState.IDLE;
  int notid = 0;
  List<String> allmsg = [];

  // Future<void> initializeMqttServer() async {
  //   try {
  //     client = MqttServerClient.withPort(broker, 'flutter_client', 8883);
  //     // the next 2 lines are necessary to connect with tls, which is used by HiveMQ Cloud
  //     client.secure = true;
  //     client.securityContext = SecurityContext.defaultContext;
  //     client.keepAlivePeriod = 20;
  //     // client.onDisconnected = _onDisconnected;
  //     //client.onConnected = _onConnected;
  //     // client.onSubscribed = _onSubscribed;
  //     setState(() {
  //       status = "Starting...";
  //     });
  //     await client.connect(username, password);

  //     //   logger.i("Starting...");
  //     //   await connectClient();
  //     //   subscribeToTopic('User/Msg/123456789');
  //     if (client.connectionStatus!.state == MqttConnectionState.connected) {
  //       connectionState = MqttCurrentConnectionState.CONNECTED;
  //       setState(() {
  //         status = "Connected";
  //       });
  //       client.subscribe(topicName, MqttQos.atMostOnce);
  //       client.updates!.listen((List<MqttReceivedMessage<MqttMessage>> c) {
  //         final MqttPublishMessage recMess = c[0].payload as MqttPublishMessage;
  //         final a =
  //             MqttPublishPayload.bytesToStringAsString(recMess.payload.message);
  //         Uint8List bytes = latin1.encode(a);
  //         msgFromMqtt = utf8.decode(bytes);

  //         showNotification(inputMsg: msgFromMqtt);
  //         setState(() {
  //           allmsg.add(msgFromMqtt);
  //         });

  //         addInbox();
  //         // if (kDebugMode) {
  //         //   print('YOU GOT A NEW MESSAGE:');
  //         //   print(msg);
  //         // }
  //       });
  //     } else {
  //       setState(() {
  //         status =
  //             "ERROR client connection failed - disconnecting, status is ${client.connectionStatus}";
  //       });

  //       connectionState = MqttCurrentConnectionState.ERROR_WHEN_CONNECTING;
  //       client.disconnect();
  //     }
  //   } catch (e) {
  //     logger.e(e);
  //   }
  // }

  // Future<void> initializeMqttServer() async {
  //   setState(() {
  //     status = "Starting...";
  //   });

  //   try {
  //     client = MqttServerClient(mqttConfig.broker!, '');
  //     client.logging(on: true);
  //     client.port = mqttConfig.port!;
  //     client.secure = false;
  //     client.securityContext = SecurityContext.defaultContext;
  //     client.keepAlivePeriod = 20;
  //     client.onDisconnected = onDisconnected;
  //     client.onConnected = onConnected;
  //     // client.onSubscribed = _onSubscribed;
  //     final connMessage = MqttConnectMessage()
  //         .withClientIdentifier(mqttConfig.clientID!)
  //         .authenticateAs(mqttConfig.username, mqttConfig.password)
  //         .startClean()
  //         .withWillQos(MqttQos.atMostOnce);

  //     client.connectionMessage = connMessage;

  //     await client.connect();

  //     logger.i(client.connectionStatus!.state.toString());

  //     if (client.connectionStatus!.state == MqttConnectionState.connected) {
  //       connectionState = MqttCurrentConnectionState.CONNECTED;
  //       setState(() {
  //         status = "Connected";
  //       });
  //       client.subscribe(mqttConfig.topicname!, MqttQos.atMostOnce);
  //       client.updates!.listen((List<MqttReceivedMessage<MqttMessage>> c) {
  //         final MqttPublishMessage recMess = c[0].payload as MqttPublishMessage;
  //         final a =
  //             MqttPublishPayload.bytesToStringAsString(recMess.payload.message);
  //         Uint8List bytes = latin1.encode(a);
  //         msgFromMqtt = utf8.decode(bytes);
  //         NotificationController.sendNotification(inputMsg: msgFromMqtt);
  //         setState(() {
  //           allmsg.add(msgFromMqtt);
  //         });

  //         addInbox();
  //         // if (kDebugMode) {
  //         //   print('YOU GOT A NEW MESSAGE:');
  //         //   print(msg);
  //         // }
  //       });
  //     } else {
  //       setState(() {
  //         status =
  //             "ERROR client connection failed - disconnecting, status is ${client.connectionStatus}";
  //       });

  //       connectionState = MqttCurrentConnectionState.ERROR_WHEN_CONNECTING;
  //       client.disconnect();
  //     }
  //   } catch (e) {
  //     logger.e(e);
  //     setState(() {
  //       status =
  //           "ERROR client connection failed - disconnecting, status is ${client.connectionStatus}";
  //     });
  //     connectionState = MqttCurrentConnectionState.ERROR_WHEN_CONNECTING;
  //     client.disconnect();
  //   }
  // }

  addInbox() async {}

  Future<void> setMQTT() async {
    final laststatus = await MqttController().initializeMqttServer(mqttConfig);
    setState(() {
      status = laststatus;
    });
  }

  @override
  void initState() {
    super.initState();

    try {
      setMQTT();
    } catch (e) {
      logger.e(e);
    }
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
        backgroundColor: Colors.blue.shade900,
      ),
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: Colors.red.shade500,
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Broker: ${mqttConfig.broker}",
                          style: Main_Style().textBtn1),
                      Text(
                          "Username: ${mqttConfig.username} , Password: ${mqttConfig.password}",
                          style: Main_Style().textBtn1),
                      Text("PID: ${mqttConfig.pid}",
                          style: Main_Style().textBtn1),
                      Text("Topic: ${mqttConfig.topicname}",
                          style: Main_Style().textBtn1),
                      // Text(
                      //     "Website : https://console.hivemq.cloud/clusters/1d7b11a752bc4061bcf4bba4559c8155/web-client",
                      //     style: Main_Style().textBtn1),
                    ]),
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: Colors.orange.shade500,
              ),
              child: Text("Status: $status", style: Main_Style().textBtn1),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                style: status == "Connected"
                    ? Main_Style().buttonCancelStyle
                    : Main_Style().buttonStyle1,
                onPressed: () {
                  if (status != "Connected") {
                    setMQTT();
                    //
                  } else {
                    setState(() {
                      status = "Disconnected";
                    });
                    MqttController().disConnect();
                  }
                },
                child: status != "Connected"
                    ? Text("Reconnect", style: Main_Style().textBtn1)
                    : Text("Disconnect", style: Main_Style().textBtn1),
              ),
            ),

            // for (var i = 0; i < allmsg.length; i++)
            //   Padding(
            //     padding: const EdgeInsets.all(8.0),
            //     child: Text("ข้อความ : ${allmsg[i]}",
            //         style: Main_Style().normalText),
            //   ),
            Expanded(
                child: Container(
              width: 100,
            )),
            //========== MailBox ==========//
            Stack(children: [
              SizedBox(
                width: MediaQuery.of(context).size.width,
                height: 200.0,
                child: Icon(
                  Icons.mail,
                  size: 150,
                  color: Colors.yellow.shade800,
                ),
              ),
              Positioned(top: 0, right: 0, child: Text("")),
            ]),
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
                  NotificationController.sendNotification(
                      inputMsg: msgController.text);
                  // showNotification(inputMsg: msgController.text);
                });
              },
              child: Text("Notification Testing", style: Main_Style().textBtn1),
            ),
            SizedBox(
              height: 50.0,
            )
          ],
        ),
      ),
    );
  }
}
