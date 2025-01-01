import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class FireBaseApi {
  late final FirebaseMessaging msg;
  void settingNotrification() async {
    await msg.requestPermission(
      alert: true,
      sound: true,
      badge: true,
    );
  }

  Future settingNotification() async {
    final firebaseMessaging = FirebaseMessaging.instance;
    await firebaseMessaging.requestPermission();
  }

  void connectNotrifc() async {
    await Firebase.initializeApp();
    msg = FirebaseMessaging.instance; // initialize
    msg.setForegroundNotificationPresentationOptions(
      alert: true,
      sound: true,
      badge: true,
    );
    settingNotrification();

    FirebaseMessaging.onMessage.listen((RemoteMessage event) {
      print("this is the notrification msg : ${event.notification?.title}");

      msg.getToken().then((value) => print("token : $value"));
    });
  }
}
