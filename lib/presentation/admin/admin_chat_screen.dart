import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:probcell_solutions/core/constants/color_constant.dart';
import 'package:probcell_solutions/core/utils/scaling_utils.dart';
import 'package:probcell_solutions/presentation/admin/admin_controller.dart';
import 'package:probcell_solutions/presentation/admin/admin_get_user_message_model.dart';
import 'package:probcell_solutions/presentation/widgets/customSnackBar.dart';

class AdminChatScreen extends GetView<AdminController> {
  final ScrollController _scrollController = ScrollController();
  final _focusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    ScalingUtility scale = ScalingUtility(context: context)..setCurrentDeviceSize();
    final bottomPadding = MediaQuery.of(context).viewInsets.bottom;

    return WillPopScope(
      onWillPop: () async {
        controller.userID.value = '';
        return true;
      },
      child: Scaffold(
        backgroundColor: ColorConstants.white,
        body: Obx(() {
            if(controller.getUserStatus.value.isLoading){
              return Center(
                child: CircularProgressIndicator(
                  color: ColorConstants.adminPrimaryColor,
                ),
              );
            }
            final user = controller.adminGetUserMessageModel?.user;
            
            return AnimatedContainer(
              duration: Duration(milliseconds: 500),
              decoration: BoxDecoration(
                gradient: RadialGradient(
                  center: Alignment.topLeft,
                  radius: 1.5,
                  colors: [
                    ColorConstants.adminPrimaryColor.withOpacity(0.05),
                    Colors.transparent,
                  ],
                ),
              ),
              child: Column(
                children: [
                  // App Bar with user info
                  _buildChatAppBar(scale, user),
                  
                  // Chat area
                  Expanded(
                    child: LiquidPullToRefresh(
                      onRefresh: () => controller.getUserMessages(),
                      color: ColorConstants.adminPrimaryColor,
                      child: _buildChatContent(scale, bottomPadding),
                    ),
                  ),
                  
                  // Input area
                  _buildInputArea(scale, bottomPadding),
                ],
              ),
            );
          }),
        
      ),
    );
  }

  Widget _buildChatAppBar(ScalingUtility scale, User? user) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            ColorConstants.adminPrimaryColor,
            ColorConstants.adminSecondaryColor,
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 10,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          SizedBox(height: MediaQuery.of(Get.context!).padding.top),
          
          Container(
            height: kToolbarHeight,
            child: Row(
              children: [
                IconButton(
                  icon: Icon(Icons.arrow_back, color: Colors.white),
                  onPressed: () => Get.back(),
                ),
                
                _buildUserAvatar(user),
                
                SizedBox(width: 12),
                
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        user?.name ?? 'Unknown User',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                      // Obx(() {
                      //   return Text(
                      //     controller.sendMessageStatus.value.isLoading
                      //         ? 'Typing...'
                      //         : 'Online',
                      //     style: TextStyle(
                      //       color: Colors.white.withOpacity(0.8),
                      //       fontSize: 12,
                      //     ),
                      //   );
                      // }),
                    ],
                  ),
                ),
                
                IconButton(
                  icon: Icon(Icons.more_vert, color: Colors.white),
                  onPressed: () {
                    // Show user details or options
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildUserAvatar(User? user) {
    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.white,
      ),
      child: ClipOval(
        child: user?.email != null
            ? Icon(Icons.person, color: ColorConstants.adminPrimaryColor)
            : Icon(Icons.person_outline, color: Colors.grey),
      ),
    );
  }

  Widget _buildChatContent(ScalingUtility scale, double bottomPadding) {
      if (controller.adminGetUserMessageModel == null) {
        return _buildLoadingIndicator();
      }

      if (controller.adminGetUserMessageModel?.messages?.isEmpty ?? true) {
        return _buildEmptyChatState(scale);
      }

      return SingleChildScrollView(
        reverse: true,
        physics: ClampingScrollPhysics(),
        child: Padding(
          padding: EdgeInsets.only(bottom: bottomPadding > 0 ? 60 : 0),
          child: Column(
            children: [
              ListView.builder(
                controller: _scrollController,
                reverse: true,
                padding: EdgeInsets.all(16),
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: controller.adminGetUserMessageModel!.messages!.length,
                itemBuilder: (context, index) {
                  final message = controller.adminGetUserMessageModel!
                      .messages![controller.adminGetUserMessageModel!.messages!.length - 1 - index];
              
                  return _buildMessageBubble(
                    message: message,
                    isAdmin: message.sentByUser == 0,
                  );
                },
              ),
            ],
          ),
        ),
      );
  }

  Widget _buildMessageBubble({
    required Messages message, 
    required bool isAdmin,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: isAdmin ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: [
          if (!isAdmin) ...[
            CircleAvatar(
              backgroundColor: ColorConstants.adminPrimaryColor.withOpacity(0.2),
              child: Icon(Icons.person, color: ColorConstants.adminPrimaryColor),
            ),
            SizedBox(width: 8),
          ],
          Flexible(
            child: Container(
              constraints: BoxConstraints(
                maxWidth: MediaQuery.of(Get.context!).size.width * 0.8,
              ),
              decoration: BoxDecoration(
                gradient: isAdmin
                    ? LinearGradient(
                        colors: [
                          ColorConstants.adminPrimaryColor,
                          ColorConstants.adminSecondaryColor,
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      )
                    : LinearGradient(
                        colors: [Color(0xFFF5F5F5), Color(0xFFEAEAEA)],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(isAdmin ? 12 : 0),
                  topRight: Radius.circular(isAdmin ? 0 : 12),
                  bottomLeft: Radius.circular(12),
                  bottomRight: Radius.circular(12),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 6,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              padding: EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (message.message != null)
                    Text(
                      message.message!,
                      style: TextStyle(
                        color: isAdmin ? Colors.white : Colors.black,
                        fontSize: 14,
                      ),
                    ),
                  if (message.fileUrl != null) 
                    _buildFilePreview(message, isAdmin),
                  SizedBox(height: 4),
                  Text(
                    _formatTime(message.createdAt ?? ''),
                    style: TextStyle(
                      color: isAdmin ? Colors.white70 : Colors.grey[600],
                      fontSize: 10,
                    ),
                  ),
                ],
              ),
            ),
          ),
          if (isAdmin) SizedBox(width: 8),
        ],
      ),
    );
  }

  Widget _buildFilePreview(Messages message, bool isAdmin) {
    final isImage = message.fileUrl?.endsWith('.png') == true ||
        message.fileUrl?.endsWith('.jpg') == true ||
        message.fileUrl?.endsWith('.jpeg') == true;

    return GestureDetector(
      onTap: () => _showFilePreview(message.fileUrl!, isImage),
      child: Container(
        margin: EdgeInsets.only(top: 8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: isAdmin 
                ? Colors.white.withOpacity(0.3) 
                : Colors.grey[300]!,
          ),
        ),
        child: isImage
            ? ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network(
                  message.fileUrl!,
                  width: 150,
                  height: 150,
                  fit: BoxFit.cover,
                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress == null) return child;
                    return Container(
                      width: 150,
                      height: 150,
                      color: Colors.grey[200],
                      child: Center(
                        child: CircularProgressIndicator(
                          value: loadingProgress.expectedTotalBytes != null
                              ? loadingProgress.cumulativeBytesLoaded / 
                                  loadingProgress.expectedTotalBytes!
                              : null,
                        ),
                      ),
                    );
                  },
                ),
              )
            : Padding(
                padding: EdgeInsets.all(8),
                child: Row(
                  children: [
                    Icon(Icons.insert_drive_file, 
                        size: 24, 
                        color: isAdmin ? Colors.white : Colors.grey[600]),
                    SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        message.fileUrl!.split('/').last,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: isAdmin ? Colors.white : Colors.black,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
      ),
    );
  }

  Widget _buildInputArea(ScalingUtility scale, double bottomPadding) {
    return Container(
      padding: EdgeInsets.only(
        bottom: max(bottomPadding, 10),
        left: 16,
        right: 16,
        top: 8,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(top: BorderSide(color: Colors.grey.shade200)),
      ),
      child: Obx(() {
        if (controller.selectedFile.value != null) {
          return Column(
            children: [
              _buildFileAttachment(scale),
              SizedBox(height: 8),
              _buildTextInput(scale),
            ],
          );
        }
        return _buildTextInput(scale);
      }),
    );
  }

  Widget _buildTextInput(ScalingUtility scale) {
    return Row(
      children: [
        // Attachment button
        InkWell(
          onTap: controller.pickFile,
          child: Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(
                colors: [
                  ColorConstants.adminPrimaryColor,
                  ColorConstants.adminSecondaryColor,
                ],
              ),
            ),
            child: Icon(Icons.attach_file, color: Colors.white),
          ),
        ),

        SizedBox(width: 8),

        // Text input
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              color: Colors.grey[100],
              borderRadius: BorderRadius.circular(20),
            ),
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: TextField(
              controller: controller.chatTextController,
              focusNode: _focusNode,
              decoration: InputDecoration(
                hintText: 'Type a message...',
                border: InputBorder.none,
              ),
              maxLines: null,
            ),
          ),
        ),

        SizedBox(width: 8),

        // Send button
        Obx(() {
          if (controller.sendMessageStatus.value.isLoading) {
            return Container(
              width: 40,
              height: 40,
              padding: EdgeInsets.all(8),
              child: CircularProgressIndicator(
                strokeWidth: 2,
                color: ColorConstants.adminPrimaryColor,
              ),
            );
          }

          return InkWell(
            onTap: () {
              if (controller.chatTextController.text.isNotEmpty || 
                  controller.selectedFile.value != null) {
                controller.sendAdminMessage();
                _scrollToBottom();
              } else {
                showErrorMessageSnackBar(scale, 'Please enter a message');
              }
            },
            child: Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                  colors: [
                    ColorConstants.adminPrimaryColor,
                    ColorConstants.adminSecondaryColor,
                  ],
                ),
              ),
              child: Icon(Icons.send, color: Colors.white),
            ),
          );
        }),
      ],
    );
  }

  Widget _buildFileAttachment(ScalingUtility scale) {
    return Container(
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          if (controller.selectedFileName.value.endsWith('.png') ||
              controller.selectedFileName.value.endsWith('.jpg') ||
              controller.selectedFileName.value.endsWith('.jpeg'))
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.file(
                controller.selectedFile.value!,
                width: 50,
                height: 50,
                fit: BoxFit.cover,
              ),
            )
          else
            Icon(Icons.insert_drive_file, size: 40),
          SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  controller.selectedFileName.value,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontWeight: FontWeight.w500),
                ),
                SizedBox(height: 4),
                LinearProgressIndicator(
                  value: 0,
                  backgroundColor: Colors.grey[300],
                  color: ColorConstants.adminPrimaryColor,
                ),
              ],
            ),
          ),
          IconButton(
            icon: Icon(Icons.close),
            onPressed: () {
              controller.selectedFile.value = null;
              controller.selectedFileName.value = '';
            },
          ),
        ],
      ),
    );
  }

  Widget _buildLoadingIndicator() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(
            color: ColorConstants.adminPrimaryColor,
          ),
          SizedBox(height: 16),
          Text(
            'Loading messages...',
            style: TextStyle(color: Colors.grey[600]),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyChatState(ScalingUtility scale) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.chat_bubble_outline,
            size: 80,
            color: Colors.grey[300],
          ),
          SizedBox(height: 16),
          Text(
            'No messages yet',
            style: TextStyle(
              fontSize: 18,
              color: Colors.grey[500],
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 8),
          Text(
            'Start the conversation with this user',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.grey[400],
            ),
          ),
        ],
      ),
    );
  }

  void _showFilePreview(String fileUrl, bool isImage) {
    Get.dialog(
      Dialog(
        backgroundColor: Colors.transparent,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (isImage)
              InteractiveViewer(
                child: Image.network(
                  fileUrl,
                  fit: BoxFit.contain,
                ),
              )
            else
              Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  children: [
                    Icon(Icons.insert_drive_file, size: 60),
                    SizedBox(height: 8),
                    Text(
                      fileUrl.split('/').last,
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => controller.downloadFile(fileUrl),
              style: ElevatedButton.styleFrom(
                backgroundColor: ColorConstants.adminPrimaryColor,
              ),
              child: Text('Download File'),
            ),
          ],
        ),
      ),
    );
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.minScrollExtent,
          duration: Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  String _formatTime(String dateTime) {
    final DateTime parsedDate = DateTime.parse(dateTime);
    return '${parsedDate.hour}:${parsedDate.minute.toString().padLeft(2, '0')}';
  }
}