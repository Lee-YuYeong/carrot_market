import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'app.dart';
import 'common/data/preference/app_preferences.dart';
import 'package:timeago/timeago.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await AppPreferences.init();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  final firstMessage = await FirebaseMessaging.instance.getInitialMessage();
  if (firstMessage != null) {
    log('sdjfngzfkn');
    // await sleepUntil(() => App.navigatorKey.currentContext != null && App.navigatorKey.currentContext!.mounted);
    // App.navigatorKey.currentContext?.go(firstMessage.data['deeplink']);
  }
  

  setLocaleMessages('ko', KoMessages());
  runApp(EasyLocalization(
      supportedLocales: const [Locale('en'), Locale('ko')],
      fallbackLocale: const Locale('en'),
      path: 'assets/translations',
      useOnlyLangCode: true,
      child: const ProviderScope(child: App())));
}
