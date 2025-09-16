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
        decoration: BoxDecoration(
          color: config.backgroundColor ??
              Theme.of(context).scaffoldBackgroundColor,
          borderRadius: const BorderRadius.vertical(
            top: Radius.circular(16),
          ),
        ),
        child: SingleChildScrollView(
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
              config.headerWidget,
              const SizedBox(height: 16),
              Padding(
                padding:  EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width *0.3),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    elevation: 0,
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
                      style: config.buttonTextStyle ?? Theme.of(context).textTheme.titleMedium?.copyWith(
                            color: config.buttonTextColor,
                            fontWeight: FontWeight.bold,
                          ),),
                ),
              ),
              if (config.laterButtonText != null) ...[
                const SizedBox(height: 5),
                TextButton(
                  onPressed: () {
                    if (config.onLaterPressed != null) {
                      config.onLaterPressed!();
                    }
                  },
                  child: Text(config.laterButtonText!,
                      style: config.buttonTextStyle ??Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: config.laterButtonColor,
                            fontWeight: FontWeight.bold,
                          )),
                ),
              ],
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}
