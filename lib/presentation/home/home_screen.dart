import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:probcell_solutions/core/constants/color_constant.dart';
import 'package:probcell_solutions/core/theme/app_style.dart';
import 'package:probcell_solutions/core/utils/scaling_utils.dart';
import 'package:probcell_solutions/presentation/home/home_controller.dart';

class HomeScreen extends GetView<HomeController> {
const HomeScreen({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context){
     ScalingUtility scale = ScalingUtility(context: context)
      ..setCurrentDeviceSize();
    return Scaffold(
      backgroundColor: ColorConstants.white,
      bottomNavigationBar: buildBottomNavigationBar(scale),
    );
  }



  Widget buildBottomNavigationBar(ScalingUtility scale) {
    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            decoration: BoxDecoration(
              color: ColorConstants.white,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                buildBottomNavigationBarItem(scale, CupertinoIcons.home, 0),
                buildBottomNavigationBarItem(
                    scale, CupertinoIcons.chat_bubble, 1),
                buildBottomNavigationBarItem(
                  scale, CupertinoIcons.settings, 2),
                buildBottomNavigationBarItem(
                    scale, CupertinoIcons.person, 3),
              ],
            ),
          )
        ],
      ),
    );
  }

   Widget buildBottomNavigationBarItem(
      ScalingUtility scale, IconData icon,int tabIdx) {
    return InkWell(
      onTap: () {
        controller.onBottomNavigationBarItemTapped(tabIdx);
      },
      child: Obx(
        () => Container(
          width: scale.fullWidth / 4,
          height: scale.getScaledHeight(55),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                constraints: BoxConstraints(
                  maxHeight: scale.getScaledWidth(22),
                  maxWidth: scale.getScaledWidth(22),
                ),
                child: Icon(icon, color: (controller.currentTabIndex.value == tabIdx)
                      ? ColorConstants.primaryColor
                      : ColorConstants.grey2Light,)
              ),
            ],
          ),
        ),
      ),
    );
  }
}