import 'dart:io';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:probcell_solutions/core/constants/color_constant.dart';
import 'package:probcell_solutions/core/constants/image_constant.dart';
import 'package:probcell_solutions/core/theme/app_style.dart';
import 'package:probcell_solutions/core/utils/scaling_utils.dart';
import 'package:probcell_solutions/presentation/chats/chat_controller.dart';
import 'package:probcell_solutions/presentation/chats/models/user_message_model.dart';
import 'package:probcell_solutions/presentation/widgets/customSnackBar.dart';

class ChatScreen extends GetView<ChatController> {
  final ScrollController _scrollController = ScrollController();
  final _focusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    ScalingUtility scale = ScalingUtility(context: context)..setCurrentDeviceSize();
    final bottomPadding = MediaQuery.of(context).viewInsets.bottom;

    return WillPopScope(
      onWillPop: () async {
        if (controller.currentScreen.value == 1) {
          controller.currentScreen.value = 0;
          return false;
        }
        if (Get.arguments != null) {
          print('refresh is called');
          Get.back(result: {'refresh': true});
        }
        return true;
      },
      child: Scaffold(
        backgroundColor: ColorConstants.white,
        body: SafeArea(
          // Added SafeArea to prevent status bar cutoff
          child: Obx(() {
            // Dynamic theme colors based on mode
            final primaryColor =
                controller.currentScreen.value == 0 ? ColorConstants.primaryColor : Color(0xFF6E48AA);
            final secondaryColor =
                controller.currentScreen.value == 0 ? ColorConstants.secondaryColor : Color(0xFF9D50BB);

            return AnimatedContainer(
              duration: Duration(milliseconds: 500),
              decoration: BoxDecoration(
                gradient: RadialGradient(
                  center: Alignment.topLeft,
                  radius: 1.5,
                  colors: [
                    primaryColor.withOpacity(0.05),
                    Colors.transparent,
                  ],
                ),
              ),
              child: Column(
                children: [
                  // App Bar with mode switcher
                  _buildAppBar(scale, primaryColor, secondaryColor),

                  // Chat area
                  Expanded(
                    child: LiquidPullToRefresh(
                      onRefresh: () => controller.getMessages(),
                      color: primaryColor,
                      child: _buildChatContent(scale, bottomPadding, primaryColor, secondaryColor),
                    ),
                  ),

                  // Input area
                  _buildInputArea(scale, bottomPadding, primaryColor),
                ],
              ),
            );
          }),
        ),
      ),
    );
  }

  Widget _buildAppBar(ScalingUtility scale, Color primaryColor, Color secondaryColor) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [primaryColor, secondaryColor],
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
          // Status bar spacer
          SizedBox(height: MediaQuery.of(Get.context!).padding.top),

          // Main AppBar content
          Container(
            height: kToolbarHeight,
            child: Row(
              children: [
                // Back button with animation
                IconButton(
                  icon: AnimatedSwitcher(
                    duration: Duration(milliseconds: 300),
                    child: controller.currentScreen.value == 0
                        ? Icon(Icons.arrow_back, key: ValueKey('back'), color: Colors.white)
                        : Icon(Icons.close, key: ValueKey('close'), color: Colors.white),
                  ),
                  onPressed: () {
                    if (controller.currentScreen.value == 1) {
                      controller.currentScreen.value = 0;
                    } else {
                      Get.back();
                    }
                  },
                ),

                // Title with animated transition
                Expanded(
                  child: AnimatedSwitcher(
                    duration: Duration(milliseconds: 400),
                    transitionBuilder: (Widget child, Animation<double> animation) {
                      return ScaleTransition(
                        scale: animation,
                        child: FadeTransition(
                          opacity: animation,
                          child: child,
                        ),
                      );
                    },
                    child: FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Text(
                        key: ValueKey(controller.currentScreen.value),
                        controller.currentScreen.value == 0 ? 'PROBECELL AI ASSISTANT' : 'LIVE EXPERT CHAT',
                        style: AppStyle.textStylepoppins600blackLight20.copyWith(
                          color: Colors.white,
                          shadows: [
                            Shadow(
                              color: Colors.black.withOpacity(0.3),
                              blurRadius: 4,
                              offset: Offset(1, 1),
                            ),
                          ],
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ),

                // Info button with pulse animation
                ScaleTransition(
                  scale: Tween(begin: 0.9, end: 1.0).animate(
                    CurvedAnimation(
                      parent: controller.animationController,
                      curve: Curves.easeInOut,
                    ),
                  ),
                  child: IconButton(
                    icon: Icon(Icons.info_outline, color: Colors.white),
                    onPressed: _showChatModeInfo,
                  ),
                ),
              ],
            ),
          ),

          // Mode switcher with animated underline
          Container(
            height: 40,
            margin: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Stack(
              children: [
                // Animated underline
                AnimatedPositioned(
                  duration: Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                  left: controller.currentScreen.value == 0 ? 0 : MediaQuery.of(Get.context!).size.width / 2,
                  child: Container(
                    width: MediaQuery.of(Get.context!).size.width / 2,
                    height: 40,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      gradient: LinearGradient(
                        colors: [
                          Colors.white.withOpacity(0.4),
                          Colors.white.withOpacity(0.2),
                        ],
                      ),
                    ),
                  ),
                ),

                Row(
                  children: [
                    Expanded(
                      child: InkWell(
                        onTap: () => controller.currentScreen.value = 0,
                        child: Center(
                          child: Text(
                            'AI Assistant',
                            style: TextStyle(
                              color: controller.currentScreen.value == 0
                                  ? Colors.white
                                  : Colors.white.withOpacity(0.7),
                              fontWeight: FontWeight.w500,
                              shadows: controller.currentScreen.value == 0
                                  ? [
                                      Shadow(
                                        color: Colors.black.withOpacity(0.3),
                                        blurRadius: 4,
                                        offset: Offset(1, 1),
                                      ),
                                    ]
                                  : null,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: InkWell(
                        onTap: () => controller.currentScreen.value = 1,
                        child: Center(
                          child: Text(
                            'Live Expert',
                            style: TextStyle(
                              color: controller.currentScreen.value == 1
                                  ? Colors.white
                                  : Colors.white.withOpacity(0.7),
                              fontWeight: FontWeight.w500,
                              shadows: controller.currentScreen.value == 1
                                  ? [
                                      Shadow(
                                        color: Colors.black.withOpacity(0.3),
                                        blurRadius: 4,
                                        offset: Offset(1, 1),
                                      )
                                    ]
                                  : null,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Animated divider
          AnimatedContainer(
            duration: Duration(milliseconds: 500),
            height: 2,
            margin: EdgeInsets.only(bottom: 5),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.transparent,
                  Colors.white.withOpacity(0.5),
                  Colors.transparent,
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildChatContent(
      ScalingUtility scale, double bottomPadding, Color primaryColor, Color secondaryColor) {
    return Obx(() {
      return ConstrainedBox(
        constraints: BoxConstraints(
          minHeight: MediaQuery.of(Get.context!).size.height - 200, // Ensure minimum height
        ),
        child: SingleChildScrollView(
          controller: _scrollController,
          reverse: true,
          physics: ClampingScrollPhysics(), // Changed from BouncingScrollPhysics for more consistent behavior
          child: Padding(
            padding: EdgeInsets.only(
              bottom: bottomPadding > 0 ? 100 : 20, // Increased bottom padding
              top: 16,
            ),
            child: controller.currentScreen.value == 0
                ? _buildAiChat(scale, primaryColor)
                : _buildExpertChat(scale, primaryColor, secondaryColor),
          ),
        ),
      );
    });
  }

  Widget _buildAiChat(ScalingUtility scale, Color primaryColor) {
    return Obx(() {
      if (controller.aiChatModelStatus.value.isLoading) {
        return _buildLoadingIndicator(primaryColor);
      }

      if (controller.aiChatModel?.message?.isEmpty ?? true) {
        return _buildEmptyAiState(scale, primaryColor);
      }

      return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildAiMessageBubble(
            message: controller.aiChatModel?.data?.aiResponse ?? '',
            time: DateTime.now().toString(),
            primaryColor: primaryColor,
          ),
        ],
      );
    });
  }

  Widget _buildExpertChat(ScalingUtility scale, Color primaryColor, Color secondaryColor) {
    return Obx(() {
      if (controller.userMessageModelStatus.value.isLoading) {
        return _buildLoadingIndicator(primaryColor);
      }

      if (controller.userMessageModel?.messages?.isEmpty ?? true) {
        return _buildEmptyExpertState(scale, primaryColor);
      }

      return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          for (var message in controller.userMessageModel!.messages!.reversed)
            _buildMessageBubble(
              message: message,
              isAi: message.sentByUser == 0, // This should match your data model
              primaryColor: primaryColor,
              secondaryColor: secondaryColor,
            ),
        ],
      );
    });
  }

  Widget _buildMessageBubble({
    required Messages message,
    required bool isAi,
    required Color primaryColor,
    required Color secondaryColor,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: isAi ? MainAxisAlignment.start : MainAxisAlignment.end,
        children: [
          if (isAi) ...[
            CircleAvatar(
              backgroundColor: primaryColor.withOpacity(0.2),
              child: Icon(
                isAi ? Icons.auto_awesome : Icons.person,
                color: primaryColor,
              ),
            ),
            SizedBox(width: 8),
          ],
          Flexible(
            child: Container(
              constraints: BoxConstraints(
                maxWidth: MediaQuery.of(Get.context!).size.width * 0.8,
              ),
              decoration: BoxDecoration(
                gradient: isAi
                    ? LinearGradient(
                        colors: [Color(0xFFF5F5F5), Color(0xFFEAEAEA)],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      )
                    : LinearGradient(
                        colors: [primaryColor, secondaryColor],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(isAi ? 0 : 12),
                  topRight: Radius.circular(isAi ? 12 : 0),
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
                        color: isAi ? Colors.black : Colors.white,
                        fontSize: 14,
                      ),
                    ),
                  if (message.files != null) _buildFilePreview(message, isAi),
                  SizedBox(height: 4),
                  Text(
                    _formatTime(message.createdAt ?? ''),
                    style: TextStyle(
                      color: isAi ? Colors.grey[600] : Colors.white70,
                      fontSize: 10,
                    ),
                  ),
                ],
              ),
            ),
          ),
          if (!isAi) SizedBox(width: 8),
        ],
      ),
    );
  }

  Widget _buildAiMessageBubble({
    required String message,
    required String time,
    required Color primaryColor,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          CircleAvatar(
            backgroundColor: primaryColor.withOpacity(0.2),
            child: Icon(Icons.auto_awesome, color: primaryColor),
          ),
          SizedBox(width: 8),
          Flexible(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFFF5F5F5), Color(0xFFEAEAEA)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(0),
                  topRight: Radius.circular(12),
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
                  Text(
                    message,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    _formatTime(time),
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 10,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilePreview(Messages message, bool isAi) {
    final isImage = message.fileUrl?.endsWith('.png') == true ||
        message.fileUrl?.endsWith('.jpg') == true ||
        message.fileUrl?.endsWith('.jpeg') == true;

    return GestureDetector(
      onTap: () => _showFilePreview(message.fileUrl!, isImage),
      child: Container(
        margin: EdgeInsets.only(top: 8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: isAi ? Colors.grey[300]! : Colors.white.withOpacity(0.3)),
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
                              ? loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes!
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
                    Icon(Icons.insert_drive_file, size: 24, color: isAi ? Colors.grey[600] : Colors.white),
                    SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        message.fileUrl!.split('/').last,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: isAi ? Colors.black : Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
      ),
    );
  }

  Widget _buildInputArea(ScalingUtility scale, double bottomPadding, Color primaryColor) {
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
              _buildFileAttachment(scale, primaryColor),
              SizedBox(height: 8),
              _buildTextInput(scale, primaryColor),
            ],
          );
        }
        return _buildTextInput(scale, primaryColor);
      }),
    );
  }

  Widget _buildTextInput(ScalingUtility scale, Color primaryColor) {
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
                  primaryColor,
                  primaryColor.withOpacity(0.8),
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
              onChanged: controller.onTextChanged,
              decoration: InputDecoration(
                hintText:
                    controller.currentScreen.value == 0 ? 'Ask AI anything...' : 'Message the expert...',
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
                color: primaryColor,
              ),
            );
          }

          if (controller.isSendButtonVisible.value || controller.selectedFile.value != null) {
            return InkWell(
              onTap: () {
                if (controller.chatTextController.text.isNotEmpty || controller.selectedFile.value != null) {
                  if (controller.currentScreen.value == 0) {
                    controller.newSearchRequest();
                  } else {
                    controller.sendMessage();
                  }
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
                      primaryColor,
                      primaryColor.withOpacity(0.8),
                    ],
                  ),
                ),
                child: Icon(Icons.send, color: Colors.white),
              ),
            );
          }

          return InkWell(
            onTap: controller.onStarClicked,
            child: Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.grey[200],
              ),
              child: Icon(Icons.auto_awesome, color: Colors.grey[600]),
            ),
          );
        }),
      ],
    );
  }

  Widget _buildFileAttachment(ScalingUtility scale, Color primaryColor) {
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
                  color: primaryColor,
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

  Widget _buildEmptyAiState(ScalingUtility scale, Color primaryColor) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(16),
      child: Column(
        children: [
          SizedBox(height: scale.getScaledHeight(40)),
          Center(
            child: Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                  colors: [
                    primaryColor.withOpacity(0.2),
                    primaryColor.withOpacity(0.1),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: Center(
                child: Icon(
                  Icons.auto_awesome,
                  size: 60,
                  color: primaryColor,
                ),
              ),
            ),
          ),
          SizedBox(height: 16),
          Text(
            'Hi there!',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: 8),
          Text(
            'I\'m your AI research assistant. Ask me anything about your research topics and I\'ll help you find the best resources and suggestions.',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey[600],
            ),
          ),
          SizedBox(height: 24),
          _buildAiSuggestions(scale, primaryColor),
        ],
      ),
    );
  }

  Widget _buildEmptyExpertState(ScalingUtility scale, Color primaryColor) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(16),
      child: Column(
        children: [
          SizedBox(height: scale.getScaledHeight(40)),
          Center(
            child: Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                  colors: [
                    primaryColor.withOpacity(0.2),
                    primaryColor.withOpacity(0.1),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: Center(
                child: Icon(
                  Icons.person,
                  size: 60,
                  color: primaryColor,
                ),
              ),
            ),
          ),
          SizedBox(height: 16),
          Text(
            'Connect with an Expert',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: 8),
          Text(
            'Our subject matter experts are ready to help you with your research questions. Start a conversation and get personalized guidance.',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey[600],
            ),
          ),
          SizedBox(height: 24),
          Container(
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 8,
                  offset: Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    Icon(Icons.lightbulb_outline, color: primaryColor),
                    SizedBox(width: 8),
                    Text(
                      'Quick Tips',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 12),
                _buildTipItem(
                  icon: Icons.description,
                  title: 'Share your research documents',
                  subtitle: 'Upload PDFs or images for expert review',
                ),
                _buildTipItem(
                  icon: Icons.schedule,
                  title: 'Fast responses',
                  subtitle: 'Our experts typically reply within 1 hour',
                ),
                _buildTipItem(
                  icon: Icons.verified,
                  title: 'Verified experts',
                  subtitle: 'All specialists are vetted professionals',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTipItem({
    required IconData icon,
    required String title,
    required String subtitle,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 20, color: Colors.grey[600]),
          SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: 2),
                Text(
                  subtitle,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAiSuggestions(ScalingUtility scale, Color primaryColor) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 8,
            offset: Offset(0, 4),
          ),
        ],
        border: Border.all(
          color: primaryColor.withOpacity(0.2),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.auto_awesome, color: primaryColor, size: 20),
              SizedBox(width: 8),
              Text(
                'AI Suggestions',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),
          SizedBox(height: 12),
          Text(
            'Try asking me about:',
            style: TextStyle(
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: 8),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              _buildSuggestionChip(
                text: 'Research paper topics',
                onTap: () => _setSuggestion('Suggest some research paper topics in AI'),
                primaryColor: primaryColor,
              ),
              _buildSuggestionChip(
                text: 'Literature review',
                onTap: () => _setSuggestion('Help me with a literature review on machine learning'),
                primaryColor: primaryColor,
              ),
              _buildSuggestionChip(
                text: 'Methodology',
                onTap: () => _setSuggestion('What methodology should I use for my study?'),
                primaryColor: primaryColor,
              ),
              _buildSuggestionChip(
                text: 'Data analysis',
                onTap: () => _setSuggestion('How should I analyze my research data?'),
                primaryColor: primaryColor,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSuggestionChip({
    required String text,
    required VoidCallback onTap,
    required Color primaryColor,
  }) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: primaryColor.withOpacity(0.1),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          text,
          style: TextStyle(
            color: primaryColor,
            fontSize: 12,
          ),
        ),
      ),
    );
  }

  Widget _buildLoadingIndicator(Color primaryColor) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(
            color: primaryColor,
          ),
          SizedBox(height: 16),
          Text(
            'Loading conversation...',
            style: TextStyle(color: Colors.grey[600]),
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
                backgroundColor: ColorConstants.primaryColor,
              ),
              child: Text('Download File'),
            ),
          ],
        ),
      ),
    );
  }

  void _showChatModeInfo() {
    Get.dialog(
      AlertDialog(
        title: Text(
          controller.currentScreen.value == 0 ? 'AI Assistant Mode' : 'Live Expert Mode',
          style: TextStyle(color: ColorConstants.primaryColor),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              controller.currentScreen.value == 0
                  ? 'The AI Assistant can help with:'
                  : 'Live Experts can help with:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            ...(controller.currentScreen.value == 0
                ? [
                    _buildInfoItem('• Quick research suggestions'),
                    _buildInfoItem('• Literature review assistance'),
                    _buildInfoItem('• Methodology recommendations'),
                    _buildInfoItem('• 24/7 availability'),
                  ]
                : [
                    _buildInfoItem('• In-depth research guidance'),
                    _buildInfoItem('• Paper review and feedback'),
                    _buildInfoItem('• Personalized recommendations'),
                    _buildInfoItem('• Typically replies within 1 hour'),
                  ]),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: Text('OK'),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoItem(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Text(text),
    );
  }

  void _setSuggestion(String text) {
    controller.chatTextController.text = text;
    controller.onTextChanged(text);
    _focusNode.requestFocus();
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
