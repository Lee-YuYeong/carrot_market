
import 'package:fast_app_base/common/common.dart';
import 'package:fast_app_base/screen/notification/provider/notofication_provider.dart';
import 'package:fast_app_base/screen/notification/s_notification.dart';
import 'package:fast_app_base/screen/notification/vo/vo_notification.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:timeago/timeago.dart' as timeago;


class NotificationItemWidget extends ConsumerStatefulWidget {
  final DaangnNotification notification;
  final VoidCallback onTap;
  const NotificationItemWidget({super.key, required this.notification, required this.onTap});

  @override
  ConsumerState<NotificationItemWidget> createState() => _NotificationItemWidgetState();
}

class _NotificationItemWidgetState extends ConsumerState<NotificationItemWidget> {

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isEditMode = ref.watch(notificationEditModeProvider.notifier);
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      color: widget.notification.isRead ? context.backgroundColor : Colors.grey.shade800,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row( 
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset(
                widget.notification.type.iconPath,
                width: 30,
                height: 30,
              ),
              Expanded(
                child: Text(
                  widget.notification.title,
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
              if (isEditMode.state) IconButton(onPressed: () {
                final list = ref.read(notificationProvider);
                list.remove(widget.notification);
                ref.read(notificationProvider.notifier).state = List.of(list);
              }, icon: const Icon(Icons.delete))
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.notification.description,
                  style: const TextStyle(fontSize: 12, fontWeight: FontWeight.normal),
                ),
                Text(
                  timeago.format(widget.notification.time, locale: context.locale.languageCode),
                  style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w200),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}