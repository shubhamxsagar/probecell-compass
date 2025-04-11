import 'dart:math';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:probcell_solutions/presentation/chats/chat_controller.dart';
import 'package:shimmer/shimmer.dart';
import 'package:probcell_solutions/core/constants/color_constant.dart';
import 'package:probcell_solutions/core/constants/image_constant.dart';
import 'package:probcell_solutions/core/theme/app_style.dart';
import 'package:probcell_solutions/core/utils/helper_utils.dart';
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
            {
              controller.getSearchHistory();
              return buildHome(scale);
            }
          case 1:
            return buildChat();
          case 2:
            return ServiceScreen();
          case 3:
            return buildProfile();
          case 4:
            return buildAreas(scale);
          case 5:
            return buildCourses(scale);
          case 6:
            return buildTypesOfWork(scale);
          case 7:
            return buildCategories(scale);
          case 8:
            return buildSubCategories(scale);
          default:
            return buildHome(scale);
        }
      }),
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
                        if (controller.categoryStatus.value.isLoading) {
                          return Center(
                            child: CircularProgressIndicator(
                              color: ColorConstants.primaryColor,
                            ),
                          );
                        }
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
                controller.changeScreen(8);
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
                        if (controller.subCategoryStatus.value.isLoading) {
                          return Center(
                            child: CircularProgressIndicator(
                              color: ColorConstants.primaryColor,
                            ),
                          );
                        }
                        return AnimatedOpacity(
                          opacity: controller.isListVisible.value ? 1.0 : 1.0,
                          duration: Duration(milliseconds: 500),
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
                controller.changeScreen(9);
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget buildTypesOfWork(ScalingUtility scale) {
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
                        'Types of Work',
                        style: AppStyle.textStylepoppins600black16.copyWith(fontSize: 22),
                        textAlign: TextAlign.left,
                      ),
                      SizedBox(height: scale.getScaledHeight(10)),
                      Obx(() {
                        if (controller.typesWorkStatus.value.isLoading) {
                          return Center(
                            child: CircularProgressIndicator(
                              color: ColorConstants.primaryColor,
                            ),
                          );
                        }
                        return AnimatedOpacity(
                          opacity: controller.isListVisible.value ? 1.0 : 1.0,
                          duration: Duration(milliseconds: 500),
                          curve: Curves.easeInOut,
                          child: Wrap(
                            spacing: scale.getScaledWidth(10),
                            runSpacing: scale.getScaledHeight(10),
                            children: controller.typesWork.map((category) {
                              return InkWell(
                                splashColor: Colors.transparent,
                                highlightColor: Colors.transparent,
                                onTap: () {
                                  final index = controller.typesWork.indexOf(category);
                                  controller.toggleSelectionTypesWork(index);
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
                controller.changeScreen(7);
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget buildAreas(ScalingUtility scale) {
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
                        'Areas',
                        style: AppStyle.textStylepoppins600black16.copyWith(fontSize: 22),
                        textAlign: TextAlign.left,
                      ),
                      SizedBox(height: scale.getScaledHeight(10)),
                      Obx(() {
                        if (controller.areasStatus.value.isLoading) {
                          return Center(
                            child: CircularProgressIndicator(
                              color: ColorConstants.primaryColor,
                            ),
                          );
                        }
                        return AnimatedOpacity(
                          opacity: controller.isListVisible.value ? 1.0 : 1.0,
                          duration: Duration(milliseconds: 500),
                          curve: Curves.easeInOut,
                          child: Wrap(
                            spacing: scale.getScaledWidth(10),
                            runSpacing: scale.getScaledHeight(10),
                            children: controller.areas.map((category) {
                              return InkWell(
                                splashColor: Colors.transparent,
                                highlightColor: Colors.transparent,
                                onTap: () {
                                  final index = controller.areas.indexOf(category);
                                  controller.toggleSelectionAreas(index);
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
                controller.changeScreen(5);
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget buildCourses(ScalingUtility scale) {
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
                        'Courses',
                        style: AppStyle.textStylepoppins600black16.copyWith(fontSize: 22),
                        textAlign: TextAlign.left,
                      ),
                      SizedBox(height: scale.getScaledHeight(10)),
                      Obx(() {
                        if (controller.coursesStatus.value.isLoading) {
                          return Center(
                            child: CircularProgressIndicator(
                              color: ColorConstants.primaryColor,
                            ),
                          );
                        }
                        return AnimatedOpacity(
                          opacity: controller.isListVisible.value ? 1.0 : 1.0,
                          duration: Duration(milliseconds: 500),
                          curve: Curves.easeInOut,
                          child: Wrap(
                            spacing: scale.getScaledWidth(10),
                            runSpacing: scale.getScaledHeight(10),
                            children: controller.courses.map((category) {
                              return InkWell(
                                splashColor: Colors.transparent,
                                highlightColor: Colors.transparent,
                                onTap: () {
                                  final index = controller.courses.indexOf(category);
                                  controller.toggleSelectionCourses(index);
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
                controller.changeScreen(6);
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget buildHome(ScalingUtility scale) {
    return LiquidPullToRefresh(
      onRefresh: () async {
        await controller.getSearchHistory();
      },
      color: ColorConstants.primaryColor,
      height: 150,
      backgroundColor: ColorConstants.white,
      animSpeedFactor: 2,
      showChildOpacityTransition: false,
      child: Stack(
        children: [
          CustomScrollView(
            slivers: [
              SliverAppBar(
                expandedHeight: scale.getScaledHeight(200),
                flexibleSpace: FlexibleSpaceBar(
                  background: Stack(
                    children: [
                      buildAnimatedBackground(scale),
                      Positioned.fill(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Hero(
                              tag: 'logo',
                              child: Image.asset(
                                ImageConstant.logo,
                                width: scale.getScaledWidth(80),
                                height: scale.getScaledHeight(80),
                              ),
                            ),
                            SizedBox(height: scale.getScaledHeight(10)),
                            AnimatedDefaultTextStyle(
                              duration: Duration(milliseconds: 500),
                              style: AppStyle.textStylepoppins600blackLight20.copyWith(
                                color: Colors.white,
                                shadows: [
                                  Shadow(
                                    blurRadius: 10,
                                    color: Colors.black.withOpacity(0.5),
                                    offset: Offset(2, 2),
                                  ),
                                ],
                              ),
                              child: Text('PROBECELL COMPASS'),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                pinned: true,
                elevation: 10,
                backgroundColor: ColorConstants.primaryColor,
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: scale.getPadding(horizontal: 20, vertical: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: scale.getScaledHeight(20)),
                      buildBlogCarouselSlider(scale),
                      buildBlogDotsIndicator(scale),
                      SizedBox(height: scale.getScaledHeight(20)),
                      Obx(
                        () {
                          if (controller.searchHistoryStatus.value.isLoading) {
                            return buildShimmerLoading(scale);
                          }
                          if (controller.searchHistoryModel?.searchHistory?.isEmpty ?? true) {
                            return buildWelcomeSection(scale);
                          } else {
                            return buildSearchHistory(scale);
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          Obx(
            () {
              if (controller.searchHistoryStatus.value.isLoading) {
                return Container();
              }
              if (controller.searchHistoryModel?.searchHistory?.isEmpty ?? true) {
                return Container();
              } else {
                return Positioned(
                  left: scale.getScaledWidth(80),
                  right: scale.getScaledWidth(80),
                  bottom: scale.getScaledHeight(20),
                  child: ElevatedButton(
                    onPressed: () {
                      controller.changeScreen(4);
                      HapticFeedback.lightImpact();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: ColorConstants.primaryColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'Search Again',
                          style: AppStyle.textStylepoppins600white14,
                        ),
                        SizedBox(width: scale.getScaledWidth(8)),
                        Icon(Icons.search, size: 16, color: Colors.white),
                      ],
                    ),
                  ),
                );
              }
            },
          ),
        ],
      ),
    );
  }

  Widget buildAnimatedBackground(ScalingUtility scale) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            ColorConstants.primaryColor.withOpacity(0.8),
            ColorConstants.secondaryColor.withOpacity(0.8),
          ],
        ),
      ),
      child: Stack(
        children: [
          // Animated particles
          Positioned.fill(
            child: AnimatedContainer(
              duration: Duration(seconds: 30),
              curve: Curves.linear,
              child: CustomPaint(
                painter: ParticlePainter(),
              ),
            ),
          ),
          // Glow effect
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                gradient: RadialGradient(
                  center: Alignment(0, -0.5),
                  radius: 0.8,
                  colors: [
                    ColorConstants.primaryColor.withOpacity(0.2),
                    Colors.transparent,
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildShimmerLoading(ScalingUtility scale) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            height: scale.getScaledHeight(20),
            color: Colors.white,
          ),
          SizedBox(height: scale.getScaledHeight(10)),
          Container(
            width: double.infinity,
            height: scale.getScaledHeight(100),
            color: Colors.white,
          ),
          SizedBox(height: scale.getScaledHeight(20)),
          Container(
            width: scale.getScaledWidth(200),
            height: scale.getScaledHeight(20),
            color: Colors.white,
          ),
          SizedBox(height: scale.getScaledHeight(10)),
          Container(
            width: double.infinity,
            height: scale.getScaledHeight(60),
            color: Colors.white,
          ),
        ],
      ),
    );
  }

  Widget buildWelcomeSection(ScalingUtility scale) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SlideTransition(
          position: Tween<Offset>(
            begin: Offset(-1, 0),
            end: Offset.zero,
          ).animate(CurvedAnimation(
            parent: controller.animationController,
            curve: Interval(0.0, 0.5, curve: Curves.easeOutCubic),
          )),
          child: FadeTransition(
            opacity: Tween<double>(begin: 0, end: 1).animate(
              CurvedAnimation(
                parent: controller.animationController,
                curve: Interval(0.0, 0.5, curve: Curves.easeIn),
              ),
            ),
            child: Text(
              '🚀 Unlock Your Next Research Idea! 📚💡',
              style: AppStyle.textStylepoppins600black14,
              textAlign: TextAlign.left,
            ),
          ),
        ),
        SizedBox(height: scale.getScaledHeight(10)),
        SlideTransition(
          position: Tween<Offset>(
            begin: Offset(1, 0),
            end: Offset.zero,
          ).animate(CurvedAnimation(
            parent: controller.animationController,
            curve: Interval(0.3, 0.8, curve: Curves.easeOutCubic),
          )),
          child: FadeTransition(
            opacity: Tween<double>(begin: 0, end: 1).animate(
              CurvedAnimation(
                parent: controller.animationController,
                curve: Interval(0.3, 0.8, curve: Curves.easeIn),
              ),
            ),
            child: Text(
              'This app helps students, researchers, and professionals discover unique and relevant research topics 🎯 tailored to their field of study. Simply enter your domain, keywords, and preferences ✍️, and get AI-powered suggestions 🤖 with brief descriptions. Explore trending topics 🔥, identify research gaps 🕵️‍♂️, and refine your ideas to kickstart your next project with confidence! 🚀✨',
              style: AppStyle.textStylepoppins400blackLight16.copyWith(fontSize: 14),
              textAlign: TextAlign.left,
            ),
          ),
        ),
        SizedBox(height: scale.getScaledHeight(20)),
        ScaleTransition(
          scale: Tween<double>(begin: 0.9, end: 1.0).animate(
            CurvedAnimation(
              parent: controller.animationController,
              curve: Interval(0.6, 1.0, curve: Curves.elasticOut),
            ),
          ),
          child: FadeTransition(
            opacity: Tween<double>(begin: 0, end: 1).animate(
              CurvedAnimation(
                parent: controller.animationController,
                curve: Interval(0.6, 1.0, curve: Curves.easeIn),
              ),
            ),
            child: ElevatedButton(
              onPressed: () {
                controller.changeScreen(4);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: ColorConstants.primaryColor,
                elevation: 5,
                padding: scale.getPadding(vertical: 12, horizontal: 24),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24),
                ),
                shadowColor: ColorConstants.primaryColor.withOpacity(0.5),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Start your search',
                    style: AppStyle.textStylepoppins600white14,
                  ),
                  SizedBox(width: scale.getScaledWidth(10)),
                  Icon(
                    Icons.arrow_forward,
                    color: Colors.white,
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget buildSearchHistory(ScalingUtility scale) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Title Section
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Search History',
              style: AppStyle.textStylepoppins600black16.copyWith(fontSize: 22),
            ),
            FloatingActionButton(
              onPressed: () {
                controller.changeScreen(4);
                HapticFeedback.lightImpact();
              },
              backgroundColor: ColorConstants.primaryColor,
              elevation: 4,
              mini: true,
              child: Icon(Icons.search, color: Colors.white),
            ),
          ],
        ),
        // SizedBox(height: scale.getScaledHeight(10)),

        // Search History List
        ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: controller.searchHistoryModel?.searchHistory?.length ?? 0,
          itemBuilder: (context, index) {
            final searchHistory = controller.searchHistoryModel!.searchHistory![index];
            return Padding(
              padding: scale.getPadding(vertical: 8),
              child: Container(
                decoration: BoxDecoration(
                  color: ColorConstants.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 5,
                      offset: Offset(0, 8),
                    ),
                  ],
                ),
                child: ExpansionTile(
                  title: Text(
                    'Search on ${convertDateTimeToyyyyMMdd(DateTime.parse(searchHistory.createdAt!))}',
                    style: AppStyle.textStylepoppins600black14,
                  ),
                  subtitle: Text(
                    'Tap to view details',
                    style: AppStyle.textStylepoppins400blackLight16,
                  ),
                  children: [
                    Padding(
                      padding: scale.getPadding(horizontal: 16, vertical: 8),
                      child: Text(
                        searchHistory.aiResponse ?? 'No details available.',
                        style: AppStyle.textStylepoppins400navyBlueDark14,
                      ),
                    ),
                    // ElevatedButton(
                    //   onPressed: () {
                    //     controller.changeScreen(4);
                    //     HapticFeedback.lightImpact();
                    //   },
                    //   style: ElevatedButton.styleFrom(
                    //     backgroundColor: ColorConstants.primaryColor,
                    //     shape: RoundedRectangleBorder(
                    //       borderRadius: BorderRadius.circular(20),
                    //     ),
                    //   ),
                    //   child: Row(
                    //     mainAxisSize: MainAxisSize.min,
                    //     children: [
                    //       Text(
                    //         'Search Again',
                    //         style: AppStyle.textStylepoppins600white14,
                    //       ),
                    //       SizedBox(width: scale.getScaledWidth(8)),
                    //       Icon(Icons.search, size: 16, color: Colors.white),
                    //     ],
                    //   ),
                    // ),
                  ],
                ),
              ),
            );
          },
        ),

        // New Search Button
        SizedBox(height: scale.getScaledHeight(60)),
        // Center(
        //   child: ElevatedButton(
        //     onPressed: () {
        //       controller.changeScreen(4);
        //       HapticFeedback.mediumImpact();
        //     },
        //     style: ElevatedButton.styleFrom(
        //       backgroundColor: ColorConstants.primaryColor,
        //       shape: RoundedRectangleBorder(
        //         borderRadius: BorderRadius.circular(24),
        //       ),
        //     ),
        //     child: Row(
        //       mainAxisSize: MainAxisSize.min,
        //       children: [
        //         Text(
        //           'New Search',
        //           style: AppStyle.textStylepoppins600white14,
        //         ),
        //         SizedBox(width: scale.getScaledWidth(10)),
        //         Icon(Icons.search_rounded, color: Colors.white),
        //       ],
        //     ),
        //   ),
        // ),
      ],
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
            return AnimatedContainer(
              duration: Duration(milliseconds: 500),
              curve: Curves.easeInOut,
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
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.3),
                    blurRadius: 10,
                    spreadRadius: 2,
                    offset: Offset(0, 5),
                  ),
                ],
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
                      shadows: [
                        Shadow(
                          blurRadius: 5,
                          color: Colors.black.withOpacity(0.5),
                          offset: Offset(1, 1),
                        ),
                      ],
                    ),
                    textAlign: TextAlign.left,
                  ),
                  SizedBox(height: scale.getScaledHeight(10)),
                  Text(
                    controller.carouselServiceItems[index]['description']!,
                    style: AppStyle.textStylepoppins500whiteLight12.copyWith(
                      fontSize: 14,
                      shadows: [
                        Shadow(
                          blurRadius: 5,
                          color: Colors.black.withOpacity(0.5),
                          offset: Offset(1, 1),
                        ),
                      ],
                    ),
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

  Widget buildBottomNavigationBar(ScalingUtility scale) {
    return SafeArea(
      child: Container(
        decoration: BoxDecoration(
          color: ColorConstants.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 10,
              spreadRadius: 2,
              offset: Offset(0, -5),
            ),
          ],
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
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
      ),
    );
  }

  Widget buildBottomNavigationBarItem(ScalingUtility scale, IconData icon, int tabIdx) {
    return InkWell(
      onTap: () {
        controller.onBottomNavigationBarItemTapped(tabIdx);
      },
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      child: Obx(
        () => AnimatedContainer(
          duration: Duration(milliseconds: 300),
          curve: Curves.easeInOut,
          width: scale.fullWidth / 4,
          height: scale.getScaledHeight(55),
          decoration: BoxDecoration(
            border: Border(
              top: BorderSide(
                color: (controller.currentTabIndex.value == tabIdx)
                    ? ColorConstants.primaryColor
                    : Colors.transparent,
                width: 3,
              ),
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              AnimatedSwitcher(
                duration: Duration(milliseconds: 300),
                transitionBuilder: (Widget child, Animation<double> animation) {
                  return ScaleTransition(scale: animation, child: child);
                },
                child: Icon(
                  icon,
                  key: ValueKey<int>(tabIdx),
                  color: (controller.currentTabIndex.value == tabIdx)
                      ? ColorConstants.primaryColor
                      : ColorConstants.grey2Light,
                  size: (controller.currentTabIndex.value == tabIdx) ? 24 : 22,
                ),
              ),
              SizedBox(height: scale.getScaledHeight(4)),
              AnimatedContainer(
                duration: Duration(milliseconds: 200),
                width: (controller.currentTabIndex.value == tabIdx) ? scale.getScaledWidth(6) : 0,
                height: scale.getScaledHeight(3),
                decoration: BoxDecoration(
                  color: ColorConstants.primaryColor,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ],
          ),
        ),
      ),
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
    Get.lazyPut<ChatController>(() => ChatController());
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
}

class ParticlePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white.withOpacity(0.2)
      ..style = PaintingStyle.fill;

    final random = Random(DateTime.now().millisecondsSinceEpoch);

    for (int i = 0; i < 30; i++) {
      final x = random.nextDouble() * size.width;
      final y = random.nextDouble() * size.height;
      final radius = random.nextDouble() * 2 + 1;

      canvas.drawCircle(Offset(x, y), radius, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
