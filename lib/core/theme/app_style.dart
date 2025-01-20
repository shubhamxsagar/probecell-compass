import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../constants/color_constant.dart';
import '../utils/math_utils.dart';
import '../utils/scaling_utils.dart';
import 'package:get/get.dart';


class AppStyle {
  ScalingUtility scale = ScalingUtility(context: Get.context!)
    ..setCurrentDeviceSize();

  static TextStyle textStylepoppins600white16 = GoogleFonts.poppins(
    fontSize: getFontSize(
      16,
    ),
    fontWeight: FontWeight.w600,
    color: ColorConstants.white,
  );
  static TextStyle textStylepoppins600white14 = GoogleFonts.poppins(
    fontSize: getFontSize(
      14,
    ),
    fontWeight: FontWeight.w600,
    color: ColorConstants.white,
  );

  static TextStyle textStylepoppins500whiteLight12 = GoogleFonts.poppins(
    fontSize: getFontSize(
      12,
    ),
    fontWeight: FontWeight.w500,
    color: ColorConstants.whiteLight,
  );

  static TextStyle textStylepoppins600black20 = GoogleFonts.poppins(
    fontSize: getFontSize(
      20,
    ),
    fontWeight: FontWeight.w600,
    color: ColorConstants.black,
  );

  static TextStyle textStylepoppins500blackLight14 = GoogleFonts.poppins(
    fontSize: getFontSize(
      14,
    ),
    fontWeight: FontWeight.w500,
    color: ColorConstants.blackLight,
  );

  static TextStyle textStylepoppins500grey12 = GoogleFonts.poppins(
    fontSize: getFontSize(
      12,
    ),
    fontWeight: FontWeight.w500,
    color: ColorConstants.grey,
  );

  static TextStyle textStylepoppins600grey12 = GoogleFonts.poppins(
    fontSize: getFontSize(
      12,
    ),
    fontWeight: FontWeight.w600,
    color: ColorConstants.grey,
  );

  static TextStyle textStylepoppins400blackLight16 = GoogleFonts.poppins(
    fontSize: getFontSize(
      16,
    ),
    fontWeight: FontWeight.w400,
    color: ColorConstants.blackLight,
  );

  static TextStyle textStylepoppins400grey2Light16 = GoogleFonts.poppins(
    fontSize: getFontSize(
      16,
    ),
    fontWeight: FontWeight.w400,
    color: ColorConstants.grey2Light,
  );


  static TextStyle textStylepoppins700blackLight14 = GoogleFonts.poppins(
    fontSize: getFontSize(
      14,
    ),
    fontWeight: FontWeight.w700,
    color: ColorConstants.blackLight,
  );

  static TextStyle textStylepoppins600blackLight16 = GoogleFonts.poppins(
    fontSize: getFontSize(
      16,
    ),
    fontWeight: FontWeight.w600,
    color: ColorConstants.blackLight,
  );

  static TextStyle textStylepoppins500navyBlueDark13 = GoogleFonts.poppins(
    fontSize: getFontSize(
      13,
    ),
    fontWeight: FontWeight.w500,
    color: ColorConstants.navyBlueDark,
  );

  static TextStyle textStylepoppins600primary11 = GoogleFonts.poppins(
    fontSize: getFontSize(
      11,
    ),
    fontWeight: FontWeight.w600,
    color: ColorConstants.primaryColor,
  );

  static TextStyle textStylepoppins600black18 = GoogleFonts.poppins(
    fontSize: getFontSize(
      18,
    ),
    fontWeight: FontWeight.w600,
    color: ColorConstants.black,
  );


  static TextStyle textStylepoppins700blue3Light20 = GoogleFonts.poppins(
    fontSize: getFontSize(
      20,
    ),
    fontWeight: FontWeight.w700,
    color: ColorConstants.blue3Light,
  );

  static TextStyle textStylepoppins500navyBlueDark15 = GoogleFonts.poppins(
    fontSize: getFontSize(
      15,
    ),
    fontWeight: FontWeight.w500,
    color: ColorConstants.navyBlueDark,
  );

