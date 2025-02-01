import 'dart:math';
import 'package:flutter/animation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:probcell_solutions/core/constants/color_constant.dart';

class ChatController extends GetxController with SingleGetTickerProviderMixin {
  late AnimationController animationController;
  late Animation<double> animation;
  late AnimationController _animationController;
  TextEditingController chatTextController = TextEditingController();
  var isSendButtonVisible = false.obs;
  var rotationValue = 0.0.obs;
  RxString chatText = 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod temp'.obs;

  // New AnimationController for CircleAvatar gradient
  late AnimationController circleAvatarGradientController;
  var isGradientActive = true.obs; // To toggle between gradient and primary color

  @override
  void onInit() {
    super.onInit();

    // Existing animation setup
    animationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 5),
    );

    animation = CurvedAnimation(
      parent: animationController,
      curve: Curves.linear,
    );

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 5),
    )..repeat();

    _animationController.addListener(() {
      rotationValue.value = _animationController.value * 2 * pi;
    });

    _startAnimationCycle();

    // New animation setup for CircleAvatar gradient
    circleAvatarGradientController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 2), // Total duration for gradient animation
    )..repeat(); // Repeat the animation indefinitely

    // After 20 seconds, stop the gradient and show primary color
    Future.delayed(Duration(seconds: 20), () {
      isGradientActive.value = false; // Disable gradient
      circleAvatarGradientController.stop(); // Stop the animation
    });
  }

  void onUseText(){
    chatTextController.text = chatText.value;
    onTextChanged(chatText.value);
  }

  @override
  void onClose() {
    animationController.dispose();
    _animationController.dispose();
    circleAvatarGradientController.dispose();
    super.onClose();
  }

  void onTextChanged(String text) {
    isSendButtonVisible.value = text.isNotEmpty;
  }

  void _startAnimationCycle() async {
    while (true) {
      await _spinAnimation();
      await Future.delayed(Duration(seconds: 10));
    }
  }

  Future<void> _spinAnimation() async {
    if (!animationController.isAnimating) {
      animationController.repeat();
      await Future.delayed(Duration(seconds: 20));
      if (animationController.isAnimating) {
        animationController.stop();
        animationController.reset();
      }
    }
  }

  void onStarClicked() {
    _spinAnimation();
  }
  Color getShadowColor() {
    final double value = rotationValue.value / (2 * pi); // Normalize to 0-1
    return Color.lerp(Colors.blue, ColorConstants.primaryColor, value)!;
  }
}