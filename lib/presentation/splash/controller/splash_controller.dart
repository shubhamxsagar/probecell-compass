import 'dart:async';
import 'package:get/get.dart';
import '../../../core/services/auth_service.dart';
import '../../../routes/app_routes.dart';


class SplashController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    Timer(const Duration(seconds: 1,milliseconds: 250), () {
      // FlutterNativeSplash.remove();
      bool isUserLoggedIn = Get.find<AuthService>().checkUserLogin();
    });
  }
}
