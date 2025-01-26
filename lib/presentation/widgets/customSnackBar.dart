
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:probcell_solutions/core/constants/color_constant.dart';
import 'package:probcell_solutions/core/theme/app_style.dart';
import 'package:probcell_solutions/core/utils/scaling_utils.dart';

void showEnterAllFieldsSnackBar(ScalingUtility scale){
  ScaffoldMessenger.of(Get.context!).showSnackBar(SnackBar(
    duration: const Duration(milliseconds: 1000),
    behavior: SnackBarBehavior.floating,
    backgroundColor: Colors.transparent,
    margin: scale.getMargin(bottom: 75),
    // width: scale.getScaledWidth(260),
    elevation: 0.0,
    content: Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          decoration: BoxDecoration(
            color: ColorConstants.grey,
            borderRadius: BorderRadius.all(Radius.circular(scale.getScaledWidth(5)))
          ),
          padding: scale.getPadding(horizontal: 5,vertical: 5),
          child: Row(
            children: [
              Icon(Icons.info_outline, size: scale.getScaledWidth(18), color: ColorConstants.white,),
              SizedBox(width: scale.getScaledWidth(8),),
              Text(
                'Please fill all required fields',style: AppStyle.textStylepoppins500navyBlueDark14.copyWith(
                  fontSize: scale.getScaledFont(12),
                  color: ColorConstants.white,
                  fontWeight: FontWeight.w400),
              ),
            ],
          ),
        ),
      ],
    ),
    // backgroundColor: ColorConstants.green,
  ));
}

void showErrorMessageSnackBar(ScalingUtility scale, String msg){
  ScaffoldMessenger.of(Get.context!).showSnackBar(SnackBar(
    duration: const Duration(milliseconds: 1000),
    behavior: SnackBarBehavior.floating,
    backgroundColor: Colors.transparent,
    margin: scale.getMargin(bottom: 75),
    // width: scale.getScaledWidth(260),
    elevation: 0.0,
    content: Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          decoration: BoxDecoration(
              color: ColorConstants.grey,
              borderRadius: BorderRadius.all(Radius.circular(scale.getScaledWidth(5)))
          ),
          padding: scale.getPadding(horizontal: 5,vertical: 5),
          child: Row(
            children: [
              Icon(Icons.info_outline, size: scale.getScaledWidth(18), color: ColorConstants.white,),
              SizedBox(width: scale.getScaledWidth(8),),
              Text(
                msg,style: AppStyle.textStylepoppins500navyBlueDark14.copyWith(
                  fontSize: scale.getScaledFont(12),
                  color: ColorConstants.white,
                  fontWeight: FontWeight.w400),
              ),
            ],
          ),
        ),
      ],
    ),
    // backgroundColor: ColorConstants.green,
  ));
}



void showSuccessMessageSnackBar(ScalingUtility scale, String msg){
  ScaffoldMessenger.of(Get.context!).showSnackBar(SnackBar(
    duration: const Duration(milliseconds: 1000),
    behavior: SnackBarBehavior.floating,
    backgroundColor: Colors.transparent,
    margin: scale.getMargin(bottom: 50),
    // width: scale.getScaledWidth(260),
    elevation: 0.0,
    content: Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          decoration: BoxDecoration(
              color: ColorConstants.primaryBgColor,
              borderRadius: BorderRadius.all(Radius.circular(scale.getScaledWidth(5)))
          ),
          padding: scale.getPadding(horizontal: 5,vertical: 5),
          child: Row(
            children: [
              Icon(Icons.check, size: scale.getScaledWidth(18), color: ColorConstants.white,),
              SizedBox(width: scale.getScaledWidth(8),),
              Text(
                msg,style: AppStyle.textStylepoppins500navyBlueDark14.copyWith(
                  fontSize: scale.getScaledFont(12),
                  color: ColorConstants.white,
                  fontWeight: FontWeight.w400),
              ),
            ],
          ),
        ),
      ],
    ),
    // backgroundColor: ColorConstants.green,
  ));
}