import 'dart:io';
import 'package:flutter/material.dart';
import 'package:force_update_package/force_update_package.dart';
import 'package:url_launcher/url_launcher.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    super.initState();
    // Check for updates when app starts
    checkForUpdates();
  }

  Future<void> checkForUpdates() async {
    // 1. Basic Usage - Simplest way to check for updates
    await ForceUpdate.checkForUpdate(context: context);

    // 2. Custom Configuration - More control over the update dialog
    final customConfig = ForceUpdateConfig(
      // Customize the title
      title: 'New Version Available! 🎉',
      // Custom message
      message: 'We\'ve added amazing new features. Update now to try them!',
      // Custom button text
      updateButtonText: 'Get Latest Version',
      // Optional: Add a "Later" button (remove for forced update)
      laterButtonText: 'Remind Me Later',
      // Set to true for forced update (user can't dismiss)
      forcedUpdate: false,
      // Handle update button press
      onUpdatePressed: () async {
        // Replace with your app's store URLs
        final storeUrl = Platform.isIOS
            ? 'https://apps.apple.com/app/your-app-id'
            : 'https://play.google.com/store/apps/details?id=your.package.name';

        final uri = Uri.parse(storeUrl);
        if (await canLaunchUrl(uri)) {
          await launchUrl(uri, mode: LaunchMode.externalApplication);
        }
      },
      // Handle "Later" button press
      onLaterPressed: () {
        // Show a confirmation message
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('You can update later from the settings'),
            duration: Duration(seconds: 2),
          ),
        );
      },
    );

    await ForceUpdate.checkForUpdate(
      context: context,
      config: customConfig,
    );

    // 3. Custom Remote Config Keys
    final customService = ForceUpdateService(
      // Use custom keys in Firebase Remote Config
      androidVersionKey: 'my_android_min_version',
      iosVersionKey: 'my_ios_min_version',
    );

    await ForceUpdate.checkForUpdate(
      context: context,
      updateService: customService,
    );
  }

  // Example: Check for updates when user taps a button
  Widget buildUpdateButton() {
    return ElevatedButton(
      onPressed: checkForUpdates,
      child: const Text('Check for Updates'),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My App'),
        actions: [
          // Add update check to menu
          IconButton(
            icon: const Icon(Icons.system_update),
            onPressed: checkForUpdates,
            tooltip: 'Check for Updates',
          ),
        ],
      ),
      body: Center(
        child: buildUpdateButton(),
      ),
    );
  }
}
