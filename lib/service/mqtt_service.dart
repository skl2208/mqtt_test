import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_server_client.dart';
import 'package:mqtt_test/screen/firstpage.dart';

class MQTTClientWrapper {
  MqttCurrentConnectionState connectionState = MqttCurrentConnectionState.IDLE;
  MqttSubscriptionState subscriptionState = MqttSubscriptionState.IDLE;

  // using async tasks, so the connection won't hinder the code flow
  Future<void> prepareMqttClient() async {
    // setupMqttClient();
    // logger.i("Starting...");
    // await connectClient();
    // subscribeToTopic('User/Msg/123456789');
  }

  // waiting for the connection, if an error occurs, print it and disconnect
  Future<void> connectClient() async {
    // try {
    //   print('client connecting....');
    //   connectionState = MqttCurrentConnectionState.CONNECTING;
    //   await client.connect('lsukuem', 'an4@3J83K9V3zHq');
    // } on Exception catch (e) {
    //   print('client exception - $e');
    //   connectionState = MqttCurrentConnectionState.ERROR_WHEN_CONNECTING;
    //   client.disconnect();
    // }

    // // when connected, print a confirmation, else print an error
    // if (client.connectionStatus!.state == MqttConnectionState.connected) {
    //   connectionState = MqttCurrentConnectionState.CONNECTED;
    //   print('client connected');
    // } else {
    //   print(
    //       'ERROR client connection failed - disconnecting, status is ${client.connectionStatus}');
    //   connectionState = MqttCurrentConnectionState.ERROR_WHEN_CONNECTING;
    //   client.disconnect();
    // }
  }

  void setupMqttClient(
      {required MqttServerClient client, required String broker}) {
    client = MqttServerClient.withPort(broker, 'flutter_client', 8883);
    // the next 2 lines are necessary to connect with tls, which is used by HiveMQ Cloud
    client.secure = true;
    client.securityContext = SecurityContext.defaultContext;
    client.keepAlivePeriod = 20;
    client.onDisconnected = _onDisconnected;
    client.onConnected = _onConnected;
    client.onSubscribed = _onSubscribed;
  }

  void subscribeToTopic(String topicName) {
    // print('Subscribing to the $topicName topic');
    // client.subscribe(topicName, MqttQos.atMostOnce);

    // // print the message when it is received
    // client.updates!.listen((List<MqttReceivedMessage<MqttMessage>> c) {
    //   final MqttPublishMessage recMess = c[0].payload as MqttPublishMessage;
    //   var message =
    //       MqttPublishPayload.bytesToStringAsString(recMess.payload.message);

    //   if (kDebugMode) {
    //     print('YOU GOT A NEW MESSAGE:');
    //     print(message);
    //   }
    // });
  }

  void _publishMessage(String message) {
    final MqttClientPayloadBuilder builder = MqttClientPayloadBuilder();
    builder.addString(message);

    // print('Publishing message "$message" to topic ${'Dart/Mqtt_client/world'}');
    // client.publishMessage(
    //     'Dart/Mqtt_client/world', MqttQos.exactlyOnce, builder.payload!);
  }

  // callbacks for different events
  void _onSubscribed(String topic) {
    print('Subscription confirmed for topic $topic');
    subscriptionState = MqttSubscriptionState.SUBSCRIBED;
  }

  void _onDisconnected() {
    print('OnDisconnected client callback - Client disconnection');
    connectionState = MqttCurrentConnectionState.DISCONNECTED;
  }

  void _onConnected() {
    connectionState = MqttCurrentConnectionState.CONNECTED;
    print('OnConnected client callback - Client connection was sucessful');
  }
}
