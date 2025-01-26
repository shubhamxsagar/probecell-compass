import 'package:get/get.dart';
import 'package:probcell_solutions/presentation/home/home_controller.dart';

class HomeBinding extends Bindings{
  @override
  void dependencies() {
    Get.put<HomeController>(HomeController());
  }
}