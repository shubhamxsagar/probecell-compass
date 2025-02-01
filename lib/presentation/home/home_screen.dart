import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:probcell_solutions/core/constants/color_constant.dart';
import 'package:probcell_solutions/core/constants/image_constant.dart';
import 'package:probcell_solutions/core/theme/app_decoration.dart';
import 'package:probcell_solutions/core/theme/app_style.dart';
import 'package:probcell_solutions/core/utils/scaling_utils.dart';
import 'package:probcell_solutions/presentation/chats/chat_screen.dart';
import 'package:probcell_solutions/presentation/home/home_controller.dart';
import 'package:probcell_solutions/presentation/profile/profile_screen.dart';
import 'package:probcell_solutions/presentation/service/service_screen.dart';
import 'package:probcell_solutions/presentation/widgets/custom_text_button.dart';

class HomeScreen extends GetView<HomeController> {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ScalingUtility scale = ScalingUtility(context: context)..setCurrentDeviceSize();
    return Scaffold(
      backgroundColor: ColorConstants.white,
      bottomNavigationBar: buildBottomNavigationBar(scale),
      body: Obx(() {
        switch (controller.currentTabIndex.value) {
          case 0:
            return buildHome(scale);
          case 1:
            return buildChat();
          case 2:
            return ServiceScreen();
          case 3:
            return buildProfile();
          case 4:
            return buildCategories(scale);
          case 5:
            return buildSubCategories(scale);
          default:
            return buildHome(scale);
        }
      }),
    );
  }

  Widget buildHome(ScalingUtility scale) {
    return SafeArea(
      child: Padding(
        padding: scale.getPadding(horizontal: 20, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppBar(
              title: FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(
                  'PROBECELL COMPASS',
                  style: AppStyle.textStylepoppins600blackLight20,
                ),
              ),
              leadingWidth: scale.getScaledWidth(60),
              leading: Image.asset(ImageConstant.logo),
              backgroundColor: ColorConstants.white,
            ),
            SizedBox(height: scale.getScaledHeight(60)),
            buildBlogCarouselSlider(scale),
            buildBlogDotsIndicator(scale),
            SizedBox(height: scale.getScaledHeight(20)),
            Text(
              '🚀 Unlock Your Next Research Idea! 📚💡',
              style: AppStyle.textStylepoppins600black14,
              textAlign: TextAlign.left,
            ),
            SizedBox(height: scale.getScaledHeight(10)),
            Text(
              'This app helps students, researchers, and professionals discover unique and relevant research topics 🎯 tailored to their field of study. Simply enter your domain, keywords, and preferences ✍️, and get AI-powered suggestions 🤖 with brief descriptions. Explore trending topics 🔥, identify research gaps 🧐, and refine your ideas to kickstart your next project with confidence! 🚀✨',
              style: AppStyle.textStylepoppins400blackLight16.copyWith(fontSize: 14),
              textAlign: TextAlign.left,
            ),
            SizedBox(height: scale.getScaledHeight(20)),
            ElevatedButton(
              onPressed: () {
                controller.currentTabIndex.value = 4;
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: ColorConstants.primaryBgColor,
                elevation: 5,
                padding: scale.getPadding(vertical: 12, horizontal: 24),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24),
                ),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Start your search',
                    style: AppStyle.textStylepoppins600white14,
                  ),
                  SizedBox(width: scale.getScaledWidth(10)),
                  SvgPicture.asset(
                    SvgConstant.btnArrow,
                    color: Colors.white,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildCategories(ScalingUtility scale) {
    final HomeController controller = Get.find();

    return SafeArea(
      child: Padding(
        padding: scale.getPadding(horizontal: 20, vertical: 10),
        child: Column(
          children: [
            AppBar(
              title: FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(
                  'PROBECELL COMPASS',
                  style: AppStyle.textStylepoppins600blackLight20,
                ),
              ),
              leadingWidth: scale.getScaledWidth(60),
              leading: Image.asset(ImageConstant.logo),
              backgroundColor: ColorConstants.white,
            ),
            SizedBox(height: scale.getScaledHeight(20)),
            Expanded(
              child: SizedBox(
                width: scale.fullWidth,
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: scale.getScaledHeight(20)),
                      Text(
                        'Categories',
                        style: AppStyle.textStylepoppins600black16.copyWith(fontSize: 22),
                        textAlign: TextAlign.left,
                      ),
                      SizedBox(height: scale.getScaledHeight(10)),
                      Obx(() {
                        // Use a single AnimatedOpacity for the entire list
                        return AnimatedOpacity(
                          opacity: controller.isListVisible.value ? 1.0 : 1.0, // Fade in/out
                          duration: Duration(milliseconds: 500), // Animation duration
                          curve: Curves.easeInOut,
                          child: Wrap(
                            spacing: scale.getScaledWidth(10),
                            runSpacing: scale.getScaledHeight(10),
                            children: controller.categories.map((category) {
                              return InkWell(
                                splashColor: Colors.transparent,
                                highlightColor: Colors.transparent,
                                onTap: () {
                                  final index = controller.categories.indexOf(category);
                                  controller.toggleSelectionCategories(index);
                                },
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: scale.getScaledWidth(12),
                                    vertical: scale.getScaledHeight(8),
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(scale.getScaledWidth(20)),
                                    border: Border.all(
                                      color: category.isSelected ? ColorConstants.primaryColor : Colors.grey,
                                      width: 2,
                                    ),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black12,
                                        blurRadius: 5,
                                        offset: Offset(0, 2),
                                      ),
                                    ],
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text(
                                        category.name,
                                        style: TextStyle(
                                          fontSize: scale.getScaledWidth(14),
                                          color: Colors.black,
                                        ),
                                      ),
                                      if (category.isSelected)
                                        Padding(
                                          padding: EdgeInsets.only(left: scale.getScaledWidth(5)),
                                          child: Icon(
                                            Icons.check_circle,
                                            color: ColorConstants.primaryColor,
                                            size: scale.getScaledWidth(16),
                                          ),
                                        ),
                                    ],
                                  ),
                                ),
                              );
                            }).toList(),
                          ),
                        );
                      }),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: scale.getScaledHeight(10)),
            CustomTextButton(
              buttonText: 'Next',
              onTap: () {
                controller.currentTabIndex.value = 5;
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget buildSubCategories(ScalingUtility scale) {
    return SafeArea(
      child: Padding(
        padding: scale.getPadding(horizontal: 20, vertical: 10),
        child: Column(
          children: [
            AppBar(
              title: FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(
                  'PROBECELL COMPASS',
                  style: AppStyle.textStylepoppins600blackLight20,
                ),
              ),
              leadingWidth: scale.getScaledWidth(60),
              leading: Image.asset(ImageConstant.logo),
              backgroundColor: ColorConstants.white,
            ),
            SizedBox(height: scale.getScaledHeight(20)),
            Expanded(
              child: SizedBox(
                width: scale.fullWidth,
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: scale.getScaledHeight(20)),
                      Text(
                        'Sub Categories',
                        style: AppStyle.textStylepoppins600black16.copyWith(fontSize: 22),
                        textAlign: TextAlign.left,
                      ),
                      SizedBox(height: scale.getScaledHeight(10)),
                      Obx(() {
                        // Use a single AnimatedOpacity for the entire list
                        return AnimatedOpacity(
                          opacity: controller.isListVisible.value ? 1.0 : 1.0, // Fade in/out
                          duration: Duration(milliseconds: 500), // Animation duration
                          curve: Curves.easeInOut,
                          child: Wrap(
                            spacing: scale.getScaledWidth(10),
                            runSpacing: scale.getScaledHeight(10),
                            children: controller.subCategories.map((category) {
                              return InkWell(
                                splashColor: Colors.transparent,
                                highlightColor: Colors.transparent,
                                onTap: () {
                                  final index = controller.subCategories.indexOf(category);
                                  controller.toggleSelectionSubCategories(index);
                                },
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: scale.getScaledWidth(12),
                                    vertical: scale.getScaledHeight(8),
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(scale.getScaledWidth(20)),
                                    border: Border.all(
                                      color: category.isSelected ? ColorConstants.primaryColor : Colors.grey,
                                      width: 2,
                                    ),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black12,
                                        blurRadius: 5,
                                        offset: Offset(0, 2),
                                      ),
                                    ],
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text(
                                        category.name,
                                        style: TextStyle(
                                          fontSize: scale.getScaledWidth(14),
                                          color: Colors.black,
                                        ),
                                      ),
                                      if (category.isSelected)
                                        Padding(
                                          padding: EdgeInsets.only(left: scale.getScaledWidth(5)),
                                          child: Icon(
                                            Icons.check_circle,
                                            color: ColorConstants.primaryColor,
                                            size: scale.getScaledWidth(16),
                                          ),
                                        ),
                                    ],
                                  ),
                                ),
                              );
                            }).toList(),
                          ),
                        );
                      }),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: scale.getScaledHeight(10)),
            CustomTextButton(
              buttonText: 'Submit',
              onTap: () {
                controller.currentTabIndex.value = 1;
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget buildBlogCarouselSlider(ScalingUtility scale) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        CarouselSlider.builder(
          options: CarouselOptions(
            height: scale.getScaledHeight(181),
            autoPlay: true,
            enlargeCenterPage: true,
            viewportFraction: 1.0,
            aspectRatio: 16 / 9,
            initialPage: 0,
            onPageChanged: (index, reason) {
              controller.currentServiceSlide.value = index;
            },
          ),
          itemCount: controller.carouselServiceItems.length,
          itemBuilder: (BuildContext context, int index, int realIndex) {
            return Container(
              padding: scale.getPadding(horizontal: 20, vertical: 20),
              width: scale.fullWidth,
              height: scale.getScaledHeight(181),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  colors: [
                    Colors.black.withOpacity(0.7),
                    Colors.transparent,
                  ],
                ),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    controller.carouselServiceItems[index]['title']!,
                    style: AppStyle.textStylepoppins600grey12.copyWith(
                      color: Colors.white,
                      decoration: TextDecoration.underline,
                      decorationColor: Colors.white,
                    ),
                    textAlign: TextAlign.left,
                  ),
                  Text(
                    controller.carouselServiceItems[index]['description']!,
                    style: AppStyle.textStylepoppins500whiteLight12,
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            );
          },
        ),
      ],
    );
  }

  Widget buildBlogDotsIndicator(ScalingUtility scale) {
    return Obx(
      () => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(3, (index) {
          return Container(
            width: 6.0,
            height: 6.0,
            margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: controller.currentServiceSlide.value == index
                  ? ColorConstants.primaryBgColor
                  : ColorConstants.greyLight,
            ),
          );
        }),
      ),
    );
  }

  Widget buildChat() {
    return ChatScreen();
  }

  Widget buildSettings() {
    return Container(
      child: Center(
        child: Text("Settings"),
      ),
    );
  }

  Widget buildProfile() {
    return ProfileScreen();
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
                buildBottomNavigationBarItem(scale, CupertinoIcons.chat_bubble, 1),
                buildBottomNavigationBarItem(scale, CupertinoIcons.settings, 2),
                buildBottomNavigationBarItem(scale, CupertinoIcons.person, 3),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget buildBottomNavigationBarItem(ScalingUtility scale, IconData icon, int tabIdx) {
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
                  child: Icon(
                    icon,
                    color: (controller.currentTabIndex.value == tabIdx)
                        ? ColorConstants.primaryColor
                        : ColorConstants.grey2Light,
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
