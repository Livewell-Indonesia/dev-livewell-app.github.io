import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:livewell/core/log.dart';

class FirebaseRemoteConfigService {
  FirebaseRemoteConfigService._() : _remoteConfig = FirebaseRemoteConfig.instance; // MODIFIED

  static FirebaseRemoteConfigService? _instance; // NEW
  factory FirebaseRemoteConfigService() => _instance ??= FirebaseRemoteConfigService._(); // NEW

  final FirebaseRemoteConfig _remoteConfig;

  String getString(String key) => _remoteConfig.getString(key); // NEW
  bool getBool(String key) => _remoteConfig.getBool(key); // NEW
  int getInt(String key) => _remoteConfig.getInt(key); // NEW
  double getDouble(String key) => _remoteConfig.getDouble(key); // NEW

  String get forceUpdateStatus => getString(FirebaseRemoteConfigKeys.forceUpdate); // NEW

  Future<void> _setConfigSettings() async {
    await _remoteConfig.setConfigSettings(RemoteConfigSettings(
      fetchTimeout: const Duration(seconds: 60),
      minimumFetchInterval: const Duration(seconds: 60),
    ));
  }

  Future<void> setDefaults() => _remoteConfig.setDefaults(<String, dynamic>{
        FirebaseRemoteConfigKeys.forceUpdate: 'none',
      });

  Future<void> fetchAndActivate() async {
    bool updated = await _remoteConfig.fetchAndActivate();
    if (updated) {
      Log.colorGreen('Remote config has been updated.');
    } else {
      Log.colorGreen('No update available.');
    }
  }

  Future<void> init() async {
    await _setConfigSettings();
    await setDefaults();
    await fetchAndActivate();
  }
}

class FirebaseRemoteConfigKeys {
  static const String forceUpdate = 'force_update';
}
