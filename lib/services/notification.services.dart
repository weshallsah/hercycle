import 'dart:math';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationServices {
  FirebaseMessaging messaging = FirebaseMessaging.instance;
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  void firebaseinit() {
    FirebaseMessaging.onMessage.listen(
      (message) {
        print(message.notification?.title.toString());
        shownotification(message);
        print("notification is called");
      },
    );
  }

  Future<void> shownotification(RemoteMessage message) async {
    try {
      final id = Random.secure().nextInt(1000000).toString();
      initlocalnotifications(message);
      AndroidNotificationChannel androidNotificationChannel =
          AndroidNotificationChannel(
        id,
        "hercycle-notification",
        importance: Importance.max,
        description: "notification for cycle update",
      );

      AndroidNotificationDetails androidNotificationDetails =
          AndroidNotificationDetails(
        androidNotificationChannel.id,
        androidNotificationChannel.name,
        importance: androidNotificationChannel.importance,
        channelDescription: androidNotificationChannel.description,
        priority: Priority.high,
        ticker: "ticker",
      );
      NotificationDetails notificationDetails =
          NotificationDetails(android: androidNotificationDetails);

      Future.delayed(
          Duration.zero,
          () => flutterLocalNotificationsPlugin.show(
              0,
              message.notification?.title.toString(),
              message.notification?.body.toString(),
              notificationDetails));
    } catch (e) {
      print("Error ${e}");
    }
  }

  void initlocalnotifications(RemoteMessage message) async {
    var androidinit = AndroidInitializationSettings("@mipmap/ic_launcher");
    var initsetting = InitializationSettings(android: androidinit);
    await flutterLocalNotificationsPlugin.initialize(
      initsetting,
      onDidReceiveNotificationResponse: (payload) {},
    );
  }

  void requestNotificationPermission() async {
    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
      carPlay: true,
      criticalAlert: true,
      provisional: true,
      announcement: true,
    );
    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      print("user granted permisiion");
    } else if (settings.authorizationStatus ==
        AuthorizationStatus.provisional) {
      print("user provisional permisiion");
    } else {
      print("user not granted permisiion");
    }
  }

  Future<String> gettoken() async {
    String? token = await messaging.getToken();
    // print()
    return token!;
  }
}
