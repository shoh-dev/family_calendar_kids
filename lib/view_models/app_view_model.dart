import 'package:flutter/foundation.dart';
import '../services/interfaces.dart';
import '../models/settings.dart';

class AppViewModel extends ChangeNotifier {
  final IStorageService storage;
  Settings? settings;

  AppViewModel(this.storage);

  Future<void> load() async {
    settings = await storage.getSettings();
    notifyListeners();
  }

  Future<void> toggleTheme(int themeId) async {
    settings = settings!.copyWith(themeId: themeId);
    await storage.saveSettings(settings!);
    notifyListeners();
  }
}
