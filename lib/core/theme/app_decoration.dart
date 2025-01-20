import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';
import '../utils/scaling_utils.dart';

ScalingUtility scale = ScalingUtility(context: Get.context!)
  ..setCurrentDeviceSize();

final defaultPinTheme = PinTheme(
  width: scale.getScaledWidth(40),
  height: scale.getScaledHeight(40),
  textStyle: TextStyle(
    fontSize: scale.getScaledFont(18),
    fontWeight: FontWeight.w600,
    color: Colors.black,
  ),
  decoration: BoxDecoration(
    border: const Border(
      bottom: BorderSide(width: 1, color: Color.fromRGBO(195, 195, 195, 1)),
      top: BorderSide(width: 1, color: Color.fromRGBO(195, 195, 195, 1)),
      left: BorderSide(width: 1, color: Color.fromRGBO(195, 195, 195, 1)),
      right: BorderSide(width: 1, color: Color.fromRGBO(195, 195, 195, 1)),
    ),
    borderRadius: BorderRadius.all(Radius.circular(scale.getScaledWidth(5))),
  ),
);