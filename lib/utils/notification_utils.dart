import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import '../resources/hive_keys.dart';

class NotificationUtils {
  static String? getEventIdFromPayload(String? payload) {
    if (payload == null) return null;
    final parts = payload.split(':');
    if (parts.length != 2 || parts[0] != HiveKeys.payloadEventId) return null;
    return parts[1];
  }
}
