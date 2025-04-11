import 'dart:io';
import 'dart:math';
import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/animation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart' as dio;
import 'package:path_provider/path_provider.dart';
import 'package:probcell_solutions/core/constants/color_constant.dart';
import 'package:probcell_solutions/core/services/api_client.dart';
import 'package:probcell_solutions/presentation/chats/models/ai_chat_model.dart';
import 'package:probcell_solutions/presentation/chats/models/user_message_model.dart';

class ChatController extends GetxController with SingleGetTickerProviderMixin {
  RxInt currentScreen = 0.obs;

  Rx<File?> selectedFile = Rx<File?>(null);
  RxString selectedFileName = ''.obs;

  late ApiClient _apiClient;
  late AnimationController animationController;
  late Animation<double> animation;
  late AnimationController _animationController;
  TextEditingController chatTextController = TextEditingController();
  var isSendButtonVisible = false.obs;
  var rotationValue = 0.0.obs;
  RxString chatText = 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod temp'.obs;

  // New AnimationController for CircleAvatar gradient
  late AnimationController circleAvatarGradientController;
  var isGradientActive = true.obs; // To toggle between gradient and primary color

  UserMessageModel? userMessageModel;
  AiChatModel? aiChatModel;

  Rx<RxStatus> userMessageModelStatus = RxStatus.empty().obs;
  Rx<RxStatus> sendMessageStatus = RxStatus.empty().obs;

  Rx<RxStatus> aiChatModelStatus = RxStatus.empty().obs;
  // Rx<RxStatus> aiMessageStatus = RxStatus.empty().obs;
  final arguments = Get.arguments;

  RxString selectedCategory = ''.obs;
  RxString selectedSubCategory = ''.obs;
  RxString selectedTypesWork = ''.obs;
  RxString selectedAreas = ''.obs;
  RxString selectedCourses = ''.obs;

