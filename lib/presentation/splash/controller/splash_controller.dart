import 'dart:async';
import 'package:get/get.dart';
import 'package:probcell_solutions/core/services/api_client.dart';
import '../../../core/services/auth_service.dart';
import '../../../routes/app_routes.dart';

class SplashController extends GetxController {
  late ApiClient _apiClient;
  Rx<RxStatus> loginStatus = RxStatus.empty().obs;
  @override
  void onInit() {
    super.onInit();
    _apiClient = Get.find<ApiClient>();
    Timer(const Duration(seconds: 1, milliseconds: 250), () async {
      // FlutterNativeSplash.remove();
      bool isUserLoggedIn = Get.find<AuthService>().checkUserLogin();
      if (isUserLoggedIn) {
        // Get.offNamed(Routes.home);
        await checkUserAdmin();
      } else {
        Get.offNamed(Routes.login);
      }
    });
  }

  Future<void> checkUserAdmin() async {
    print('Checking user admin status...');
    loginStatus.value = RxStatus.loading();
    await _apiClient.isUserAdmin(
      onSuccess: (onSuccess) {
        print('User is admin: $onSuccess');
        Get.offAllNamed(Routes.admin);
        loginStatus.value = RxStatus.success();
        // print('User exists $onSuccess');
        // showErrorMessageSnackBar(scale, 'This page is under construction');
      },
      onError: (onError) {
        Get.offAllNamed(Routes.home);
        loginStatus.value = RxStatus.error();
        print('User not exists $onError');
      },
    );
  }
}
