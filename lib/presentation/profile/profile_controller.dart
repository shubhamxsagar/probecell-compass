import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:probcell_solutions/core/services/api_client.dart';
import 'package:probcell_solutions/presentation/profile/user_info_model.dart';

class ProfileController extends GetxController {
  late ApiClient _apiClient;
  UserInfoModel? userInfoModel;
  TextEditingController nameController = TextEditingController();
  TextEditingController mobileController = TextEditingController();
  Rx<RxStatus> status = RxStatus.empty().obs;

  @override
  void onInit() {
    _apiClient = Get.find<ApiClient>();
    getUserDetails();
    super.onInit();
  }

  Future<void> getUserDetails() async {
    status.value = RxStatus.loading();
    _apiClient.getUserDetails(
      onSuccess: (onSuccess) {
        status.value = RxStatus.success();
        userInfoModel = UserInfoModel.fromJson(onSuccess);
        nameController.text = userInfoModel?.userInfo?.name ?? '';
        mobileController.text = userInfoModel?.userInfo?.mobile ?? '';
        print(onSuccess);
      },
      onError: (onError) {
        status.value = RxStatus.error();
      },
    );
  }

  Future<void> changeUserInfo() async {
    _apiClient.changeUserDetails(
      requestData: {
        'name': nameController.text,
        'mobile': mobileController.text,
      },
      onSuccess: (onSuccess) {
        getUserDetails();
        print('User info changed successfully $onSuccess');
      },
      onError: (onError) {
        print('Failed to change user info $onError');
      },
    );
  }
}
