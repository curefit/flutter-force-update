import 'package:flutter/material.dart';
import '../models/force_update_config.dart';

class ForceUpdateBottomSheet extends StatelessWidget {
  final ForceUpdateConfig config;

  const ForceUpdateBottomSheet({
    super.key,
    required this.config,
  });

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => !config.forcedUpdate,
      child: Container(
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: Theme.of(context).scaffoldBackgroundColor,
          borderRadius: const BorderRadius.vertical(
            top: Radius.circular(16),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 8),
            Center(
              child: Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
            const SizedBox(height: 24),
            Text(
              config.title,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            Text(
              config.message,
              style: Theme.of(context).textTheme.bodyMedium,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () {
                if (config.onUpdatePressed != null) {
                  config.onUpdatePressed!();
                }
                Navigator.of(context).pop();
              },
              child: Text(config.updateButtonText),
            ),
            if (!config.forcedUpdate && config.laterButtonText != null) ...[
              const SizedBox(height: 12),
              TextButton(
                onPressed: () {
                  if (config.onLaterPressed != null) {
                    config.onLaterPressed!();
                  }
                  Navigator.of(context).pop();
                },
                child: Text(config.laterButtonText!),
              ),
            ],
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
