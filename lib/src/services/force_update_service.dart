import 'dart:io';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:package_info_plus/package_info_plus.dart';

class ForceUpdateService {
  final FirebaseRemoteConfig _remoteConfig;
  final String androidVersionKey;
  final String iosVersionKey;

  ForceUpdateService({
    FirebaseRemoteConfig? remoteConfig,
    this.androidVersionKey = 'minimum_android_version',
    this.iosVersionKey = 'minimum_ios_version',
  }) : _remoteConfig = remoteConfig ?? FirebaseRemoteConfig.instance;

  Future<bool> needsUpdate() async {
    try {
      await _remoteConfig.setConfigSettings(RemoteConfigSettings(
        fetchTimeout: const Duration(seconds: 10),
        minimumFetchInterval:
            const Duration(seconds: 0), // Fetch latest values every time
      ));
      await _remoteConfig.fetchAndActivate();
      print('Fetching and activating remote config');
      final PackageInfo packageInfo = await PackageInfo.fromPlatform();
      final String currentVersion = packageInfo.version;
      print('Current version: $currentVersion');
      final String minimumVersion = Platform.isIOS
          ? _remoteConfig.getString(iosVersionKey)
          : _remoteConfig.getString(androidVersionKey);
      print('Minimum version: $minimumVersion');
      if (minimumVersion.isEmpty) return false;
      print('Comparing versions: $currentVersion and $minimumVersion');
      return _compareVersions(currentVersion, minimumVersion);
    } catch (e) {
      print('Error in needsUpdate: $e');
      // In case of any errors, don't force update
      return false;
    }
  }

  bool _compareVersions(String currentVersion, String minimumVersion) {
    List<int> current = currentVersion.split('.').map(int.parse).toList();
    List<int> minimum = minimumVersion.split('.').map(int.parse).toList();
    print('Comparing versions: $current and $minimum');
    // Pad with zeros if versions have different lengths
    while (current.length < minimum.length) current.add(0);
    while (minimum.length < current.length) minimum.add(0);
    print('Padded versions: $current and $minimum');
    for (int i = 0; i < current.length; i++) {
      print('Comparing index $i: ${current[i]} and ${minimum[i]}');
      if (current[i] < minimum[i]) return true;
      if (current[i] > minimum[i]) return false;
    }
    print('Versions are equal');
    return false;
  }

  Future<void> setDefaultConfigValues() async {
    await _remoteConfig.setDefaults({
      androidVersionKey: '1.0.0',
      iosVersionKey: '1.0.0',
    });
  }
}
