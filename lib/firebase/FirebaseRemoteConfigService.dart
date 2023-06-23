import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/material.dart';
import 'package:subway_ody/firebase/FirebaseRemoteConfigKeys.dart';

class FirebaseRemoteConfigService {
  FirebaseRemoteConfigService._() : _remoteConfig = FirebaseRemoteConfig.instance;

  static FirebaseRemoteConfigService? _instance;
  factory FirebaseRemoteConfigService() => _instance ??= FirebaseRemoteConfigService._();

  final FirebaseRemoteConfig _remoteConfig;

  String getString(String key) => _remoteConfig.getString(key);
  bool getBool(String key) =>_remoteConfig.getBool(key);
  int getInt(String key) =>_remoteConfig.getInt(key);
  double getDouble(String key) =>_remoteConfig.getDouble(key);

  String get aosVersionFromStore => _remoteConfig.getString(FirebaseRemoteConfigKeys.latest_version_aos);
  String get iosVersionFromStore => _remoteConfig.getString(FirebaseRemoteConfigKeys.latest_version_ios);

  Future<void> _setConfigSettings() async => _remoteConfig.setConfigSettings(
    RemoteConfigSettings(
      fetchTimeout: const Duration(minutes: 1),
      minimumFetchInterval: const Duration(hours: 12),
    ),
  );

  Future<void> _setDefaults() async => _remoteConfig.setDefaults(
    const {
      FirebaseRemoteConfigKeys.latest_version_aos: '0.0.0',
      FirebaseRemoteConfigKeys.latest_version_ios: '0.0.0',
    },
  );

  Future<void> _fetchAndActivate() async {
    bool updated = await _remoteConfig.fetchAndActivate();

    if (updated) {
      debugPrint('The config has been updated.');
    } else {
      debugPrint('The config is not updated..');
    }
  }

  Future<void> initialize() async {
    await _setConfigSettings();
    await _setDefaults();
    await _fetchAndActivate();
  }

}