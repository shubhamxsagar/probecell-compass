import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginController extends GetxController{
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController otpController = TextEditingController();

  RxBool obscureText = true.obs;
  RxInt currentScreen = 0.obs;

  void toggleObscureText(){
    obscureText.value = !obscureText.value;
  }

  void changeScreen(int index){
    currentScreen.value = index;
  }
}