  static TextStyle textStylepoppins500navyBlueDark12 = GoogleFonts.poppins(
    fontSize: getFontSize(
      12,
    ),
    fontWeight: FontWeight.w500,
    color: ColorConstants.navyBlueDark,
  );


  static TextStyle textStylepoppins500black14 = GoogleFonts.poppins(
    fontSize: getFontSize(
      14,
    ),
    fontWeight: FontWeight.w500,
    color: ColorConstants.black,
  );


  static TextStyle textStylepoppins500navyBlueDark16 = GoogleFonts.poppins(
    fontSize: getFontSize(
      16,
    ),
    fontWeight: FontWeight.w500,
    color: ColorConstants.navyBlueDark,
  );

  static TextStyle textStylepoppins600primaryBgColor16 = GoogleFonts.poppins(
    fontSize: getFontSize(
      16,
    ),
    fontWeight: FontWeight.w600,
    color: ColorConstants.primaryBgColor,
  );


  static TextStyle textStylepoppins400grey2Light14 = GoogleFonts.poppins(
    fontSize: getFontSize(
      14,
    ),
    fontWeight: FontWeight.w400,
    color: ColorConstants.grey2Light,
  );


  static TextStyle textStylepoppins500green2Light12 = GoogleFonts.poppins(
    fontSize: getFontSize(
      12,
    ),
    fontWeight: FontWeight.w500,
    color: ColorConstants.green2Light,
  );

  static TextStyle textStylepoppins500blackLight16 = GoogleFonts.poppins(
    fontSize: getFontSize(
      16,
    ),
    fontWeight: FontWeight.w500,
    color: ColorConstants.blackLight,
  );

  static TextStyle textStylepoppins700blackLight20 = GoogleFonts.poppins(
    fontSize: getFontSize(
      20,
    ),
    fontWeight: FontWeight.w700,
    color: ColorConstants.blackLight,
  );


  static TextStyle textStylepoppins600primary16 = GoogleFonts.poppins(
    fontSize: getFontSize(
      16,
    ),
    fontWeight: FontWeight.w600,
    color: ColorConstants.primaryColor,
  );

  static TextStyle textStylepoppins500black16 = GoogleFonts.poppins(
    fontSize: getFontSize(
      16,
    ),
    fontWeight: FontWeight.w500,
    color: ColorConstants.black,
  );

  static TextStyle textStylepoppins600black16 = GoogleFonts.poppins(
    fontSize: getFontSize(
      16,
    ),
    fontWeight: FontWeight.w600,
    color: ColorConstants.black,
  );

  static TextStyle textStylepoppins500black18 = GoogleFonts.poppins(
    fontSize: getFontSize(
      18,
    ),
    fontWeight: FontWeight.w500,
    color: ColorConstants.black,
  );


  static TextStyle textStylepoppins700navyBlueLight30 = GoogleFonts.poppins(
    fontSize: getFontSize(
      30,
    ),
    fontWeight: FontWeight.w700,
    color: ColorConstants.navyBlueLight,
  );

  static TextStyle textStylepoppins500primaryBgColor16 = GoogleFonts.poppins(
    fontSize: getFontSize(
      16,
    ),
    fontWeight: FontWeight.w500,
    color: ColorConstants.primaryBgColor,
  );

  static TextStyle textStylepoppins500red12 = GoogleFonts.poppins(
    fontSize: getFontSize(
      12,
    ),
    fontWeight: FontWeight.w500,
    color: ColorConstants.red,
  );

  static TextStyle textStylepoppins600navyBlueDark16 = GoogleFonts.poppins(
    fontSize: getFontSize(
      16,
    ),
    fontWeight: FontWeight.w600,
    color: ColorConstants.navyBlueDark,
  );

  static TextStyle textStylepoppins500secondaryColor14 = GoogleFonts.poppins(
    fontSize: getFontSize(
      14,
    ),
    fontWeight: FontWeight.w500,
    color: ColorConstants.secondaryColor,
  );

  static TextStyle textStylepoppins600primaryBgColor14 = GoogleFonts.poppins(
    fontSize: getFontSize(
      14,
    ),
    fontWeight: FontWeight.w600,
    color: ColorConstants.primaryBgColor,
  );

