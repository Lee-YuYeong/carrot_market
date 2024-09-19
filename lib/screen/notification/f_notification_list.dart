import 'package:fast_app_base/screen/notification/provider/notofication_provider.dart';
import 'package:fast_app_base/screen/notification/vo/vo_notification_dummies.dart';
import 'package:fast_app_base/screen/notification/w_notification_item.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class NotificationFragment extends HookConsumerWidget {
  const NotificationFragment({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final list = ref.watch(notificationProvider);

    return list == [] 
    ? const Center(child: CircularProgressIndicator(),) 
    : ListView(
      children: [
        ...list.map((item) => NotificationItemWidget(notification: item, onTap: () {})).toList()
      ],
    );
  }
}