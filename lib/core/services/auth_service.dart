import 'package:get/get.dart';
import 'package:probcell_solutions/core/services/shared_pref_service.dart';
import 'api_client.dart';

import 'package:flutter/material.dart';
import 'package:device_info_plus/device_info_plus.dart';

class AuthService extends GetxService {
  late bool isLogin;
  late String token;
  late String phoneNo;

  AuthService() {
    checkUserLogin();
  }

  Future<AuthService> init() async {
    return this;
  }

  bool checkUserLogin() {
    String storedAuthToken = Get.find<PrefUtils>().getAuthToken();
    String storedAuthPhoneNo = Get.find<PrefUtils>().getAuthPhoneNo();

    bool hasData = storedAuthToken.isNotEmpty && storedAuthToken!='error'
        && storedAuthPhoneNo.isNotEmpty && storedAuthPhoneNo!='error';

    if (hasData) {
      isLogin = true;
      Get.find<ApiClient>().addAuthTokenInHeader(storedAuthToken);
      token = storedAuthToken;
      phoneNo = storedAuthPhoneNo;
    } else {
      isLogin = false;
    }
    return isLogin;
  }

  Future setUserLogin(String authToken, String authPhoneNo) async {
    Get.find<PrefUtils>().setAuthToken(authToken);
    Get.find<PrefUtils>().setAuthPhoneNo(authPhoneNo);
    Get.find<ApiClient>().addAuthTokenInHeader(authToken);
    token = authToken;
    phoneNo = authPhoneNo;
  }

  Future<void> handleLogOut() async {
    try{
      removeUser();
    } catch(e) {
      print("error while signing out");
    }
  }

  Future removeUser() async {
    Get.find<PrefUtils>().setAuthToken('');
    Get.find<PrefUtils>().setAuthPhoneNo('');
    Get.find<ApiClient>().removeAuthTokenInHeader();
    // Get.offAllNamed(Routes.login);
  }


  Future<void> saveDeviceAndAppInfo() async {
    String appPlatform = 'android';
    bool isIOS = Theme.of(Get.context!).platform == TargetPlatform.iOS;

    String deviceName = '';
    String osVersion = '';
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();

    if(isIOS){
      appPlatform = 'ios';
      IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
      deviceName = iosInfo.utsname.machine;
      osVersion = iosInfo.systemVersion;
    }
    else{
      AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
      deviceName = androidInfo.model;
      osVersion = androidInfo.version.release;
    }

    Get.find<PrefUtils>().setDeviceName(deviceName);
    Get.find<PrefUtils>().setOsVersion(osVersion);
    Get.find<PrefUtils>().setAppPlatform(appPlatform);

    // PackageInfo packageInfo = await PackageInfo.fromPlatform();

    // String version = packageInfo.version;
    // String buildNumber = packageInfo.buildNumber;

    // Get.find<PrefUtils>().setAppVersionName(version);
    // Get.find<PrefUtils>().setAppVersionNumber(buildNumber);
  }

  bool get isLoginn => isLogin;
  String get tokenn => token;
  String get phoneNoo => phoneNo;
}
