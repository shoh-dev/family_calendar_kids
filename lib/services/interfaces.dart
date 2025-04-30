import '../models/family_event.dart';
import '../models/settings.dart';

abstract class IStorageService {
  Future<void> init();

  // Events
  Future<List<FamilyEvent>> getEvents();
  Future<void> upsertEvent(FamilyEvent event);
  Future<void> deleteEvent(String id);

  // Settings
  Future<Settings?> getSettings();
  Future<void> saveSettings(Settings settings);
}

abstract class INotificationService {
  Future<void> init();
  Future<void> scheduleTodayReminder(FamilyEvent event, int notificationId);
  Future<void> cancel(int notificationId);
}

abstract class IPurchaseService {
  Future<void> init();
  Future<bool> buyPremium();
  Future<void> restorePurchases();
}
