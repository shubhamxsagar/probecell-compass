import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:file_picker/file_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:dio/dio.dart' as dio;
import 'package:probcell_solutions/core/services/api_client.dart';
import 'package:probcell_solutions/presentation/admin/admin_get_all_message_model.dart';
import 'package:probcell_solutions/presentation/admin/admin_get_user_message_model.dart';

class AdminController extends GetxController with SingleGetTickerProviderMixin {
  final Rx<File?> selectedFile = Rx<File?>(null);
  final RxString selectedFileName = ''.obs;
  final RxString userID = ''.obs;
  final RxInt totalUnreadMessages = 0.obs;

  RxInt totalChats = 0.obs;
RxInt activeUsers = 0.obs;
RxInt unreadMessages = 0.obs;
RxInt todayMessages = 0.obs;
  
  late final ApiClient _apiClient;
  late final AnimationController circleAvatarGradientController;
  final RxBool isGradientActive = true.obs;
  
  final TextEditingController chatTextController = TextEditingController();
  final Rx<RxStatus> sendMessageStatus = RxStatus.empty().obs;
  final Rx<RxStatus> getAllUserStatus = RxStatus.empty().obs;
  final Rx<RxStatus> getUserStatus = RxStatus.empty().obs;

  AdminGetAllMessageModel? adminGetAllMessageModel;
  AdminGetUserMessageModel? adminGetUserMessageModel;

  @override
  void onInit() {
    super.onInit();
    _apiClient = Get.find<ApiClient>();
    _initAnimation();
    getAllMessages();
  }

  void _initAnimation() {
    circleAvatarGradientController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat();
    
    Future.delayed(const Duration(seconds: 20), () {
      isGradientActive.value = false;
      circleAvatarGradientController.stop();
    });
  }

  DashboardStats getDashboardStats() {
    final data = adminGetAllMessageModel?.data ?? {};
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    
      totalChats.value = data.length;
     activeUsers.value = data.keys.length;
    
    unreadMessages.value = 0;
     todayMessages .value= 0;
    
    data.forEach((key, messages) {
      unreadMessages += messages.where((m) => m.sentByUser == 1).length;
      
      todayMessages += messages.where((m) {
        try {
          final messageDate = DateTime.parse(m.createdAt ?? '');
          return DateTime(messageDate.year, messageDate.month, messageDate.day) == today;
        } catch (e) {
          return false;
        }
      }).length;
    });
    
    totalUnreadMessages.value = unreadMessages.value;
    
    return DashboardStats(
      totalChats: totalChats.value,
      activeUsers: activeUsers.value,
      unreadMessages: unreadMessages.value,
      todayMessages: todayMessages.value,
    );
  }

  Future<void> sendAdminMessage() async {
    try {
      sendMessageStatus.value = RxStatus.loading();
      
      final formData = dio.FormData.fromMap({
        if (selectedFile.value != null && selectedFile.value!.path.isNotEmpty)
          'file': await dio.MultipartFile.fromFile(
            selectedFile.value!.path,
            filename: selectedFile.value!.path.split('/').last,
          ),
        "message": chatTextController.text,
        "user_id": userID.value,
      });

      await _apiClient.adminSendMessage(
        message: chatTextController.text,
        formData: formData,
        onSuccess: (_) {
          chatTextController.clear();
          selectedFile.value = null;
          selectedFileName.value = '';
          getUserMessages();
          sendMessageStatus.value = RxStatus.success();
        },
        onError: (error) {
          sendMessageStatus.value = RxStatus.error(error.toString());
          Get.snackbar('Error', 'Failed to send message: $error');
        },
      );
    } catch (e) {
      sendMessageStatus.value = RxStatus.error(e.toString());
      Get.snackbar('Error', 'Failed to send message: $e');
    }
  }

  Future<void> getUserMessages() async {
    try {
      getUserStatus.value = RxStatus.loading();
      adminGetUserMessageModel = null;
      
      await _apiClient.adminGetUserMessage(
        userId: userID.value,
        onSuccess: (response) {
          adminGetUserMessageModel = AdminGetUserMessageModel.fromJson(response);
          getUserStatus.value = RxStatus.success();
        },
        onError: (error) {
          getUserStatus.value = RxStatus.error(error.toString());
          Get.snackbar('Error', 'Failed to load messages: $error');
        },
      );
    } catch (e) {
      getUserStatus.value = RxStatus.error(e.toString());
      Get.snackbar('Error', 'Failed to load messages: $e');
    }
  }

  Future<void> getAllMessages() async {
    try {
      getAllUserStatus.value = RxStatus.loading();
      adminGetAllMessageModel = null;
      
      await _apiClient.adminGetAllMessage(
        onSuccess: (response) {
          adminGetAllMessageModel = AdminGetAllMessageModel.fromJson(response);
          getAllUserStatus.value = RxStatus.success();
          getDashboardStats(); // Update stats after loading messages
        },
        onError: (error) {
          getAllUserStatus.value = RxStatus.error(error.toString());
          Get.snackbar('Error', 'Failed to load conversations: $error');
        },
      );
    } catch (e) {
      getAllUserStatus.value = RxStatus.error(e.toString());
      Get.snackbar('Error', 'Failed to load conversations: $e');
    }
  }

  Future<void> pickFile() async {
    try {
      final result = await FilePicker.platform.pickFiles();
      if (result != null && result.files.single.path != null) {
        selectedFile.value = File(result.files.single.path!);
        selectedFileName.value = result.files.single.name;
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to pick file: $e');
    }
  }

  Future<void> downloadFile(String url) async {
    try {
      final dioF = dio.Dio();
      final directory = await getApplicationDocumentsDirectory();
      final filePath = '${directory.path}/${url.split('/').last}';
      await dioF.download(url, filePath);
      Get.snackbar('Success', 'File saved to $filePath');
    } catch (e) {
      Get.snackbar('Error', 'Failed to download file: $e');
    }
  }

  @override
  void onClose() {
    circleAvatarGradientController.dispose();
    chatTextController.dispose();
    super.onClose();
  }
}

class DashboardStats {
  final int totalChats;
  final int activeUsers;
  final int unreadMessages;
  final int todayMessages;

  DashboardStats({
    required this.totalChats,
    required this.activeUsers,
    required this.unreadMessages,
    required this.todayMessages,
  });
}