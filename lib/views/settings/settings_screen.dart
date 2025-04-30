import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../view_models/app_view_model.dart';
import '../../view_models/purchase_view_model.dart';
import '../../resources/app_strings.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  Future<void> _handlePurchase(
    BuildContext context,
    PurchaseViewModel purchaseVM,
  ) async {
    final success = await purchaseVM.buyPremium();
    if (success && context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('You are now a Premium user!')),
      );
    } else if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Purchase failed. Please try again.'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  Future<void> _handleRestore(
    BuildContext context,
    PurchaseViewModel purchaseVM,
  ) async {
    await purchaseVM.restorePurchases();
    if (context.mounted) {
      if (purchaseVM.isPremium) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Purchases restored successfully!')),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('No purchases found to restore.'),
            backgroundColor: Colors.orange,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: ListView(
        children: [
          ListTile(
            title: const Text('Theme'),
            trailing: Consumer<PurchaseViewModel>(
              builder: (context, purchaseVM, _) {
                final isPremium = purchaseVM.isPremium;
                return DropdownButton<int>(
                  value: context.watch<AppViewModel>().settings?.themeId ?? 0,
                  items: const [
                    DropdownMenuItem(value: 0, child: Text('Blue')),
                    DropdownMenuItem(value: 1, child: Text('Yellow')),
                    DropdownMenuItem(value: 2, child: Text('Coral')),
                    DropdownMenuItem(value: 3, child: Text('Mint')),
                    DropdownMenuItem(value: 4, child: Text('Purple')),
                  ],
                  onChanged: (value) {
                    if (value == null) return;
                    if (!isPremium && value != 0) {
                      showDialog(
                        context: context,
                        builder:
                            (context) => AlertDialog(
                              title: const Text('Upgrade to Premium'),
                              content: SizedBox(
                                width: 300,
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: const [
                                    Text(
                                      'Custom themes are a premium feature.',
                                    ),
                                    SizedBox(height: 12),
                                    Text('Premium unlocks:'),
                                    SizedBox(height: 4),
                                    Text('• Unlimited events'),
                                    Text('• All custom themes'),
                                  ],
                                ),
                              ),
                              actions: [
                                TextButton(
                                  onPressed: () => Navigator.pop(context),
                                  child: const Text('Cancel'),
                                ),
                                ElevatedButton(
                                  onPressed: () async {
                                    Navigator.pop(context);
                                    await _handlePurchase(context, purchaseVM);
                                  },
                                  child: const Text('Upgrade to Premium'),
                                ),
                              ],
                            ),
                      );
                      return;
                    }
                    context.read<AppViewModel>().toggleTheme(value);
                  },
                  disabledHint: const Text('Upgrade for more themes'),
                );
              },
            ),
          ),
          if (!context.watch<PurchaseViewModel>().isPremium)
            ListTile(
              title: const Text(AppStrings.upgrade),
              trailing: const Icon(Icons.arrow_forward_ios),
              onTap:
                  () => _handlePurchase(
                    context,
                    context.read<PurchaseViewModel>(),
                  ),
            ),
          // Restore Purchases for iOS
          if (Theme.of(context).platform == TargetPlatform.iOS)
            ListTile(
              title: const Text('Restore Purchases'),
              trailing: const Icon(Icons.restore),
              onTap:
                  () => _handleRestore(
                    context,
                    context.read<PurchaseViewModel>(),
                  ),
            ),
        ],
      ),
    );
  }
}