  static TextStyle textStylepoppins500grey2Light14 = GoogleFonts.poppins(
    fontSize: getFontSize(
      14,
    ),
    fontWeight: FontWeight.w500,
    color: ColorConstants.grey2Light,
  );

  static TextStyle textStylepoppins600black14 = GoogleFonts.poppins(
    fontSize: getFontSize(
      14,
    ),
    fontWeight: FontWeight.w600,
    color: ColorConstants.black,
  );

  static TextStyle textStylepoppins500blackLight12 = GoogleFonts.poppins(
    fontSize: getFontSize(
      12,
    ),
    fontWeight: FontWeight.w500,
    color: ColorConstants.blackLight,
  );

  static TextStyle textStylepoppins500navyBlueDark14 = GoogleFonts.poppins(
    fontSize: getFontSize(
      14,
    ),
    fontWeight: FontWeight.w500,
    color: ColorConstants.navyBlueDark,
  );

  static TextStyle textStylepoppins500grey2Light12 = GoogleFonts.poppins(
    fontSize: getFontSize(
      12,
    ),
    fontWeight: FontWeight.w500,
    color: ColorConstants.grey2Light,
  );

  static TextStyle textStylepoppins600black12 = GoogleFonts.poppins(
    fontSize: getFontSize(
      12,
    ),
    fontWeight: FontWeight.w600,
    color: ColorConstants.black,
  );

  static TextStyle textStylepoppins400navyBlueDark14 = GoogleFonts.poppins(
    fontSize: getFontSize(
      14,
    ),
    fontWeight: FontWeight.w400,
    color: ColorConstants.navyBlueDark,
  );

  static TextStyle textStylepoppins600blackLight18 = GoogleFonts.poppins(
    fontSize: getFontSize(
      18,
    ),
    fontWeight: FontWeight.w600,
    color: ColorConstants.blackLight,
  );

  static TextStyle textStylepoppins500grey6Light12 = GoogleFonts.poppins(
    fontSize: getFontSize(
      12,
    ),
    fontWeight: FontWeight.w500,
    color: ColorConstants.grey6Light,
  );

  static TextStyle textStylepoppins600blackLight20 = GoogleFonts.poppins(
    fontSize: getFontSize(
      20,
    ),
    fontWeight: FontWeight.w600,
    color: ColorConstants.blackLight,
  );

  static TextStyle textStylepoppins700blue3Light12 = GoogleFonts.poppins(
    fontSize: getFontSize(
      12,
    ),
    fontWeight: FontWeight.w700,
    color: ColorConstants.blue3Light,
  );

  static TextStyle textStylepoppins600red216 = GoogleFonts.poppins(
    fontSize: getFontSize(
      16,
    ),
    fontWeight: FontWeight.w600,
    color: ColorConstants.red2,
  );

  static TextStyle textStylepoppins600primary12 = GoogleFonts.poppins(
    fontSize: getFontSize(
      12,
    ),
    fontWeight: FontWeight.w600,
    color: ColorConstants.primaryColor,
  );

  static TextStyle textStylepoppins500greyDark216 = GoogleFonts.poppins(
    fontSize: getFontSize(
      16,
    ),
    fontWeight: FontWeight.w500,
    color: ColorConstants.greyDark2,
  );

  static TextStyle textStylepoppins500primary14 = GoogleFonts.poppins(
    fontSize: getFontSize(
      14,
    ),
    fontWeight: FontWeight.w500,
    color: ColorConstants.primaryColor,
  );

  static TextStyle textStylepoppins600green114 = GoogleFonts.poppins(
    fontSize: getFontSize(
      14,
    ),
    fontWeight: FontWeight.w600,
    color: ColorConstants.green1,
  );
  static TextStyle textStylepoppins600green12 = GoogleFonts.poppins(
    fontSize: getFontSize(
      12,
    ),
    fontWeight: FontWeight.w600,
    color: ColorConstants.green1,
  );

  static TextStyle textStylepoppins600blackLight14 = GoogleFonts.poppins(
    fontSize: getFontSize(
      14,
    ),
    fontWeight: FontWeight.w600,
    color: ColorConstants.blackLight, 
  );


}