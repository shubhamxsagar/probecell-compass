import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';
import 'package:probcell_solutions/core/theme/app_decoration.dart';
import 'package:probcell_solutions/core/utils/scaling_utils.dart';

// ignore: must_be_immutable
class CustomPinputField extends StatelessWidget {
   final TextEditingController textEditingController;
  final FocusNode? focusNode;
  final String? Function(String?)? validatorCallback;
  final String? Function(String?)? onChangeCallback;
  final String? Function(String?)? onCompletedCallback;

  CustomPinputField(
      {super.key,
      required this.textEditingController,
      this.focusNode,
      this.validatorCallback,
      this.onChangeCallback,
      this.onCompletedCallback
      });

  @override
  Widget build(BuildContext context) {
    ScalingUtility scale = ScalingUtility(context: context)..setCurrentDeviceSize();

    return Pinput(
      controller: textEditingController,
      focusNode: focusNode,
      length: 4,
      defaultPinTheme: defaultPinTheme.copyWith(
        width: (scale.fullWidth - scale.getScaledWidth(50)) / 7,
        height: scale.getScaledHeight(50),
      ),
      separatorBuilder: (index) => SizedBox(width: ((scale.fullWidth - scale.getScaledWidth(50)) / 7) / 5),
      validator: validatorCallback,
      hapticFeedbackType: HapticFeedbackType.lightImpact,
      onCompleted: onCompletedCallback,
      onChanged: onChangeCallback,
      focusedPinTheme: defaultPinTheme.copyWith(
        width: (scale.fullWidth - scale.getScaledWidth(50)) / 5,
        height: scale.getScaledHeight(50),
        decoration: defaultPinTheme.decoration!.copyWith(
          border: Border.all(width: 1.5, color: Colors.blue),
        ),
      ),
      submittedPinTheme: defaultPinTheme.copyWith(
        width: (scale.fullWidth - scale.getScaledWidth(50)) / 5,
        height: scale.getScaledHeight(50),
      ),
      errorPinTheme: defaultPinTheme.copyBorderWith(
        border: Border.all(color: Colors.red),
      ),
    );
  }
}
