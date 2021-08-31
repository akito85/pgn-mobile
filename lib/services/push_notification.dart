import 'dart:io';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

class PushNotification extends ChangeNotifier {
  final _firebaseMessaging = FirebaseMessaging();
  String fcmToken;

  Future<void> firebaseCloudMessagingListeners() async {
    if (Platform.isIOS) _iosPermission();

    await _firebaseMessaging.getToken().then((token) {
      fcmToken = token;
    });

    _firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) async {},
      onResume: (Map<String, dynamic> message) async {},
      onLaunch: (Map<String, dynamic> message) async {},
      onBackgroundMessage: (Map<String, dynamic> message) async {},
    );
  }

  void _iosPermission() {
    _firebaseMessaging.requestNotificationPermissions(
        IosNotificationSettings(sound: true, badge: true, alert: true));
    _firebaseMessaging.onIosSettingsRegistered
        .listen((IosNotificationSettings settings) {});
  }
}
