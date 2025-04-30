import 'package:flutter/foundation.dart';
import '../services/interfaces.dart';

class PurchaseViewModel extends ChangeNotifier {
  final IPurchaseService purchaseService;
  bool isPremium = false;

  PurchaseViewModel(this.purchaseService);

  Future<void> buyPremium() async {
    final success = await purchaseService.buyPremium();
    if (success) {
      isPremium = true;
      notifyListeners();
    }
  }

  Future<void> restorePurchases() async {
    await purchaseService.restorePurchases();
    // In production: verify receipt and update isPremium
  }
}
