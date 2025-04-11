import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:probcell_solutions/core/services/api_client.dart';
import 'package:probcell_solutions/core/services/auth_service.dart';
import 'package:probcell_solutions/core/utils/scaling_utils.dart';
import 'package:probcell_solutions/presentation/profile/user_info_model.dart';
import 'package:probcell_solutions/presentation/widgets/customSnackBar.dart';
import 'package:probcell_solutions/routes/app_routes.dart';

class LoginController extends GetxController {
  late ApiClient _apiClient;
  UserInfoModel? userInfoModel;
  TextEditingController emailController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController otpController = TextEditingController();

  RxBool obscureText = true.obs;
  RxInt currentScreen = 0.obs;

  Rx<RxStatus> loginStatus = RxStatus.empty().obs;

  void toggleObscureText() {
    obscureText.value = !obscureText.value;
  }

  void changeScreen(int index) {
    currentScreen.value = index;
  }

  @override
  void onInit() {
    _apiClient = Get.find<ApiClient>();
    super.onInit();
  }

  Future<void> checkUserLogin(ScalingUtility scale) async {
    if (emailController.text.isEmpty) {
      showErrorMessageSnackBar(scale, 'Please enter email');
      return;
    }
    loginStatus.value = RxStatus.loading();
    _apiClient.checkUserRegister(
      requestData: {
        'email': emailController.text,
      },
      onSuccess: (onSuccess) async {
        print('User exists $onSuccess');
        loginStatus.value = RxStatus.success();
        if (onSuccess['exists']) {
          currentScreen.value = 2;
        } else {
          await registerUser(scale);
        }
      },
      onError: (onError) {
        loginStatus.value = RxStatus.error();
        print('User not exists $onError');
      },
    );
  }

  Future<void> checkUserAdmin(ScalingUtility scale) async {
    loginStatus.value = RxStatus.loading();
    _apiClient.isUserAdmin(
      onSuccess: (onSuccess) {
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

  Future<void> loginUser(ScalingUtility scale) async {
    loginStatus.value = RxStatus.loading();
    _apiClient.login(
      requestData: {
        'email': emailController.text,
        'password': passwordController.text,
      },
      onSuccess: (onSuccess) async {
        Get.find<AuthService>().setUserLogin(onSuccess['token'], emailController.text);
        loginStatus.value = RxStatus.success();
        await checkUserAdmin(scale);
        // Get.offAllNamed(Routes.home);
        print('User login success $onSuccess');
      },
      onError: (onError) {
        loginStatus.value = RxStatus.error();
        showErrorMessageSnackBar(scale, onError['message']);
        print('User login error $onError');
      },
    );
  }

  Future<void> verifyOtp(ScalingUtility scale) async {
    loginStatus.value = RxStatus.loading();
    _apiClient.verifyOtp(
      requestData: {
        'email': emailController.text,
        'otp': otpController.text,
      },
      onSuccess: (onSuccess) {
        currentScreen.value = 3;
        Get.find<AuthService>().setUserLogin(onSuccess['token'], emailController.text);
        loginStatus.value = RxStatus.success();
        print('OTP verified $onSuccess');
      },
      onError: (onError) {
        showErrorMessageSnackBar(scale, onError['message']);
        loginStatus.value = RxStatus.error();

        print('OTP not verified $onError');
      },
    );
  }

  Future<void> registerUser(ScalingUtility scale) async {
    loginStatus.value = RxStatus.loading();
    _apiClient.register(
      requestData: {
        'email': emailController.text,
      },
      onSuccess: (onSuccess) {
        loginStatus.value = RxStatus.success();
        currentScreen.value = 1;
        print('User registered $onSuccess');
      },
      onError: (onError) {
        loginStatus.value = RxStatus.error();
        print('User not registered $onError');
      },
    );
  }

  Future<void> addUsers(ScalingUtility scale) async {
    loginStatus.value = RxStatus.loading();
    _apiClient.addDetails(
      requestData: {
        'name': nameController.text,
        'password': passwordController.text,
        'mobile': phoneController.text,
        'password_confirmation': passwordController.text,
      },
      onSuccess: (onSuccess) async {
        loginStatus.value = RxStatus.success();
        print('User added $onSuccess');
        // Get.offAllNamed(Routes.home);
        await checkUserAdmin(scale);
      },
      onError: (onError) {
        loginStatus.value = RxStatus.error();
        print('User not added $onError');
      },
    );
  }

  Future<void> checkUserFields(ScalingUtility scale) async {
    if (nameController.text.isEmpty) {
      showErrorMessageSnackBar(scale, 'Please enter name');
      return;
    }
    if (phoneController.text.isEmpty) {
      showErrorMessageSnackBar(scale, 'Please enter phone number');
      return;
    }
    if (passwordController.text.isEmpty) {
      showErrorMessageSnackBar(scale, 'Please enter password');
      return;
    }
    if (passwordController.text.length < 6) {
      showErrorMessageSnackBar(scale, 'Password must be at least 6 characters');
      return;
    }
    if (passwordController.text != passwordController.text) {
      showErrorMessageSnackBar(scale, 'Password does not match');
      return;
    }
    await _apiClient.getUserDetails(
      onSuccess: (onSuccess) async {
        print('User fields success $onSuccess');
        userInfoModel = UserInfoModel.fromJson(onSuccess);
        if (userInfoModel?.userInfo?.isEmailVerified == 0) {
          currentScreen.value = 1;
        } else if (userInfoModel?.userInfo?.name == null || userInfoModel?.userInfo?.mobile == null) {
          currentScreen.value = 3;
        } else {
          // Get.offAllNamed(Routes.home);
          await checkUserAdmin(scale);
        }
      },
      onError: (onError) {
        print('User fields error $onError');
      },
    );
  }
}
