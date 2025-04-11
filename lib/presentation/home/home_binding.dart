import 'package:get/get.dart';
import 'package:probcell_solutions/presentation/chats/chat_controller.dart';
import 'package:probcell_solutions/presentation/home/home_controller.dart';
import 'package:probcell_solutions/presentation/profile/profile_controller.dart';
import 'package:probcell_solutions/presentation/service/service_controller.dart';

class HomeBinding extends Bindings{
  @override
  void dependencies() {
    Get.put<HomeController>(HomeController());
    Get.put<ServiceController>(ServiceController());
    Get.put<ProfileController>(ProfileController());

  }
}