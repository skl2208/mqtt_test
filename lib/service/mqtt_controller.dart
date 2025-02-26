import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_server_client.dart';
import 'package:mqtt_test/model/mqtt_model.dart';
import 'package:mqtt_test/model/notification_model.dart';
import 'package:mqtt_test/screen/firstpage%20copy.dart';
import 'package:mqtt_test/service/notification_controller.dart';

class MqttController {
  late MqttServerClient client;
  MqttCurrentConnectionState connectionState = MqttCurrentConnectionState.IDLE;
  MqttSubscriptionState subscriptionState = MqttSubscriptionState.IDLE;
  String msgFromMqtt = '';

  Future<String> initializeMqttServer(MqttConfig mqttConfig) async {
    // setState(() {
    //   status = "Starting...";
    // });

    client = MqttServerClient(mqttConfig.broker!, '');
    client.logging(on: true);
    client.port = mqttConfig.port!;
    client.secure = false;
    client.securityContext = SecurityContext.defaultContext;
    client.keepAlivePeriod = 20;
    client.autoReconnect = true;
    client.onDisconnected = onDisconnected;
    client.onConnected = onConnected;
    // client.onSubscribed = _onSubscribed;
    final connMessage = MqttConnectMessage()
        .withClientIdentifier(mqttConfig.clientID!)
        .authenticateAs(mqttConfig.username!, mqttConfig.password)
        .startClean()
        .withWillQos(MqttQos.atMostOnce);

    client.connectionMessage = connMessage;

    await client.connect();

    logger.i(client.connectionStatus!.state.toString());

    if (client.connectionStatus!.state == MqttConnectionState.connected) {
      connectionState = MqttCurrentConnectionState.CONNECTED;
      // setState(() {
      //   status = "Connected";
      // });
      client.subscribe(mqttConfig.topicname!, MqttQos.atMostOnce);
      client.updates!.listen((List<MqttReceivedMessage<MqttMessage>> c) {
        final MqttPublishMessage recMess = c[0].payload as MqttPublishMessage;
        final a =
            MqttPublishPayload.bytesToStringAsString(recMess.payload.message);

        Uint8List bytes = latin1.encode(a);
        msgFromMqtt = utf8.decode(bytes);
        // msgFromMqtt =
        //     MqttPublishPayload.bytesToStringAsString(recMess.payload.message);
        if (recMess.header!.retain) {
          logger.i(msgFromMqtt);
        } else {
          Map<String, dynamic> jsonMap = jsonDecode(msgFromMqtt);
          final notificationMsg = NotificationModel.fromJson(jsonMap);
          NotificationController.sendNotification(
              inputMsg:
                  "${notificationMsg.subject.toString()}, เรื่อง ${notificationMsg.detail!.title.toString()}");
        }

        // setState(() {
        //   allmsg.add(msgFromMqtt);
        // });

        // if (kDebugMode) {
        //   print('YOU GOT A NEW MESSAGE:');
        //   print(msg);
        // }
      });
      return "Connected";
    } else {
      // setState(() {
      //   status =
      //       "ERROR client connection failed - disconnecting, status is ${client.connectionStatus}";
      // });

      connectionState = MqttCurrentConnectionState.ERROR_WHEN_CONNECTING;
      client.disconnect();
      return "Disconnected";
    }

    //logger.e(e);
    // setState(() {
    //   status =
    //       "ERROR client connection failed - disconnecting, status is ${client.connectionStatus}";
    // });
    // connectionState = MqttCurrentConnectionState.ERROR_WHEN_CONNECTING;
    // client.disconnect();
  }

  void disConnect() {
    client.disconnect();
  }

  onConnected() {}
  onDisconnected() {}
}
