import 'dart:async';
import 'package:flutter/foundation.dart';
import '../services/interfaces.dart';
import '../services/storage_service.dart';
import '../models/settings.dart';
import '../services/purchase_service.dart';

class PurchaseViewModel extends ChangeNotifier {
  final IPurchaseService purchaseService;
  final StorageService storageService;
  bool isPremium = false;
  StreamSubscription<bool>? _purchaseSubscription;

  PurchaseViewModel(this.purchaseService, this.storageService) {
    _loadPremiumStatus();
    if (purchaseService is PurchaseService) {
      _purchaseSubscription = (purchaseService as PurchaseService)
          .purchaseStream
          .listen((isPremium) => _updatePremiumStatus(isPremium));
    }
  }

  Future<void> _loadPremiumStatus() async {
    final settings = await storageService.getSettings();
    isPremium = settings?.isPremium ?? false;
    notifyListeners();
  }

  Future<bool> buyPremium() async {
    final success = await purchaseService.buyPremium();
    if (success) {
      await _updatePremiumStatus(true);
    }
    return success;
  }

  Future<void> restorePurchases() async {
    await purchaseService.restorePurchases();
    // The actual status update will happen through the purchase stream
  }

  Future<void> _updatePremiumStatus(bool status) async {
    isPremium = status;
    final settings =
        await storageService.getSettings() ?? Settings.defaultSettings();
    final updatedSettings = settings.copyWith(isPremium: status);
    await storageService.saveSettings(updatedSettings);
    notifyListeners();
  }

  @override
  void dispose() {
    _purchaseSubscription?.cancel();
    super.dispose();
  }
}
