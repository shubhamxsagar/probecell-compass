import 'dart:ui';
import 'dart:io';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../core/constants/color_constant.dart';
import 'package:path/path.dart' as path;
import 'package:mime/mime.dart';


import 'dart:typed_data';


String convertIso8601ToCustomFormat(String iso8601String) {
  if(iso8601String.isEmpty)return '';
  // Parse the ISO 8601 date string
  DateTime parsedDate = DateTime.parse(iso8601String);

  // Format the date to "dd-MMM-yyyy"
  DateFormat formatter = DateFormat('dd-MMM-yyyy');
  String formattedDate = formatter.format(parsedDate);

  return formattedDate;
}

String convertIso8601ToFullDateAndTime(String iso8601String) {
  if(iso8601String.isEmpty)return '';
  // Parse the ISO 8601 date string into a DateTime object
  DateTime parsedDate = DateTime.parse(iso8601String);

  // Format the DateTime object into the desired format
  DateFormat formatter = DateFormat('dd/MM/yy, hh:mm a');
  String formattedDate = formatter.format(parsedDate.toLocal());

  return formattedDate;
}

String convertDateTimeToyyyyMMdd(DateTime dateTime) {

  final DateFormat formatter = DateFormat('yyyy-MM-dd');

  // Format the DateTime object into the desired format
  String formattedDate = formatter.format(dateTime);

  return formattedDate;
}


//Function to Format Number String to Indian Numbering Format
String formatIndianNumber(String? number) {
  if(number==null)return '';

  // Remove any existing commas in the input number string
  number = number.replaceAll(',', '');

  // If the number is less than or equal to 3 digits, return it as is
  if (number.length <= 3) {
    return number;
  }

  // Initialize an empty string to store the formatted number
  String formattedNumber = '';

  // Get the last three digits
  String lastThreeDigits = number.substring(number.length - 3);
  formattedNumber = lastThreeDigits;

  // Remove the last three digits from the number string
  number = number.substring(0, number.length - 3);

  // Process the remaining digits
  while (number!.isNotEmpty) {
    // Get the next two digits
    String nextTwoDigits;
    if (number.length > 2) {
      nextTwoDigits = number.substring(number.length - 2);
      number = number.substring(0, number.length - 2);
    } else {
      nextTwoDigits = number;
      number = '';
    }

    // Prepend the next two digits with a comma to the formatted number
    formattedNumber = '$nextTwoDigits,$formattedNumber';
  }

  return formattedNumber;
}

Color getColorBasedOnFileExtension(String extension){
  Color finalColor = ColorConstants.grey2Light;
  switch(extension){
    // case 'pdf': finalColor = ColorConstants.pdfRed;
    case 'pdf': finalColor = ColorConstants.jpgLightBlue;
    break;
    case 'jpg': finalColor = ColorConstants.jpgLightBlue;
    case 'jpeg': finalColor = ColorConstants.jpgLightBlue;
    break;
    case 'png': finalColor = ColorConstants.pngLightBlue;
    break;
    case 'xlsx': finalColor = ColorConstants.xlsxGreen;
    case 'xls': finalColor = ColorConstants.xlsxGreen;
    break;
    case 'doc': finalColor = ColorConstants.docBlue;
    break;
  }
  return finalColor;
}


String? getKeyFromValueInMap(Map<String,String> map, String value){
  String key = map.keys.firstWhere((k) => map[k] == value, orElse: () => '');
  return key.isNotEmpty ? key : null;
}


String adjustZAtEnd(String input) {
  int zCount = 0;

  for (int i = input.length - 1; i >= 0; i--) {
    if (input[i] == 'Z') {
      zCount++;
    } else {
      break;
    }
  }

  if (zCount == 0) {
    return '${input}Z';
  } else if (zCount == 1) {
    return input;
  } else {
    return '${input.substring(0, input.length - zCount)}Z';
  }
}


PlatformFile createPlatformFileFromPath(String filePath) {
  File file = File(filePath);

  // Get the file name
  String fileName = path.basename(filePath);

  // Detect the MIME type based on the file path
  // String? mimeType = lookupMimeType(filePath);

  // Determine the file extension based on the MIME type
  String? mimeType  =lookupMimeType(filePath) ?? (determineMimeTypeFromContent(filePath) ?? 'application/octet-stream');

  // // If the file name lacks an extension, append the inferred extension
  // if (extension != null && !fileName.contains('.')) {
  //   fileName = '$fileName.$extension';
  // }
  // Determine file extension based on MIME type
  String? extension = extensionFromMime(mimeType);
  if (extension != null && !fileName.contains('.')) {
    fileName = '$fileName.$extension';
  }

  // Get the file size
  int fileSize = file.lengthSync();

  // Create and return a PlatformFile instance
  return PlatformFile(
    name: fileName,
    size: fileSize,
    path: filePath,
    // bytes: file.readAsBytesSync(), // Optional, only if you want to read bytes
  );
}

Future<bool> isSdk32orBelow() async {
  final deviceInfo = DeviceInfoPlugin();
  final androidInfo = await deviceInfo.androidInfo;
  final sdkInt = androidInfo.version.sdkInt;

  if (sdkInt <= 32) {
    // Perform task for SDK 32 or below
    return true;
  } else {
    // Perform task for SDK above 32
    return false;
  }
}

String? determineMimeTypeFromContent(String filePath) {
  File file = File(filePath);
  Uint8List fileBytes = file.readAsBytesSync();

  // Example: Check for JPEG magic numbers (0xFF, 0xD8, 0xFF)
  if (fileBytes.length > 3 && fileBytes[0] == 0xFF && fileBytes[1] == 0xD8 && fileBytes[2] == 0xFF) {
    return 'image/jpeg';
  }

  // Example: Check for PNG magic numbers (0x89, 0x50, 0x4E, 0x47)
  if (fileBytes.length > 4 && fileBytes[0] == 0x89 && fileBytes[1] == 0x50 && fileBytes[2] == 0x4E && fileBytes[3] == 0x47) {
    return 'image/png';
  }

  // Check for PDF magic numbers (0x25, 0x50, 0x44, 0x46, 0x2D)
  if (fileBytes.length > 4 && fileBytes[0] == 0x25 && fileBytes[1] == 0x50 && fileBytes[2] == 0x44 && fileBytes[3] == 0x46 && fileBytes[4] == 0x2D) {
    return 'application/pdf';
  }

  // Add more checks for other file types if needed

  return null; // Return null if the MIME type is still not determined
}


String? extensionFromMime(String mimeType) {
  // A basic mapping from MIME types to file extensions
  final mimeToExtension = {
    'image/jpeg': 'jpg', // Handles both .jpg and .jpeg
    'image/png': 'png',
    'application/pdf': 'pdf',
    // Add more mappings as needed
  };

  return mimeToExtension[mimeType];
}