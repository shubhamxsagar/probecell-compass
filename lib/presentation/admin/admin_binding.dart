import 'package:get/get.dart';
import 'package:probcell_solutions/presentation/admin/admin_controller.dart';

class AdminBinding extends Bindings{
  @override
  void dependencies() {
   Get.put<AdminController>(AdminController());
  }
}