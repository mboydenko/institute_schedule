import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';

class FirebaseMessagingService {
  List<Function(RemoteMessage)> _onMessageListeners = [];

  String? _token;

  FirebaseMessagingService() {
    FirebaseMessaging.instance.getToken().then((token) {
      _token = token;
    });
  }

  void onMessageAdd(Function(RemoteMessage) listener) {
    _onMessageListeners.add(listener);
  }

  void onMessageRemove(Function(RemoteMessage) listener) {
    _onMessageListeners.remove(listener);
  }

  void editSettings(NotificationSettings settings) {}

  void startListening() {
    FirebaseMessaging.onMessage.listen(_onRemoteMessage);
  }

  void stopListening() {}

  void _onRemoteMessage(RemoteMessage message) {
    if (message.notification != null) {
      for (var listener in _onMessageListeners) {
        listener(message);
      }
    }
  }
}
