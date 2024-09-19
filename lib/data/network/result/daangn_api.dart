import 'package:fast_app_base/common/cli_common.dart';
import 'package:fast_app_base/data/network/result/api_error.dart';
import 'package:fast_app_base/data/simple_result.dart';
import 'package:fast_app_base/screen/notification/vo/vo_notification.dart';
import 'package:fast_app_base/screen/notification/vo/vo_notification_dummies.dart';

class DaangnApi {
  static Future<SimpleResult<List<DaangnNotification>, ApiError>> getNotification() async {
    await sleepAsync(300.ms);
    return SimpleResult.success(notificationList);
  } 
}