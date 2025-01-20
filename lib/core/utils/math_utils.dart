import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:probcell_solutions/core/utils/scaling_utils.dart';

Size size = WidgetsBinding.instance!.window.physicalSize /
    WidgetsBinding.instance!.window.devicePixelRatio;
ScalingUtility Scale = ScalingUtility(context: Get.context!)
  ..setCurrentDeviceSize();

///This method is used to set padding/margin (for the left and Right side) & width of the screen or widget according to the Viewport width.
double getHorizontalSize(double px) {
  return kIsWeb ? Scale.getScaledWidth(px) : px * (size.width / 360);
}

///This method is used to set padding/margin (for the top and bottom side) & height of the screen or widget according to the Viewport height.
double getVerticalSize(double px) {
  num statusBar = MediaQueryData.fromWindow(WidgetsBinding.instance!.window)
      .viewPadding
      .top;
  num screenHeight = size.height - statusBar;
  return kIsWeb ? Scale.getScaledHeight(px) : px * (screenHeight / 600);
}

///This method is used to set text font size according to Viewport
double getFontSize(double px) {
  return Scale.getScaledFont(px);
}

///This method is used to set smallest px in image height and width
double getSize(double px) {
  if (!kIsWeb) {
    var height = getVerticalSize(px);
    var width = getHorizontalSize(px);
    if (height < width) {
      return height.toInt().toDouble();
    } else {
      return width.toInt().toDouble();
    }
  } else {
    return Scale.getScaledFont(px);
  }
}

///This method is used to set padding responsively
EdgeInsetsGeometry getPadding({
  double? all,
  double? left,
  double? top,
  double? right,
  double? bottom,
  double? horizontal,
  double? vertical,
}) {
  if (kIsWeb) {
    if (all != null) {
      return Scale.getPadding(all: all);
    } else if (horizontal != null || vertical != null) {
      return Scale.getPadding(horizontal: horizontal, vertical: vertical);
    } else {
      return Scale.getPadding(
          left: left, right: right, top: top, bottom: bottom);
    }
  } else {
    if (all != null) {
      left = all;
      top = all;
      right = all;
      bottom = all;
    }
    return EdgeInsets.only(
      left: getHorizontalSize(
        left ?? 0,
      ),
      top: getVerticalSize(
        top ?? 0,
      ),
      right: getHorizontalSize(
        right ?? 0,
      ),
      bottom: getVerticalSize(
        bottom ?? 0,
      ),
    );
  }
}

dynamic extractIntegerPartOrFullValue(double value) {
  if (value % 1 == 0) {
    return value.toInt().toString(); // Returns integer part for whole numbers
  } else {
    return value.toString(); // Returns the full value for non-whole numbers
  }
}


///This method is used to set margin responsively
EdgeInsetsGeometry getMargin({
  double? all,
  double? left,
  double? top,
  double? right,
  double? bottom,
  double? horizontal,
  double? vertical,
}) {
  if (kIsWeb) {
    if (all != null) {
      return Scale.getMargin(all: all);
    } else if (horizontal != null || vertical != null) {
      return Scale.getMargin(horizontal: horizontal, vertical: vertical);
    } else {
      return Scale.getMargin(
          left: left, right: right, top: top, bottom: bottom);
    }
  } else {
    if (all != null) {
      left = all;
      top = all;
      right = all;
      bottom = all;
    }
    return EdgeInsets.only(
      left: getHorizontalSize(
        left ?? 0,
      ),
      top: getVerticalSize(
        top ?? 0,
      ),
      right: getHorizontalSize(
        right ?? 0,
      ),
      bottom: getVerticalSize(
        bottom ?? 0,
      ),
    );
  }
}
