import 'dart:async';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'interfaces.dart';

class PurchaseService implements IPurchaseService {
  final _iap = InAppPurchase.instance;
  final _productId = 'premium_unlock';
  StreamSubscription<List<PurchaseDetails>>? _subscription;
  final _purchaseController = StreamController<bool>.broadcast();
  bool _isAvailable = false;

  Stream<bool> get purchaseStream => _purchaseController.stream;

  @override
  Future<void> init() async {
    _isAvailable = await _iap.isAvailable();
    if (!_isAvailable) {
      print('Store not available');
      return;
    }

    _subscription = _iap.purchaseStream.listen(
      (purchaseDetailsList) {
        _listenToPurchaseUpdated(purchaseDetailsList);
      },
      onDone: () {
        _subscription?.cancel();
      },
      onError: (error) {
        print('Purchase stream error: $error');
        _purchaseController.add(false);
      },
    );
  }

  void _listenToPurchaseUpdated(List<PurchaseDetails> purchaseDetailsList) {
    for (final purchaseDetails in purchaseDetailsList) {
      if (purchaseDetails.status == PurchaseStatus.pending) {
        print('Purchase pending');
      } else if (purchaseDetails.status == PurchaseStatus.error) {
        print('Purchase error: ${purchaseDetails.error}');
        _purchaseController.add(false);
      } else if (purchaseDetails.status == PurchaseStatus.purchased ||
          purchaseDetails.status == PurchaseStatus.restored) {
        print('Purchase successful');
        _verifyPurchase(purchaseDetails);
      }
      if (purchaseDetails.pendingCompletePurchase) {
        _iap.completePurchase(purchaseDetails);
      }
    }
  }

  Future<void> _verifyPurchase(PurchaseDetails purchaseDetails) async {
    // In production: Verify the purchase with your backend
    // For now, we'll just verify the product ID matches
    if (purchaseDetails.productID == _productId) {
      _purchaseController.add(true);
    } else {
      print('Invalid product ID: ${purchaseDetails.productID}');
      _purchaseController.add(false);
    }
  }

  @override
  Future<bool> buyPremium() async {
    if (!_isAvailable) {
      print('Store not available');
      return false;
    }

    try {
      final details = await _iap.queryProductDetails({_productId});
      if (details.notFoundIDs.isNotEmpty) {
        print('Product not found: ${details.notFoundIDs}');
        return false;
      }

      final purchaseParam = PurchaseParam(
        productDetails: details.productDetails.first,
      );

      return _iap.buyConsumable(purchaseParam: purchaseParam);
    } catch (e) {
      print('Error buying premium: $e');
      return false;
    }
  }

  @override
  Future<void> restorePurchases() async {
    if (!_isAvailable) {
      print('Store not available');
      return;
    }

    try {
      await _iap.restorePurchases();
    } catch (e) {
      print('Error restoring purchases: $e');
    }
  }

  void dispose() {
    _subscription?.cancel();
    _purchaseController.close();
  }
}
