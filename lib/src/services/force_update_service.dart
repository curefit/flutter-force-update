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
      await _remoteConfig.fetchAndActivate();

      final PackageInfo packageInfo = await PackageInfo.fromPlatform();
      final String currentVersion = packageInfo.version;

      final String minimumVersion = Platform.isIOS
          ? _remoteConfig.getString(iosVersionKey)
          : _remoteConfig.getString(androidVersionKey);

      if (minimumVersion.isEmpty) return false;

      return _compareVersions(currentVersion, minimumVersion);
    } catch (e) {
      // In case of any errors, don't force update
      return false;
    }
  }

  bool _compareVersions(String currentVersion, String minimumVersion) {
    List<int> current = currentVersion.split('.').map(int.parse).toList();
    List<int> minimum = minimumVersion.split('.').map(int.parse).toList();

    // Pad with zeros if versions have different lengths
    while (current.length < minimum.length) current.add(0);
    while (minimum.length < current.length) minimum.add(0);

    for (int i = 0; i < current.length; i++) {
      if (current[i] < minimum[i]) return true;
      if (current[i] > minimum[i]) return false;
    }

    return false;
  }

  Future<void> setDefaultConfigValues() async {
    await _remoteConfig.setDefaults({
      androidVersionKey: '1.0.0',
      iosVersionKey: '1.0.0',
    });
  }
}
