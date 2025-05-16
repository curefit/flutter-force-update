<!--
This README describes the package. If you publish this package to pub.dev,
this README's contents appear on the landing page for your package.

For information about how to write a good package README, see the guide for
[writing package pages](https://dart.dev/tools/pub/writing-package-pages).

For general information about developing packages, see the Dart guide for
[creating packages](https://dart.dev/guides/libraries/create-packages)
and the Flutter guide for
[developing packages and plugins](https://flutter.dev/to/develop-packages).
-->

# Force Update Package

A Flutter package that handles force updates using Firebase Remote Config. This package allows you to show a customizable bottom sheet when a new version of your app is available, with platform-specific version control for iOS and Android.

## Features

- Platform-specific version control (iOS and Android)
- Customizable bottom sheet UI
- Flexible update enforcement (forced or optional)
- Easy integration with Firebase Remote Config
- Semantic version comparison logic
- Modern bottom sheet design with Material You support

## Prerequisites

1. Firebase project set up in your app
2. Firebase Remote Config initialized
3. Flutter project with iOS and Android targets

## Installation

Add this to your package's `pubspec.yaml` file:

```yaml
dependencies:
  force_update_package: ^0.0.1
```

Install packages:

```bash
flutter pub get
```

## Firebase Setup

1. Initialize Firebase in your app (typically in `main.dart`):

```dart
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}
```

2. Set up Remote Config in Firebase Console:
   - Go to Firebase Console > Remote Config
   - Add two parameters:
     - `minimum_android_version` (default: "1.0.0")
     - `minimum_ios_version` (default: "1.0.0")
   - Set the version numbers according to your app's current version
   - Publish the changes

## Usage

### Basic Implementation

The simplest way to implement force update:

```dart
import 'package:force_update_package/force_update_package.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    super.initState();
    _checkForUpdates();
  }

  Future<void> _checkForUpdates() async {
    await ForceUpdate.checkForUpdate(context: context);
  }
}
```

### Custom Configuration

You can customize the update bottom sheet appearance and behavior:

```dart
import 'package:url_launcher/url_launcher.dart';

Future<void> _checkForUpdatesWithCustomConfig() async {
  final config = ForceUpdateConfig(
    title: 'Update Available 🚀',
    message: 'We\'ve added exciting new features! Update now to experience them.',
    updateButtonText: 'Get Latest Version',
    laterButtonText: 'Remind Me Later', // Remove for forced update
    forcedUpdate: true, // Set to false for optional updates
    onUpdatePressed: () async {
      // Handle update button press
      if (Platform.isIOS) {
        await launchUrl(Uri.parse('YOUR_APP_STORE_URL'));
      } else {
        await launchUrl(Uri.parse('YOUR_PLAY_STORE_URL'));
      }
    },
    onLaterPressed: () {
      // Handle "later" button press
      print('User postponed update');
    },
  );

  await ForceUpdate.checkForUpdate(
    context: context,
    config: config,
  );
}
```

### Custom Remote Config Keys

If you want to use different keys in Firebase Remote Config:

```dart
Future<void> _checkForUpdatesWithCustomKeys() async {
  final updateService = ForceUpdateService(
    androidVersionKey: 'my_android_version_key',
    iosVersionKey: 'my_ios_version_key',
  );

  await ForceUpdate.checkForUpdate(
    context: context,
    updateService: updateService,
  );
}
```

### Version Comparison Logic

The package uses semantic versioning for comparison:

- Version format: `MAJOR.MINOR.PATCH` (e.g., "1.0.0")
- Comparison is done segment by segment
- Examples:
  - "1.0.1" > "1.0.0" (update required)
  - "2.0.0" > "1.9.9" (update required)
  - "1.0.0" = "1.0.0" (no update required)
  - "1.0.0" < "0.9.9" (no update required)

## Best Practices

1. **Error Handling**: The package handles errors gracefully and defaults to not forcing updates in case of issues.

2. **Testing**: Test different scenarios:
   ```dart
   // Test forced update
   await ForceUpdate.checkForUpdate(
     context: context,
     config: ForceUpdateConfig(forcedUpdate: true),
   );

   // Test optional update
   await ForceUpdate.checkForUpdate(
     context: context,
     config: ForceUpdateConfig(
       forcedUpdate: false,
       laterButtonText: 'Later',
     ),
   );
   ```

3. **Platform-Specific Behavior**: Consider platform differences:
   ```dart
   final config = ForceUpdateConfig(
     message: Platform.isIOS 
       ? 'Update from the App Store'
       : 'Update from the Play Store',
     onUpdatePressed: () async {
       final url = Platform.isIOS
         ? 'YOUR_APP_STORE_URL'
         : 'YOUR_PLAY_STORE_URL';
       await launchUrl(Uri.parse(url));
     },
   );
   ```

## Troubleshooting

1. **Bottom Sheet Not Showing**:
   - Verify Firebase initialization
   - Check Remote Config parameters
   - Ensure version numbers are properly formatted

2. **Version Comparison Issues**:
   - Use semantic versioning format (X.Y.Z)
   - Check current app version in pubspec.yaml
   - Verify Remote Config values

## Contributing

Contributions are welcome! Please feel free to submit issues and pull requests.
# flutter-force-update
