import 'package:get/get.dart';
import 'package:probcell_solutions/presentation/chats/chat_controller.dart';

class ChatBinding extends Bindings {
  @override
  void dependencies() {
     Get.lazyPut<ChatController>(() => ChatController());
  }
}