  @override
  void onInit() {
    print('onInit called');
    super.onInit();
    _apiClient = Get.find<ApiClient>();
    getMessages();
    print('Arguments 32: $arguments');

    if (arguments != null) {
      print('Arguments: $arguments');
      selectedCategory.value = arguments['category'] ?? '';
      selectedSubCategory.value = arguments['subCategory'] ?? '';
      selectedTypesWork.value = arguments['typesWork'] ?? '';
      selectedAreas.value = arguments['areas'] ?? '';
      selectedCourses.value = arguments['courses'] ?? '';
      newSearchRequest();
    }

    // Existing animation setup
    animationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 5),
    );

    animation = CurvedAnimation(
      parent: animationController,
      curve: Curves.linear,
    );

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 5),
    )..repeat();

    _animationController.addListener(() {
      rotationValue.value = _animationController.value * 2 * pi;
    });

    _startAnimationCycle();

    // New animation setup for CircleAvatar gradient
    circleAvatarGradientController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 2), // Total duration for gradient animation
    )..repeat(); // Repeat the animation indefinitely

    // After 20 seconds, stop the gradient and show primary color
    Future.delayed(Duration(seconds: 20), () {
      isGradientActive.value = false; // Disable gradient
      circleAvatarGradientController.stop(); // Stop the animation
    });
  }

  @override
  void onReady() {
    // TODO: implement onReady
    print('Arguments 32: $arguments');

    if (arguments != null) {
      print('Arguments: $arguments');
      selectedCategory.value = arguments['category'] ?? '';
      selectedSubCategory.value = arguments['subCategory'] ?? '';
      selectedTypesWork.value = arguments['typesWork'] ?? '';
      selectedAreas.value = arguments['areas'] ?? '';
      selectedCourses.value = arguments['courses'] ?? '';
      newSearchRequest();
    }
    super.onReady();
  }

  void onUseText() {
    chatTextController.text = chatText.value;
    onTextChanged(chatText.value);
  }

  Future<void> downloadFile(String url) async {
    try {
      // Use a package like dio or http to download the file
      // Example with dio:
      final dio = Dio();
      final directory = await getApplicationDocumentsDirectory();
      final filePath = '${directory.path}/${url.split('/').last}';
      await dio.download(url, filePath);

      Get.snackbar('Download Complete', 'File saved to $filePath', snackPosition: SnackPosition.BOTTOM);
    } catch (e) {
      Get.snackbar('Download Failed', 'Error: $e', snackPosition: SnackPosition.BOTTOM);
    }
  }

  @override
  void onClose() {
    animationController.dispose();
    _animationController.dispose();
    circleAvatarGradientController.dispose();
    super.onClose();
  }

  void getBackCall() {
    Get.back(result: ['refresh']);
  }

  void onTextChanged(String text) {
    isSendButtonVisible.value = text.isNotEmpty;
  }

  void _startAnimationCycle() async {
    while (true) {
      await _spinAnimation();
      await Future.delayed(Duration(seconds: 10));
    }
  }

  Future<void> _spinAnimation() async {
    if (!animationController.isAnimating) {
      animationController.repeat();
      await Future.delayed(Duration(seconds: 20));
      if (animationController.isAnimating) {
        animationController.stop();
        animationController.reset();
      }
    }
  }

  void onStarClicked() {
    _spinAnimation();
  }

  Color getShadowColor() {
    final double value = rotationValue.value / (2 * pi); // Normalize to 0-1
    return Color.lerp(Colors.blue, ColorConstants.primaryColor, value)!;
  }

  Future<void> getMessages() async {
    userMessageModelStatus.value = RxStatus.loading();
    userMessageModel = null;
    await _apiClient.messages(
      onSuccess: (onSuccess) {
        print('Success: $onSuccess');
        userMessageModelStatus.value = RxStatus.success();
        userMessageModel = UserMessageModel.fromJson(onSuccess);
      },
      onError: (onError) {
        print('Error: $onError');
        userMessageModelStatus.value = RxStatus.error(onError);
      },
    );
  }

  // Future<void> sendMessage() async {
  //   sendMessageStatus.value = RxStatus.loading();
  //   await _apiClient.sendMessage(
  //     requestData: {
  //       'message': chatTextController.text,
  //     },
  //     onSuccess: (onSuccess) {
  //       print('Success: $onSuccess');
  //       chatTextController.clear();
  //       getMessages();
  //       sendMessageStatus.value = RxStatus.success();
  //     },
  //     onError: (onError) {
  //       sendMessageStatus.value = RxStatus.error(onError);
  //       print('Error: $onError');
  //     },
  //   );
  // }

  Future<void> sendMessage() async {
    if (selectedFile.value != null) {
      var formData = dio.FormData();
      formData = dio.FormData.fromMap({
        'file': await dio.MultipartFile.fromFile(
          selectedFile.value!.path,
          filename: selectedFile.value!.path.split('/').last,
        ),
        "message": chatTextController.text,
      });
      sendMessageStatus.value = RxStatus.loading();
      await _apiClient.sendMessage(
        message: chatTextController.text,
        formData: formData,
        onSuccess: (onSuccess) {
          print('Success: $onSuccess');
          chatTextController.clear();
          selectedFile.value = null;
          selectedFileName.value = '';
          getMessages();
          sendMessageStatus.value = RxStatus.success();
        },
        onError: (onError) {
          sendMessageStatus.value = RxStatus.error(onError);
          print('Error: $onError');
        },
      );
    } else {
      sendMessageStatus.value = RxStatus.loading();
      await _apiClient.sendMessageOnly(
        requestData: {
          'message': chatTextController.text,
        },
        onSuccess: (onSuccess) {
          print('Success: $onSuccess');
          chatTextController.clear();
          getMessages();
          sendMessageStatus.value = RxStatus.success();
        },
        onError: (onError) {
          sendMessageStatus.value = RxStatus.error(onError);
          print('Error: $onError');
        },
      );
    }
  }

  Map<String, List<Messages>> get groupedMessages {
    final Map<String, List<Messages>> grouped = {};
    for (var message in userMessageModel!.messages!) {
      final date = _formatDate(message.createdAt!);
      if (!grouped.containsKey(date)) {
        grouped[date] = [];
      }
      grouped[date]!.add(message);
    }
    return grouped;
  }

  String _formatDate(String dateTime) {
    final DateTime parsedDate = DateTime.parse(dateTime);
    return '${parsedDate.day}/${parsedDate.month}/${parsedDate.year}';
  }

  Future<void> pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
      File file = File(result.files.single.path!);
      selectedFile.value = file;
      selectedFileName.value = result.files.single.name;
    } else {
      // User canceled the picker
    }
  }

  Future<void> newSearchRequest() async {
    print('Selected new search: $selectedCategory');
    aiChatModelStatus.value = RxStatus.loading();
    await _apiClient.newSearchRequest(
      formData: dio.FormData.fromMap({
        'type_of_work_id': selectedTypesWork.value,
        'course_id': selectedCourses.value,
        'area_id': selectedAreas.value,
        'category_id': selectedCategory.value,
        'sub_category_id': selectedSubCategory.value,
      }),
      onSuccess: (onSuccess) {
        print('Success new search: $onSuccess');
        aiChatModelStatus.value = RxStatus.success();
        aiChatModel = AiChatModel.fromJson(onSuccess);
        chatTextController.clear();
      },
      onError: (onError) {
        print('Error new search: $onError');
        aiChatModelStatus.value = RxStatus.error(onError);
      },
    );
  }
}
