import 'package:get/get.dart';
import 'package:probcell_solutions/presentation/service/service_controller.dart';

class ServiceBinding extends Bindings{
  @override
  void dependencies() {
    Get.put<ServiceController>(ServiceController());
  }
}