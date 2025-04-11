import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:probcell_solutions/core/constants/color_constant.dart';
import 'package:probcell_solutions/core/constants/image_constant.dart';
import 'package:probcell_solutions/core/theme/app_style.dart';
import 'package:probcell_solutions/core/utils/scaling_utils.dart';
import 'package:probcell_solutions/presentation/login/login_controller.dart';
import 'package:probcell_solutions/presentation/widgets/custom_pinput_field.dart';
import 'package:probcell_solutions/presentation/widgets/custom_text_button.dart';
import 'package:probcell_solutions/presentation/widgets/custom_text_field.dart';
import 'package:probcell_solutions/routes/app_routes.dart';

class LoginScreen extends GetView<LoginController> {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ScalingUtility scale = ScalingUtility(context: context)..setCurrentDeviceSize();

    return WillPopScope(
      onWillPop: () {
        if (controller.currentScreen.value == 0) {
          return Future.value(true);
        } else {
          controller.changeScreen(0);
          return Future.value(false);
        }
      },
      child: AnnotatedRegion<SystemUiOverlayStyle>(
        value: const SystemUiOverlayStyle(
          statusBarColor: ColorConstants.primaryBgColor,
          statusBarIconBrightness: Brightness.light,
        ),
        child: Scaffold(
          backgroundColor: ColorConstants.white,
          body: SafeArea(
            child: SingleChildScrollView(
              child: SizedBox(
                height: MediaQuery.of(context).size.height - MediaQuery.of(context).viewPadding.top,
                child: Column(
                  children: [
                    Expanded(
                      child: Stack(
                        fit: StackFit.passthrough,
                        children: [
                          buildOnboardingContainer(scale),
                          buildLoginCard(scale),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildOnboardingContainer(ScalingUtility scale) {
    return Positioned(
      top: 0,
      left: 0,
      right: 0,
      child: Container(
        height: scale.getScaledHeight(340),
        decoration: const BoxDecoration(
          color: ColorConstants.primaryColor,
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(10),
            bottomRight: Radius.circular(10),
          ),
        ),
        width: scale.fullWidth,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: scale.getScaledHeight(60)),
            SizedBox(
              height: scale.getScaledHeight(150),
              width: scale.getScaledWidth(150),
              child: Image.asset(ImageConstant.logo),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildLoginCard(ScalingUtility scale) {
    return Positioned(
      top: scale.getScaledHeight(250),
      left: scale.getScaledWidth(20),
      right: scale.getScaledWidth(20),
      child: Container(
        constraints: BoxConstraints(minHeight: scale.getScaledHeight(300)),
        padding: scale.getPadding(horizontal: 20, vertical: 20),
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: ColorConstants.grey.withOpacity(0.1),
              blurRadius: 20,
              offset: Offset(0, 10),
            ),
            BoxShadow(
              color: ColorConstants.grey.withOpacity(0.1),
              blurRadius: 20,
              offset: Offset(-10, 0),
            ),
            BoxShadow(
              color: ColorConstants.grey.withOpacity(0.1),
              blurRadius: 20,
              offset: Offset(10, 0),
            ),
          ],
          color: ColorConstants.white,
          borderRadius: BorderRadius.all(Radius.circular(30)),
        ),
        width: scale.fullWidth,
        child: Obx(() {
          switch (controller.currentScreen.value) {
            case 0:
              return buildLoginField(scale);
            case 1:
              return buildOtpField(scale);
            case 2:
              return buildPasswordField(scale);
            case 3:
              return buildRegisterField(scale);
            default:
              return buildLoginField(scale);
          }
        }),
      ),
    );
  }

  Widget buildLoginField(ScalingUtility scale) {
    return Column(
      children: [
        SizedBox(height: scale.getScaledHeight(10)),
        FittedBox(
          fit: BoxFit.scaleDown,
          child: Text(
            'Welcome to ProbCell Solutions',
            style: AppStyle.textStylepoppins600black20,
            textAlign: TextAlign.center,
          ),
        ),
        Text(
          'Please enter your email to proceed',
          style: AppStyle.textStylepoppins500grey12,
          textAlign: TextAlign.center,
        ),
        SizedBox(height: scale.getScaledHeight(30)),
        CustomTextField(
          hintText: 'E-mail',
          textEditingController: controller.emailController,
          textInputType: TextInputType.emailAddress,
          textCapitalization: false,
        ),
        SizedBox(height: scale.getScaledHeight(20)),
        CustomTextButton(
          showLoader: controller.loginStatus.value.isLoading,
          buttonText: 'Verify', onTap: () => controller.checkUserLogin(scale)),
      ],
    );
  }

  Widget buildPasswordField(ScalingUtility scale) {
    return Column(
      children: [
        SizedBox(height: scale.getScaledHeight(10)),
        FittedBox(
          fit: BoxFit.scaleDown,
          child: Text(
            'Welcome to ProbCell Solutions',
            style: AppStyle.textStylepoppins600black20,
            textAlign: TextAlign.center,
          ),
        ),
        Text(
          'Please enter your password to proceed',
          style: AppStyle.textStylepoppins500grey12,
          textAlign: TextAlign.center,
        ),
        SizedBox(height: scale.getScaledHeight(30)),
        Obx(
          () => CustomTextField(
            hintText: 'Password',
            textEditingController: controller.passwordController,
            textCapitalization: false,
            textInputType: TextInputType.visiblePassword,
            obsecureText: !controller.obscureText.value,
            suffixIcon: IconButton(
              icon: Icon(controller.obscureText.value ? Icons.visibility : Icons.visibility_off),
              onPressed: () => controller.toggleObscureText(),
            ),
          ),
        ),
        SizedBox(height: scale.getScaledHeight(20)),
        CustomTextButton(
          showLoader: controller.loginStatus.value.isLoading,
          buttonText: 'Login',
          onTap: () {
           controller.loginUser(scale);
          },
        )
      ],
    );
  }

  Widget buildRegisterField(ScalingUtility scale) {
    return Column(
      children: [
        SizedBox(height: scale.getScaledHeight(10)),
        FittedBox(
          fit: BoxFit.scaleDown,
          child: Text(
            'Welcome to ProbCell Solutions',
            style: AppStyle.textStylepoppins600black20,
            textAlign: TextAlign.center,
          ),
        ),
        Text(
          'Please enter your number and password to proceed',
          style: AppStyle.textStylepoppins500grey12,
          textAlign: TextAlign.center,
        ),
        SizedBox(height: scale.getScaledHeight(30)),
        CustomTextField(
            hintText: 'Name',
            textEditingController: controller.nameController,
          ),
        SizedBox(height: scale.getScaledHeight(10)),
        CustomTextField(
          textInputType: TextInputType.phone,
            hintText: 'Phone number',
            textEditingController: controller.phoneController,
            textCapitalization: false,
            onChangeCallback: (value){
             if (value?.length == 10) {
                    FocusManager.instance.primaryFocus?.unfocus();
                  }
                },
                inputFormatters: [LengthLimitingTextInputFormatter(10)],
          ),
          SizedBox(height: scale.getScaledHeight(10)),
        Obx(
          () => CustomTextField(
            hintText: 'Password',
            textInputType: TextInputType.visiblePassword,
            textEditingController: controller.passwordController,
            textCapitalization: false,
            obsecureText: !controller.obscureText.value,
            suffixIcon: IconButton(
              icon: Icon(controller.obscureText.value ? Icons.visibility : Icons.visibility_off),
              onPressed: () => controller.toggleObscureText(),
            ),
          ),
        ),
        SizedBox(height: scale.getScaledHeight(20)),
        CustomTextButton(
          showLoader: controller.loginStatus.value.isLoading,
          buttonText: 'Save',
          onTap: () {
           controller.addUsers(scale);
          },
        )
      ],
    );
  }

  Widget buildOtpField(ScalingUtility scale) {
    return Column(
      children: [
        SizedBox(height: scale.getScaledHeight(10)),
        FittedBox(
          fit: BoxFit.scaleDown,
          child: Text(
            'Welcome to ProbCell Solutions',
            style: AppStyle.textStylepoppins600black20,
            textAlign: TextAlign.center,
          ),
        ),
        Text(
          'Please enter your otp to proceed',
          style: AppStyle.textStylepoppins500grey12,
          textAlign: TextAlign.center,
        ),
        SizedBox(height: scale.getScaledHeight(30)),
        CustomPinputField(textEditingController: controller.otpController),
        SizedBox(height: scale.getScaledHeight(20)),
        CustomTextButton(
          showLoader: controller.loginStatus.value.isLoading,
          buttonText: 'Verify',
          onTap: () {
            // controller.changeScreen(2);
            controller.verifyOtp(scale);
          },
        )
      ],
    );
  }
}
