import 'package:shared_preferences/shared_preferences.dart';

class PrefUtils {
  static SharedPreferences? _sharedPreferences;
    static const _lastSyncedKey = 'lastSyncedTimestamp';


  PrefUtils() {
    SharedPreferences.getInstance().then((value) {
      _sharedPreferences = value;
    });
  }

  Future<PrefUtils> init() async {
    _sharedPreferences ??= await SharedPreferences.getInstance();
    return this;
  }

    Future<DateTime> getLastSyncedTimestamp() async {
    final prefs = await SharedPreferences.getInstance();
    final timestamp = prefs.getInt(_lastSyncedKey);
    return timestamp != null ? DateTime.fromMillisecondsSinceEpoch(timestamp) : DateTime.fromMillisecondsSinceEpoch(0);
  }

  Future<void> setLastSyncedTimestamp(DateTime timestamp) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_lastSyncedKey, timestamp.millisecondsSinceEpoch);
  }

  void clearPreferencesData() async {
    _sharedPreferences?.clear();
  }

  Future<void> setAuthToken(String value) {
    return _sharedPreferences!.setString('authToken', value);
  }

  String getAuthToken() {
    try {
      return _sharedPreferences!.getString('authToken') ?? '';
    } catch (e) {
      return 'error';
    }
  }

  Future<void> setAuthPhoneNo(String value) {
    return _sharedPreferences!.setString('authPhoneNo', value);
  }

  String getAuthPhoneNo() {
    try {
      return _sharedPreferences!.getString('authPhoneNo') ?? '';
    } catch (e) {
      return 'error';
    }
  }

  Future<void> setFcmToken(String value) {
    return _sharedPreferences!.setString('fcmToken', value);
  }

  String getFcmToken() {
    try {
      return _sharedPreferences!.getString('fcmToken') ?? '';
    } catch (e) {
      return 'error';
    }
  }

  Future<void> setIsConnectedToNetwork(bool value) {
    return _sharedPreferences!.setBool('isConnectedToNetwork', value);
  }

  bool getIsConnectedToNetwork() {
    try {
      return _sharedPreferences!.getBool('isConnectedToNetwork') ?? false;
    } catch (e) {
      return false;
    }
  }


  Future<void> setAppVersionName(String value) {
    return _sharedPreferences!.setString('appVersionName', value);
  }

  String getAppVersionName() {
    try {
      return _sharedPreferences!.getString('appVersionName') ?? '';
    } catch (e) {
      return 'error';
    }
  }

  Future<void> setAppVersionNumber(String value) {
    return _sharedPreferences!.setString('appVersionNumber', value);
  }

  String getAppVersionNumber() {
    try {
      return _sharedPreferences!.getString('appVersionNumber') ?? '';
    } catch (e) {
      return 'error';
    }
  }

  Future<void> setAppPlatform(String value) {
    return _sharedPreferences!.setString('appPlatform', value);
  }

  String getAppPlatform() {
    try {
      return _sharedPreferences!.getString('appPlatform') ?? '';
    } catch (e) {
      return 'error';
    }
  }

  Future<void> setOsVersion(String value) {
    return _sharedPreferences!.setString('osVersion', value);
  }

  String getOsVersion() {
    try {
      return _sharedPreferences!.getString('osVersion') ?? '';
    } catch (e) {
      return 'error';
    }
  }

  Future<void> setDeviceName(String value) {
    return _sharedPreferences!.setString('deviceName', value);
  }

  String getDeviceName() {
    try {
      return _sharedPreferences!.getString('deviceName') ?? '';
    } catch (e) {
      return 'error';
    }
  }

  Future<void> setAndroidUpdateType(String value) {
    return _sharedPreferences!.setString('androidUpdateType', value);
  }

  String getAndroidUpdateType() {
    try {
      return _sharedPreferences!.getString('androidUpdateType') ?? '';
    } catch (e) {
      return 'error';
    }
  }

  Future<void> setIosUpdateType(String value) {
    return _sharedPreferences!.setString('iosUpdateType', value);
  }

  String getIosUpdateType() {
    try {
      return _sharedPreferences!.getString('iosUpdateType') ?? '';
    } catch (e) {
      return 'error';
    }
  }

  Future<void> setIosLatestVersionNumber(String value) {
    return _sharedPreferences!.setString('iosLatestVersionNumber', value);
  }

  String getIosLatestVersionNumber() {
    try {
      return _sharedPreferences!.getString('iosLatestVersionNumber') ?? '';
    } catch (e) {
      return 'error';
    }
  }

  Future<void> setIosAppLink(String value) {
    return _sharedPreferences!.setString('iosAppLink', value);
  }

  String getIosAppLink() {
    try {
      return _sharedPreferences!.getString('iosAppLink') ?? '';
    } catch (e) {
      return 'error';
    }
  }




// Future<void> setUserDetailId(String value) {
//     print('setUserDetailId: $value');
//     return _sharedPreferences!.setString('userDetailId', value);
//   }

//   String getUserDetailId() {
//     try {
//       return _sharedPreferences!.getString('userDetailId') ?? '';
//     } catch (e) {
//       return 'error';
//     }
//   }




  Future<void> setUserId(String value) {
    return _sharedPreferences!.setString('userId', value);
  }

  String getUserId() {
    try {
      return _sharedPreferences!.getString('userId') ?? '';
    } catch (e) {
      return 'error';
    }
  }

//   Future<void> setUserToken(String value) {
//     return _sharedPreferences!.setString('userToken', value);
//   }

//   String getUserToken() {
//     try {
//       return _sharedPreferences!.getString('userToken') ?? '';
//     } catch (e) {
//       return 'error';
//     }
//   }
}

