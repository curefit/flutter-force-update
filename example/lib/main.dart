import 'dart:io';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:force_update_package/force_update_package.dart';
import 'package:url_launcher/url_launcher.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Force Update Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    super.initState();
    // Check for updates when the app starts
    _checkForUpdates();
  }

  Future<void> _checkForUpdates() async {
    final config = ForceUpdateConfig(
      headerWidget: const Text('Update Available 🚀'),
      updateButtonText: 'Update Now',
      laterButtonText: 'Remind Me Later', // Remove this for forced update
      forcedUpdate: false, // Set to true for forced update
      onUpdatePressed: () async {
        // Replace these URLs with your actual app store URLs
        final url = Platform.isIOS
            ? 'https://apps.apple.com/app/your-app-id'
            : 'https://play.google.com/store/apps/details?id=your.app.id';

        if (await canLaunchUrl(Uri.parse(url))) {
          await launchUrl(Uri.parse(url));
        }
      },
      onLaterPressed: () {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Update postponed')),
        );
      },
    );

    await ForceUpdate.checkForUpdate(
      context: context,
      config: config,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Force Update Demo'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Current App Version: 1.0.0'),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _checkForUpdates,
              child: const Text('Check for Updates'),
            ),
          ],
        ),
      ),
    );
  }
}
