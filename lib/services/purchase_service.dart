import 'package:in_app_purchase/in_app_purchase.dart';
import 'interfaces.dart';

class PurchaseService implements IPurchaseService {
  final _iap = InAppPurchase.instance;
  final _productId = 'premium_unlock';

  @override
  Future<void> init() async {
    // nothing yet – leave open for queryProductDetails later
  }

  @override
  Future<bool> buyPremium() async {
    final details = await _iap.queryProductDetails({_productId});
    if (details.notFoundIDs.isNotEmpty) return false;
    _iap.buyConsumable(
      purchaseParam: PurchaseParam(
        productDetails: details.productDetails.first,
      ),
    );
    // In production: listen to purchaseStream and verify receipt.
    return true; // optimistic
  }

  @override
  Future<void> restorePurchases() async => _iap.restorePurchases();
}
