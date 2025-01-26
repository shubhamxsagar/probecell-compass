import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:probcell_solutions/core/constants/color_constant.dart';
import 'package:probcell_solutions/core/theme/app_style.dart';
import 'package:probcell_solutions/core/utils/scaling_utils.dart';

// ignore: must_be_immutable
class CustomTextField extends StatelessWidget {
  final String hintText;
  final TextEditingController textEditingController;
  bool? readOnly = false;
  bool? enabled = true;
  bool? textCapitalization = true;
  Widget? suffixIcon;
  Widget? prefixIcon;
  Color? fillColor;
  TextInputType? textInputType = TextInputType.text;
  int? minLine = 1;
  int? maxLine = 1;
  FocusNode? focusNode;
  final String? Function(String?)? validatorCallback;
  final String? Function(String?)? onChangeCallback;
  final String? Function(String?)? onFieldSubmitted;
  List<TextInputFormatter>? inputFormatters;
  TextStyle? textStyle;
  bool? obsecureText;

  CustomTextField({
    super.key,
    required this.hintText,
    required this.textEditingController,
    this.textCapitalization = true,
    this.readOnly,
    this.enabled,
    this.suffixIcon,
    this.prefixIcon,
    this.textInputType,
    this.minLine,
    this.maxLine,
    this.textStyle,
    this.validatorCallback,
    this.onChangeCallback,
    this.focusNode,
    this.fillColor,
    this.onFieldSubmitted,
    this.inputFormatters,
    this.obsecureText,
  });
  @override
  Widget build(BuildContext context) {
    ScalingUtility scale = ScalingUtility(context: context)..setCurrentDeviceSize();

    return Form(
      autovalidateMode: AutovalidateMode.always,
      child: TextFormField(
        obscureText: obsecureText ?? false,
        focusNode: focusNode,
        controller: textEditingController,
        style: textStyle ?? AppStyle.textStylepoppins600black16,
        cursorColor: ColorConstants.black,
        keyboardType: textInputType,
        minLines: minLine ?? 1,
        maxLines: maxLine ?? 1,
        textAlign: TextAlign.start,
        enabled: enabled ?? true,
        readOnly: readOnly ?? false,
        validator: validatorCallback,
        inputFormatters: inputFormatters,
        onChanged: onChangeCallback,
        onFieldSubmitted: onFieldSubmitted,
        textCapitalization: textCapitalization! ? TextCapitalization.sentences : TextCapitalization.none,
        // onChanged: (value){
        //   if(value.length==10){
        //     FocusManager.instance.primaryFocus?.unfocus();
        //   }
        // },
        // inputFormatters: [
        //   LengthLimitingTextInputFormatter(10),
        // ],
        decoration: InputDecoration(
            filled: true,
            fillColor: fillColor ?? ColorConstants.white,
            contentPadding: scale.getPadding(all: 10),
            hintText: hintText.tr,
            hintStyle: AppStyle.textStylepoppins400grey2Light16,
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(scale.getScaledWidth(6))),
                borderSide: const BorderSide(
                  color: ColorConstants.greyLight,
                  width: 1,
                )),
            errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(scale.getScaledWidth(6))),
                borderSide: const BorderSide(
                  color: ColorConstants.greyLight,
                  width: 1,
                )),
            focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(scale.getScaledWidth(6))),
                borderSide: const BorderSide(
                  color: ColorConstants.greyLight,
                  width: 1,
                )),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(scale.getScaledWidth(6))),
                borderSide: const BorderSide(
                  color: ColorConstants.black,
                  width: 1,
                )),
            disabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(scale.getScaledWidth(6))),
                borderSide: const BorderSide(
                  color: ColorConstants.greyLight,
                  width: 1,
                )),
            suffixIcon: suffixIcon,
            prefixIcon: prefixIcon),
      ),
    );
  }
}

////TextInputFormatter

class IndianCurrencyFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    if (newValue.text.isEmpty) {
      return newValue.copyWith(text: '');
    }

    final intSelectionIndex = newValue.selection.end;
    final String newText = _formatIndianCurrency(newValue.text);

    return newValue.copyWith(
      text: newText,
      selection: TextSelection.collapsed(offset: intSelectionIndex + newText.length - newValue.text.length),
    );
  }

  String _formatIndianCurrency(String value) {
    String newValue = value.replaceAll(',', '');
    String formattedValue = '';

    int length = newValue.length;

    if (length > 3) {
      String lastThree = newValue.substring(length - 3);
      formattedValue = lastThree;
      newValue = newValue.substring(0, length - 3);

      while (newValue.isNotEmpty) {
        if (newValue.length > 2) {
          String part = newValue.substring(newValue.length - 2);
          formattedValue = '$part,$formattedValue';
          newValue = newValue.substring(0, newValue.length - 2);
        } else {
          formattedValue = '$newValue,$formattedValue';
          newValue = '';
        }
      }
    } else {
      formattedValue = newValue;
    }

    return formattedValue;
  }
}
