import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:probcell_solutions/core/constants/color_constant.dart';
import 'package:probcell_solutions/core/constants/image_constant.dart';
import 'package:probcell_solutions/core/theme/app_style.dart';
import 'package:probcell_solutions/core/utils/scaling_utils.dart';
import 'package:probcell_solutions/presentation/chats/chat_controller.dart';
import 'package:probcell_solutions/presentation/widgets/custom_text_button.dart';

class ChatScreen extends GetView<ChatController> {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ScalingUtility scale = ScalingUtility(context: context)..setCurrentDeviceSize();
    final bottomPadding = MediaQuery.of(context).viewInsets.bottom;

    return Padding(
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
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  // Chat Messages
                  Obx(
                    () => Visibility(
                      visible: !controller.isSendButtonVisible.value,
                      child: Column(
                        children: [
                          SizedBox(height: scale.getScaledHeight(60)),
                          SizedBox(
                            height: scale.getScaledHeight(140),
                            width: scale.getScaledWidth(140),
                            child: Image.asset(ImageConstant.robot),
                          ),
                          FittedBox(
                            fit: BoxFit.scaleDown,
                            child: Text('Hi, Shubham!', style: AppStyle.textStylepoppins600black20),
                          ),
                          FittedBox(
                            fit: BoxFit.scaleDown,
                            child: Text('Am Ready For Help You', style: AppStyle.textStylepoppins600black20),
                          ),
                          SizedBox(height: scale.getScaledHeight(8)),
                          Text(
                            'Ask me anything you want to research about your doubts',
                            style: AppStyle.textStylepoppins400navyBlueDark14,
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  ),
                  ListView(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    children: [
                      // Add your chat messages here
                    ],
                  ),
                  // Probcell Compass Suggestion
                  Obx(()=> Visibility(
                      visible: !controller.isSendButtonVisible.value,
                      child: buildAiSuggestions(scale)),
                  ),
                  // Ask Expert
                  Obx(
                    () => Visibility(
                      visible: controller.isSendButtonVisible.value,
                      child: buildAskExpert(scale),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(bottom: bottomPadding),
            child: Row(
              children: [
                 
              AnimatedBuilder(
  animation: controller.circleAvatarGradientController,
  builder: (context, child) {
    return Obx(() => Stack(
          alignment: Alignment.center,
          children: [
            Container(
              width: 44, // Slightly larger size for the border effect
              height: 44, // Slightly larger size for the border effect
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: controller.isGradientActive.value
                    ? SweepGradient(
                        colors: [
                          Colors.purple,
                          ColorConstants.secondaryColor,
                          Colors.blue,
                        ],
                        stops: [0.0, 0.5, 1.0],
                        transform: GradientRotation(
                          controller.circleAvatarGradientController.value * 2 * pi,
                        ),
                      )
                    : null, // No gradient when inactive
              ),
            ),
            Container(
              width: 40, // Adjust size as needed
              height: 40, // Adjust size as needed
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: ColorConstants.primaryColor, // Solid color
              ),
              child: IconButton(
                icon: const Icon(
                  Icons.add,
                  color: Colors.white,
                ),
                onPressed: () {},
              ),
            ),
          ],
        ));
  },
),
                SizedBox(width: 10),
                Expanded(
  child: TextField(
    controller: controller.chatTextController,
    decoration: InputDecoration(
      hintText: 'Say something...',
      border: InputBorder.none,
    ),
    onChanged: controller.onTextChanged,
    maxLines: null, // Allow the TextField to expand vertically
    minLines: 1,   // Start with a single line
  ),
),
                RotationTransition(
                  turns: controller.animationController,
                  child: SvgPicture.asset(SvgConstant.star),
                ),
                Obx(() => controller.isSendButtonVisible.value
                    ? IconButton(
                        icon: Icon(Icons.send),
                        onPressed: () {
                          // Handle send action
                        },
                      )
                    : Container()),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildAiSuggestions(ScalingUtility scale) {
    return Padding(
      padding: scale.getPadding(bottom: 10),
      child: Obx(() {
        return Container(
          width: scale.fullWidth,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: Colors.transparent,
              width: 2,
            ),
            gradient: SweepGradient(
              colors: [
                ColorConstants.primaryColor,
                ColorConstants.primaryColor.withOpacity(0.5),
                Colors.blue,
              ],
              stops: [0.0, 0.5, 1.0],
              startAngle: 0,
              endAngle: 2 * pi,
              transform: GradientRotation(controller.rotationValue.value), // Use rotationValue
            ),
            boxShadow: [
              BoxShadow(
                color: controller.getShadowColor().withOpacity(0.5), // Dynamic shadow color
                blurRadius: 10,
                spreadRadius: 2,
              ),
            ],
          ),
          // padding: scale.getPadding(all: 15),
          child: Container(
             padding: scale.getPadding(all: 15),
            decoration: BoxDecoration(
              color: ColorConstants.white,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: scale.getScaledHeight(5)),
                Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        ColorConstants.primaryColor.withOpacity(0.1),
                        ColorConstants.primaryColor.withOpacity(0.2),
                      ],
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                      tileMode: TileMode.repeated,
                    ),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  padding: scale.getPadding(all: 4),
                  child: Row(
                    children: [
                      SizedBox(width: scale.getScaledWidth(10)),
                      SizedBox(
                        height: scale.getScaledHeight(15),
                        width: scale.getScaledWidth(15),
                        child: SvgPicture.asset(SvgConstant.star),
                      ),
                      SizedBox(width: scale.getScaledWidth(10)),
                      Text(
                        'Probcell Compass Suggestion',
                        style: AppStyle.textStylepoppins600black12,
                      ),
                    ],
                  ),
                ),
                SizedBox(height: scale.getScaledHeight(8)),
                Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        ColorConstants.primaryColor.withOpacity(0.1),
                        ColorConstants.primaryColor.withOpacity(0.2),
                      ],
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                      tileMode: TileMode.repeated,
                    ),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  padding: scale.getPadding(all: 10),
                  child: Row(
                    children: [
                      SizedBox(width: scale.getScaledWidth(10)),
                      Expanded(
                        child: Obx(()=> Text(
                            controller.chatText.value,
                            style: AppStyle.textStylepoppins500blackLight12,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: scale.getScaledHeight(8)),
                ElevatedButton(
                  onPressed: () {
                    controller.onUseText();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: ColorConstants.primaryColor,
                    padding: scale.getPadding(vertical: 8, horizontal: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Text(
                    'Use this information',
                    style: AppStyle.textStylepoppins600white14.copyWith(fontSize: 12),
                  ),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }

  Widget buildAskExpert(ScalingUtility scale) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Ask the expert', style: AppStyle.textStylepoppins600primary16),
        Text('Lorem ipsum dolor sit amet, consectetur .', style: AppStyle.textStylepoppins500grey2Light12),
        SizedBox(height: scale.getScaledHeight(8)),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: ColorConstants.primaryBgColor),
          ),
          padding: scale.getPadding(all: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
                style: AppStyle.textStylepoppins500blackLight12,
              ),
              SizedBox(height: scale.getScaledHeight(20)),
              ElevatedButton(
                onPressed: () {},
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
                      'Ask Now',
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
        SizedBox(height: scale.getScaledHeight(15)),
      ],
    );
  }
}
