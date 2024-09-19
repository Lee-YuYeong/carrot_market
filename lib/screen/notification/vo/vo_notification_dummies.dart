import 'package:fast_app_base/common/cli_common.dart';
import 'package:fast_app_base/screen/notification/vo/notification_type.dart';
import 'package:fast_app_base/screen/notification/vo/vo_notification.dart';

final notification1 = DaangnNotification(NotificationType.offical, '당근 당근 우리 나라', '당근 나라에 있는 건 있는 거 뺴고 다 있음', DateTime.now());
final notification2 = DaangnNotification(NotificationType.local, '말림 입니다', '오늘은 아파서 아침도 점심도 안 먹었는데 배도 안고프당', DateTime.now().subtract(2.hours), isRead: true);
final notification3 = DaangnNotification(NotificationType.offical, '달림 입니다 ', '저녁 미팅 후후후ㅜㅎ', DateTime.now().subtract(3.hours));
final notification4 = DaangnNotification(NotificationType.legal, '오그 오구 지금 무얼 암ㄴ', '제목이라고 제목 있음', DateTime.now().subtract(12.hours));
final notification5 = DaangnNotification(NotificationType.offical, '8월 가계부가 도착함 ', '당근 나라에 있는 건 있는 거 뺴고 다 있음', DateTime.now().subtract(1.days));
final notification6 = DaangnNotification(NotificationType.local, '알림 입니다 ', '당근 나라에 있는 건 있는 거 뺴고 다 있음', DateTime.now().subtract(10.days), isRead: true);

final List<DaangnNotification> notificationList = [notification1, notification2, notification3, notification4, notification5, notification6];