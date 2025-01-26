import 'package:get/get.dart';

class HomeController extends GetxController{

  RxInt currentTabIndex = 0.obs;
  void onBottomNavigationBarItemTapped(int tabIdx) {
    currentTabIndex.value = tabIdx;
  }

}