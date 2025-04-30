import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../view_models/app_view_model.dart';
import '../../view_models/purchase_view_model.dart';
import '../../utils/extensions.dart';
import '../../models/settings.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  Future<void> _handlePurchase(
    BuildContext context,
    PurchaseViewModel purchaseVM,
  ) async {
    final success = await purchaseVM.buyPremium();
    if (!context.mounted) return;

    if (success) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Welcome to the Premium Family! 🎉'),
          backgroundColor: Colors.green,
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Oops! Something went wrong. Please try again.'),
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
    if (!context.mounted) return;

    if (purchaseVM.isPremium) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Your purchases have been restored! 🎉'),
          backgroundColor: Colors.green,
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('No previous purchases found.'),
          backgroundColor: Colors.orange,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    final isPremium = context.watch<PurchaseViewModel>().isPremium;

    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.settings, color: theme.colorScheme.primary),
            const SizedBox(width: 8),
            const Text('Settings'),
          ],
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: theme.colorScheme.surface,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Premium Status Card
          Card(
            elevation: 4,
            shadowColor: theme.colorScheme.primary.withOpacity(0.3),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: theme.colorScheme.primaryContainer,
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Icon(
                          isPremium ? Icons.star : Icons.star_border,
                          color: theme.colorScheme.primary,
                          size: 32,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              isPremium ? 'Premium Member' : 'Free Version',
                              style: theme.textTheme.titleLarge?.copyWith(
                                color: theme.colorScheme.primary,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              isPremium
                                  ? 'You have access to all features! 🎉'
                                  : 'Upgrade to unlock all features!',
                              style: theme.textTheme.bodyMedium?.copyWith(
                                color: theme.colorScheme.onSurface.withOpacity(
                                  0.7,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  if (!isPremium) ...[
                    const SizedBox(height: 16),
                    ElevatedButton.icon(
                      onPressed:
                          () => _handlePurchase(
                            context,
                            context.read<PurchaseViewModel>(),
                          ),
                      icon: const Icon(Icons.workspace_premium),
                      label: const Text('Upgrade to Premium'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: theme.colorScheme.primary,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 24,
                          vertical: 12,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),

          // Theme Selection Card
          Card(
            elevation: 4,
            shadowColor: theme.colorScheme.primary.withOpacity(0.3),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: theme.colorScheme.primaryContainer,
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Icon(
                          Icons.palette,
                          color: theme.colorScheme.primary,
                          size: 32,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Text(
                        'App Theme',
                        style: theme.textTheme.titleLarge?.copyWith(
                          color: theme.colorScheme.primary,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Consumer<PurchaseViewModel>(
                    builder: (context, purchaseVM, _) {
                      final isPremium = purchaseVM.isPremium;
                      return DropdownButtonFormField<int>(
                        value:
                            context.watch<AppViewModel>().settings?.themeId ??
                            0,
                        decoration: InputDecoration(
                          labelText: 'Select Theme',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),
                        items: const [
                          DropdownMenuItem(
                            value: 0,
                            child: Row(
                              children: [
                                Icon(Icons.circle, color: Color(0xFF5DA3FA)),
                                SizedBox(width: 8),
                                Text('Blue'),
                              ],
                            ),
                          ),
                          DropdownMenuItem(
                            value: 1,
                            child: Row(
                              children: [
                                Icon(Icons.circle, color: Color(0xFFFFC93C)),
                                SizedBox(width: 8),
                                Text('Yellow'),
                              ],
                            ),
                          ),
                          DropdownMenuItem(
                            value: 2,
                            child: Row(
                              children: [
                                Icon(Icons.circle, color: Color(0xFFFC766A)),
                                SizedBox(width: 8),
                                Text('Coral'),
                              ],
                            ),
                          ),
                          DropdownMenuItem(
                            value: 3,
                            child: Row(
                              children: [
                                Icon(Icons.circle, color: Color(0xFF71EFA3)),
                                SizedBox(width: 8),
                                Text('Mint'),
                              ],
                            ),
                          ),
                          DropdownMenuItem(
                            value: 4,
                            child: Row(
                              children: [
                                Icon(Icons.circle, color: Color(0xFFA46BFF)),
                                SizedBox(width: 8),
                                Text('Purple'),
                              ],
                            ),
                          ),
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
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
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
                                          await _handlePurchase(
                                            context,
                                            purchaseVM,
                                          );
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
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),

          // Restore Purchases Card
          Card(
            elevation: 4,
            shadowColor: theme.colorScheme.primary.withOpacity(0.3),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: theme.colorScheme.primaryContainer,
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Icon(
                          Icons.restore,
                          color: theme.colorScheme.primary,
                          size: 32,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Restore Purchases',
                              style: theme.textTheme.titleLarge?.copyWith(
                                color: theme.colorScheme.primary,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              'Restore your premium features if you\'ve reinstalled the app',
                              style: theme.textTheme.bodyMedium?.copyWith(
                                color: theme.colorScheme.onSurface.withOpacity(
                                  0.7,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton.icon(
                    onPressed:
                        () => _handleRestore(
                          context,
                          context.read<PurchaseViewModel>(),
                        ),
                    icon: const Icon(Icons.restore),
                    label: const Text('Restore Purchases'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: theme.colorScheme.primary,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 12,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),

          // About Card
          Card(
            elevation: 4,
            shadowColor: theme.colorScheme.primary.withOpacity(0.3),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: theme.colorScheme.primaryContainer,
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Icon(
                          Icons.info,
                          color: theme.colorScheme.primary,
                          size: 32,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Text(
                        'About',
                        style: theme.textTheme.titleLarge?.copyWith(
                          color: theme.colorScheme.primary,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Version 1.0.0',
                    style: theme.textTheme.bodyLarge?.copyWith(
                      color: theme.colorScheme.onSurface.withOpacity(0.7),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Made with ❤️ for families',
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: theme.colorScheme.onSurface.withOpacity(0.7),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Debug Card (only visible in debug mode)
          if (const bool.fromEnvironment('dart.vm.product') == false) ...[
            const SizedBox(height: 16),
            Card(
              elevation: 4,
              shadowColor: Colors.red.withOpacity(0.3),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: Colors.red.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Icon(
                            Icons.bug_report,
                            color: Colors.red,
                            size: 32,
                          ),
                        ),
                        const SizedBox(width: 16),
                        Text(
                          'Debug Options',
                          style: theme.textTheme.titleLarge?.copyWith(
                            color: Colors.red,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton.icon(
                            onPressed: () {
                              final settings =
                                  context.read<AppViewModel>().settings;
                              if (settings != null) {
                                context.read<AppViewModel>().toggleTheme(
                                  settings.themeId,
                                );
                              }
                            },
                            icon: const Icon(Icons.refresh),
                            label: const Text('Refresh Theme'),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.orange,
                              foregroundColor: Colors.white,
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: ElevatedButton.icon(
                            onPressed: () {
                              final settings =
                                  context.read<AppViewModel>().settings;
                              if (settings != null) {
                                final newSettings = settings.copyWith(
                                  isPremium: !isPremium,
                                );
                                context.read<AppViewModel>().updateSettings(
                                  newSettings,
                                );
                                // Force PurchaseViewModel to update
                                context
                                    .read<PurchaseViewModel>()
                                    .loadPremiumStatus();
                              }
                            },
                            icon: Icon(
                              isPremium ? Icons.lock : Icons.lock_open,
                            ),
                            label: Text(
                              isPremium
                                  ? 'Switch to Free'
                                  : 'Switch to Premium',
                            ),
                            style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  isPremium ? Colors.red : Colors.green,
                              foregroundColor: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
