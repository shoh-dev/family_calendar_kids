import 'dart:async';
import 'package:flutter/foundation.dart';
import '../services/interfaces.dart';
import '../services/storage_service.dart';
import '../models/settings.dart';
import '../services/purchase_service.dart';

class PurchaseViewModel extends ChangeNotifier {
  final IPurchaseService _purchaseService;
  final IStorageService _storage;
  bool _isPremium = false;
  StreamSubscription<bool>? _purchaseSubscription;

  PurchaseViewModel(this._purchaseService, this._storage) {
    loadPremiumStatus();
    if (_purchaseService is PurchaseService) {
      _purchaseSubscription = _purchaseService.purchaseStream.listen((
        isPremium,
      ) {
        _isPremium = isPremium;
        _updatePremiumStatus(isPremium);
        notifyListeners();
      });
    }
  }

  bool get isPremium => _isPremium;

  Future<void> loadPremiumStatus() async {
    final settings = await _storage.getSettings();
    _isPremium = settings?.isPremium ?? false;
    notifyListeners();
  }

  Future<bool> buyPremium() async {
    final success = await _purchaseService.buyPremium();
    if (success) {
      _isPremium = true;
      await _updatePremiumStatus(true);
      notifyListeners();
    }
    return success;
  }

  Future<void> restorePurchases() async {
    await _purchaseService.restorePurchases();
    // The actual status update will happen through the purchase stream
  }

  Future<void> _updatePremiumStatus(bool isPremium) async {
    final settings = await _storage.getSettings();
    if (settings != null) {
      await _storage.saveSettings(settings.copyWith(isPremium: isPremium));
    }
  }

  @override
  void dispose() {
    _purchaseSubscription?.cancel();
    super.dispose();
  }
}
