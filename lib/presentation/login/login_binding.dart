import 'package:get/get.dart';
import 'package:probcell_solutions/presentation/login/login_controller.dart';

class LoginBinding extends Bindings{
  @override
  void dependencies() {
    Get.put<LoginController>(LoginController());
  }
}