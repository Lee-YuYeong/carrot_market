
import 'dart:developer';

import 'package:fast_app_base/app.dart';
import 'package:fast_app_base/common/common.dart';
import 'package:fast_app_base/screen/main/fab/w_floating_daangn_button.riverpod.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class FcmManager {
  static void requestPermission() {
    FirebaseMessaging.instance.requestPermission();
  }

  //ref를 받는 이유 : 스낵바 띄울 때 FAB를 감추기 위함
  static void initialize(WidgetRef ref) async {
  // Foregroud 상태 (resumed)
  FirebaseMessaging.onMessage.listen((message) async {
    final title = message.notification?.title;
    if(title == null) {
      return;
    }

    ref.read(floatingButtonStateProvider.notifier).hideButton();
    final controller = App.navigatorKey.currentContext?.showSnackbar(
      title,
      extraButton: Tap(
        onTap: () {
          App.navigatorKey.currentContext!.go(message.data['deeplink']);
        },
        child: const Padding(
          padding: EdgeInsets.all(20),
          child: Text('열기', style: TextStyle(fontWeight: FontWeight.bold),),
        ),
      )
    );
    await controller?.closed;
    ref.read(floatingButtonStateProvider.notifier).showButton();
  });

  // Background 상태 (paused)
  FirebaseMessaging.onMessageOpenedApp.listen((message) {
    App.navigatorKey.currentContext!.go(message.data['deeplink']);
  });

  // Not Running 상태 (detached)
  final firstMessage = await FirebaseMessaging.instance.getInitialMessage();
  if (firstMessage != null) {
    await sleepUntil(() => App.navigatorKey.currentContext != null && App.navigatorKey.currentContext!.mounted);
    App.navigatorKey.currentContext!.go(firstMessage.data['deeplink']);
  }

    final token = await FirebaseMessaging.instance.getToken();
    print('aaaaa $token');
  }
}