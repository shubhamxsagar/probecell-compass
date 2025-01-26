import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:probcell_solutions/core/constants/color_constant.dart';
import 'package:probcell_solutions/core/theme/app_style.dart';
import 'package:probcell_solutions/core/utils/scaling_utils.dart';

// ignore: must_be_immutable
class CustomTextButton extends StatelessWidget {
  final String buttonText;
  bool? isPrimaryButton = true;
  bool? showSecondaryButtonInRed = false;
  bool? showLoader = false;
  Color? loaderColor = ColorConstants.white;
  double? loaderSize = 0;
  VoidCallback? onTap = () {};
  ButtonStyle? style = ButtonStyle();
  IconData? suffix;

  CustomTextButton({
    super.key,
    required this.buttonText,
    this.isPrimaryButton,
    this.showLoader,
    this.loaderSize,
    this.onTap,
    this.showSecondaryButtonInRed,
    this.loaderColor,
    this.style,
    this.suffix,
  });

  @override
  Widget build(BuildContext context) {
    ScalingUtility scale = ScalingUtility(context: context)..setCurrentDeviceSize();

    return Container(
        width: scale.fullWidth,
        height: scale.getScaledHeight(48),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(scale.getScaledWidth(6))),
          boxShadow: (isPrimaryButton ?? true)
              ? [
                  BoxShadow(
                    color: ColorConstants.primaryColor.withOpacity(0.3),
                    blurRadius: 10.00,
                    offset: const Offset(0, 0),
                    spreadRadius: 1,
                  )
                ]
              : null,
        ),
        child: TextButton(
            onPressed: onTap,
            style: style ??
                TextButton.styleFrom(
                  foregroundColor: (isPrimaryButton ?? true)
                      ? ColorConstants.primaryColor
                      : (showSecondaryButtonInRed ?? false)
                          ? ColorConstants.white
                          : ColorConstants.white,
                  backgroundColor: (isPrimaryButton ?? true)
                      ? ColorConstants.primaryColor
                      : (showSecondaryButtonInRed ?? false)
                          ? ColorConstants.white
                          : ColorConstants.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(scale.getScaledWidth(6)),
                  ),
                  side: (isPrimaryButton ?? true)
                      ? null
                      : BorderSide(
                          color: (showSecondaryButtonInRed ?? false)
                              ? ColorConstants.red2
                              : ColorConstants.primaryColor,
                        ),
                ),
            child: (showLoader ?? false)
                ? (loaderSize != 0)
                    ? SizedBox(
                        height: loaderSize,
                        width: loaderSize,
                        child: CircularProgressIndicator(
                          color: loaderColor ?? ColorConstants.white,
                        ))
                    : CircularProgressIndicator(
                        color: loaderColor ?? ColorConstants.white,
                      )
                : suffix == null
                    ? Text(
                        buttonText.tr,
                        style: (isPrimaryButton ?? true)
                            ? AppStyle.textStylepoppins600black14.copyWith(color: ColorConstants.white)
                            : (showSecondaryButtonInRed ?? false)
                                ? AppStyle.textStylepoppins600black14.copyWith(color: ColorConstants.red)
                                : AppStyle.textStylepoppins600black14.copyWith(color: ColorConstants.primaryColor),
                        textAlign: TextAlign.center,
                      )
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(
                            suffix,
                            color: ColorConstants.white,
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            buttonText.tr,
                            style: AppStyle.textStylepoppins600white16,
                          )
                        ],
                      )));
  }
}
