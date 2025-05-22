import 'dart:io';
import 'package:flutter/material.dart';
import '../models/force_update_config.dart';
import 'package:url_launcher/url_launcher.dart';

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
                    color: config.textColor,
                  ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            Text(
              config.message,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: config.textColor,
                  ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: config.updateButtonColor,
              ),
              onPressed: () async {
                if (config.onUpdatePressed != null) {
                  config.onUpdatePressed!();
                } else {
                  if (Platform.isIOS) {
                    final uri = Uri.parse(config.iosStoreUrl!);
                    if (await canLaunchUrl(uri)) {
                      await launchUrl(uri,
                          mode: LaunchMode.externalApplication);
                    }
                  } else {
                    final uri = Uri.parse(config.androidStoreUrl!);
                    if (await canLaunchUrl(uri)) {
                      await launchUrl(uri,
                          mode: LaunchMode.externalApplication);
                    }
                  }
                }
              },
              child: Text(config.updateButtonText,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: config.textColor,
                        fontWeight: FontWeight.bold,
                      )),
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
                child: Text(config.laterButtonText!,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: config.laterButtonColor,
                           fontWeight: FontWeight.bold,
                        )),
              ),
            ],
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
