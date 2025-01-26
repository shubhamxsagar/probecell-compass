import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/constants/color_constant.dart';
import '../../core/theme/app_decoration.dart';
import '../../core/theme/app_style.dart';

class CustomDropdown extends StatelessWidget {
  final List<String> items;
  final String hintText;
  final String selectedItems;
  final String? Function(String?)? onChangeCallback;

  CustomDropdown({
    super.key,
    required this.items,
    required this.hintText,
    required this.selectedItems,
    required this.onChangeCallback,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: scale.getScaledHeight(45),
      width: double.maxFinite,
      decoration: BoxDecoration(
          color: ColorConstants.white,
          borderRadius: BorderRadius.all(Radius.circular(scale.getScaledWidth(6))),
          border: Border.all(
            color: ColorConstants.greyLight,
            width: 1,
          )),
      padding: EdgeInsets.only(left: scale.getScaledWidth(10)),
      child: DropdownButtonHideUnderline(
        child: DropdownButton2<String>(
          hint: Text(
            hintText.tr,
            style: AppStyle.textStylepoppins400grey2Light16,
          ),
          value: (selectedItems.isEmpty)
              ? null
              : selectedItems,
          iconStyleData: IconStyleData(
            icon: Padding(
              padding: scale.getPadding(right: 10),
              child: const Icon(
                Icons.keyboard_arrow_down,
              ),
            ),
            iconSize: 26,
            iconEnabledColor: ColorConstants.black,
            iconDisabledColor: ColorConstants.black,
          ),
          items: items.map((var item) {
            return DropdownMenuItem(
              value: item,
              child: Padding(
                padding: const EdgeInsets.only(left: 0.0),
                child: Text(item, style: AppStyle.textStylepoppins600black16),
              ),
            );
          }).toList(),
          dropdownStyleData: DropdownStyleData(
              maxHeight: scale.getScaledHeight(150),
              width: scale.fullWidth - scale.getScaledWidth(30),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(scale.getScaledWidth(13)),
                border: Border.all(width: 0.1, color: ColorConstants.black),
                color: ColorConstants.white,
              ),
              offset: Offset(-scale.getScaledWidth(12), -5),
              elevation: 0),
          menuItemStyleData: MenuItemStyleData(
            height: scale.getScaledHeight(40),
            padding: scale.getPadding(horizontal: 13),
          ),
          onChanged: onChangeCallback,
           
        ),
      ),
    );
  }
}
