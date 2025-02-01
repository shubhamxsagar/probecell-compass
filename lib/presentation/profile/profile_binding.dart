import 'package:get/get.dart';
import 'package:probcell_solutions/presentation/profile/profile_controller.dart';

class ProfileBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<ProfileController>(ProfileController());
  }
}
