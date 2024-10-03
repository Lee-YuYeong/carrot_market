
import 'package:firebase_messaging/firebase_messaging.dart';

class FcmManager {
  static void requestPermission() {
    FirebaseMessaging.instance.requestPermission();
  }

  static void initialize() async {
  // Foregroud 상태 (resumed)
  FirebaseMessaging.onMessage.listen((message) {
    print('$message');
  });

  // Background 상태 (paused)

  // Not Running 상태 (detached)



    final token = await FirebaseMessaging.instance.getToken();
    print('aaaaa $token');
  }
}