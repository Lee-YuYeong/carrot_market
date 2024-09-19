import 'package:fast_app_base/common/common.dart';
import 'package:fast_app_base/screen/notification/f_notification_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final notificationEditModeProvider = StateProvider((ref) => false);

class NotificationScreen extends HookConsumerWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    
    final tabController = useTabController(initialLength: 2);
    final isEditMode = ref.watch(notificationEditModeProvider);

    return Material(
      child: Column(
        children: [
          AppBar(
            title: Text("알림"),
            actions: [
              Tap(
                onTap: () {
                  ref.read(notificationEditModeProvider.notifier).state = !isEditMode;
      
                }, 
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: isEditMode ? const Text("완료") : const Text("편집"),
                ),
              )
            ],
          ),
          TabBar(
            controller: tabController,
            labelStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            labelPadding: const EdgeInsets.symmetric(vertical: 20),
            indicatorColor: Colors.white,
            tabs: [Text("활동 알림"), Text("키워드 알림")],
          ),
          Expanded(
            child: TabBarView(
              controller: tabController,
              children: [
                NotificationFragment(),
                Container(
                  width: 100,
                  height: 100,
                  color: Colors.blue,
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
