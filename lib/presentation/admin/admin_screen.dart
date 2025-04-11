import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:probcell_solutions/core/constants/color_constant.dart';
import 'package:probcell_solutions/core/services/auth_service.dart';
import 'package:probcell_solutions/core/theme/app_style.dart';
import 'package:probcell_solutions/core/utils/scaling_utils.dart';
import 'package:probcell_solutions/presentation/admin/admin_chat_screen.dart';
import 'package:probcell_solutions/presentation/admin/admin_controller.dart';
import 'package:probcell_solutions/presentation/admin/admin_get_all_message_model.dart';
import 'package:shimmer/shimmer.dart';
import 'package:iconsax/iconsax.dart';
import 'package:badges/badges.dart' as badges;

class AdminScreen extends GetView<AdminController> {
  final ScrollController _scrollController = ScrollController();
  final _searchController = TextEditingController();
  final RxString _searchQuery = ''.obs;

  @override
  Widget build(BuildContext context) {
    ScalingUtility scale = ScalingUtility(context: context)..setCurrentDeviceSize();

    return Scaffold(
      backgroundColor: ColorConstants.white,
      body: SafeArea(
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 500),
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
              _buildAppBar(scale),
              // _buildStatsOverview(scale),
              Expanded(
                child: LiquidPullToRefresh(
                  onRefresh: () => controller.getAllMessages(),
                  color: ColorConstants.adminPrimaryColor,
                  springAnimationDurationInMilliseconds: 800,
                  animSpeedFactor: 2.0,
                  showChildOpacityTransition: false,
                  child: Obx(() {
                    if (controller.getAllUserStatus.value.isLoading) {
                      return _buildShimmerLoading(scale);
                    } else if (controller.getAllUserStatus.value.isSuccess) {
                      // controller.getDashboardStats();
                      return _buildContent(scale);
                    } else {
                      return _buildEmptyState(scale);
                    }
                  }),
                ),
              ),
            ],
          ),
        ),
      ),
      // floatingActionButton: _buildFloatingActionButton(),
    );
  }

 Widget _buildAppBar(ScalingUtility scale) {
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
          offset: const Offset(0, 4),
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
              // Back button (optional - remove if not needed)
              // IconButton(
              //   icon: const Icon(Iconsax.arrow_left, color: Colors.white),
              //   onPressed: () => Get.back(),
              // ),
              SizedBox(width: scale.getScaledWidth(20),),
              
              // Title
              Expanded(
                child: Text(
                  'Admin Dashboard',
                  style: AppStyle.textStylepoppins600black14.copyWith(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    shadows: [
                      const Shadow(
                        color: Colors.black26,
                        blurRadius: 4,
                        offset: Offset(1, 1),
                      ),
                    ],
                  ),
                ),
              ),
              
              // Refresh button (visible)
              IconButton(
                icon: const Icon(Iconsax.refresh, color: Colors.white),
                onPressed: () => controller.getAllMessages(),
                tooltip: 'Refresh',
              ),
              
              // Logout dropdown (discrete)
              PopupMenuButton<String>(
                icon: const Icon(Iconsax.user, color: Colors.white),
                offset: const Offset(0, 50),
                onSelected: (value) {
                  if (value == 'logout') {
                    _showLogoutConfirmation();
                  }
                },
                itemBuilder: (BuildContext context) => [
                  const PopupMenuItem<String>(
                    value: 'logout',
                    child: Row(
                      children: [
                        Icon(Iconsax.logout, size: 20),
                        SizedBox(width: 8),
                        Text('Logout'),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        
        // Search bar
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Container(
            height: 40,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Search users...',
                hintStyle: const TextStyle(color: Colors.white70),
                prefixIcon: const Icon(Iconsax.search_normal, color: Colors.white),
                border: InputBorder.none,
                contentPadding: const EdgeInsets.symmetric(vertical: 8),
                suffixIcon: _searchController.text.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Iconsax.close_circle, color: Colors.white70, size: 20),
                        onPressed: () {
                          _searchController.clear();
                          _searchQuery.value = '';
                          FocusScope.of(Get.context!).unfocus();
                        },
                      )
                    : null,
              ),
              style: const TextStyle(color: Colors.white),
              onChanged: (value) => _searchQuery.value = value.toLowerCase(),
            ),
          ),
        ),
      ],
    ),
  );
}

void _showLogoutConfirmation() {
  Get.dialog(
    AlertDialog(
      title: const Text('Confirm Logout'),
      content: const Text('Are you sure you want to logout?'),
      actions: [
        TextButton(
          onPressed: () => Get.back(),
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: () {
            Get.back();
            Get.find<AuthService>().handleLogOut();
            // controller.logout();
          },
          child: const Text(
            'Logout',
            style: TextStyle(color: Colors.red),
          ),
        ),
      ],
    ),
  );
}

  Widget _buildStatsOverview(ScalingUtility scale) {
    final stats = controller.getDashboardStats();
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        gradient: LinearGradient(
          colors: [
            ColorConstants.adminPrimaryColor.withOpacity(0.8),
            ColorConstants.adminSecondaryColor.withOpacity(0.8),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildStatItem(scale, Iconsax.message_text, 'Total Chats', stats.totalChats.toString()),
          _buildStatItem(scale, Iconsax.user, 'Active Users', stats.activeUsers.toString()),
          _buildStatItem(scale, Iconsax.message_question, 'Unread', stats.unreadMessages.toString()),
          _buildStatItem(scale, Iconsax.clock, 'Today', stats.todayMessages.toString()),
        ],
      ),
    );
  }

  Widget _buildStatItem(ScalingUtility scale, IconData icon, String title, String value) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.white.withOpacity(0.2),
          ),
          child: Icon(icon, color: Colors.white, size: 20),
        ),
        const SizedBox(height: 8),
        Text(
          value,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          title,
          style: TextStyle(
            color: Colors.white.withOpacity(0.9),
            fontSize: 12,
          ),
        ),
      ],
    );
  }

  Widget _buildContent(ScalingUtility scale) {
    return Obx(() {
      final data = controller.adminGetAllMessageModel?.data ?? {};
      final filteredKeys = data.keys.where((userId) {
        if (_searchQuery.value.isEmpty) return true;
        final user = data[userId]?.first.user;
        return user?.name?.toLowerCase().contains(_searchQuery.value) == true ||
            user?.email?.toLowerCase().contains(_searchQuery.value) == true ||
            user?.mobile?.toLowerCase().contains(_searchQuery.value) == true;
      }).toList();

      return Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Recent Conversations',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.grey,
                  ),
                ),
                Obx(() {
                  final unreadCount = controller.totalUnreadMessages.value;
                  if (unreadCount > 0) {
                    return Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: ColorConstants.adminPrimaryColor.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        '$unreadCount Unread',
                        style: TextStyle(
                          color: ColorConstants.adminPrimaryColor,
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    );
                  }
                  return const SizedBox();
                }),
              ],
            ),
          ),
          Expanded(
            child: filteredKeys.isEmpty
                ? _buildNoResultsFound()
                : ListView.builder(
                    controller: _scrollController,
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    itemCount: filteredKeys.length,
                    itemBuilder: (context, index) {
                      final userId = filteredKeys[index];
                      final messages = data[userId]!;
                      final latestMessage = messages.first;
                      final user = latestMessage.user;
                      final unreadCount = messages.where((m) => m.sentByUser == 1).length;

                      return _buildUserCard(
                        scale: scale,
                        user: user!,
                        latestMessage: latestMessage,
                        unreadCount: unreadCount,
                      );
                    },
                  ),
          ),
        ],
      );
    });
  }

  Widget _buildUserCard({
    required ScalingUtility scale,
    required User user,
    required Message latestMessage,
    required int unreadCount,
  }) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: InkWell(
        onTap: () {
          FocusManager.instance.primaryFocus?.unfocus();
          controller.userID.value = user.id.toString();
          controller.getUserMessages();
          Get.to(() => AdminChatScreen());
        },
        borderRadius: BorderRadius.circular(12),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            gradient: const LinearGradient(
              colors: [Colors.white, Color(0xFFF5F5F5)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          padding: const EdgeInsets.all(12),
          child: Row(
            children: [
              _buildAnimatedUserAvatar(user),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          child: Text(
                            user.name ?? 'Unknown User',
                            style: const TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 15,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ),
                        Text(
                          _formatTime(latestMessage.createdAt ?? ''),
                          style: TextStyle(
                            color: Colors.grey[500],
                            fontSize: 11,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        Icon(
                          latestMessage.sentByUser == 1 ? Iconsax.message : Iconsax.message_2,
                          size: 14,
                          color: latestMessage.sentByUser == 1
                              ? ColorConstants.adminPrimaryColor
                              : Colors.grey[500],
                        ),
                        const SizedBox(width: 4),
                        Expanded(
                          child: Text(
                            latestMessage.message ?? 'No message',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              color: Colors.grey[600],
                              fontSize: 13,
                            ),
                          ),
                        ),
                        if (latestMessage.fileUrl != null)
                          const Padding(
                            padding: EdgeInsets.only(left: 4),
                            child: Icon(
                              Iconsax.document,
                              size: 14,
                              color: Colors.grey,
                            ),
                          ),
                      ],
                    ),
                  ],
                ),
              ),
              if (unreadCount > 0)
                badges.Badge(
                  badgeStyle: badges.BadgeStyle(
                    badgeColor: ColorConstants.adminPrimaryColor,
                    padding: const EdgeInsets.all(5),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  badgeContent: Text(
                    unreadCount > 9 ? '9+' : unreadCount.toString(),
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  position: badges.BadgePosition.topEnd(top: -8, end: -8),
                  child: const SizedBox(width: 24, height: 24),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAnimatedUserAvatar(User user) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Obx(() {
          return AnimatedContainer(
            duration: const Duration(milliseconds: 500),
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: controller.isGradientActive.value
                  ? LinearGradient(
                      colors: [
                        ColorConstants.adminPrimaryColor,
                        ColorConstants.adminSecondaryColor,
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    )
                  : null,
              color: !controller.isGradientActive.value
                  ? ColorConstants.adminPrimaryColor.withOpacity(0.2)
                  : null,
            ),
          );
        }),
        Container(
          width: 44,
          height: 44,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.white,
            border: Border.all(
              color: Colors.white,
              width: 2,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 4,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: ClipOval(
            child: user.email != null
                ? Icon(Iconsax.user, color: ColorConstants.adminPrimaryColor)
                : const Icon(Iconsax.user, color: Colors.grey),
          ),
        ),
      ],
    );
  }

  Widget _buildShimmerLoading(ScalingUtility scale) {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: 6,
      itemBuilder: (context, index) {
        return Shimmer.fromColors(
          baseColor: Colors.grey[200]!,
          highlightColor: Colors.grey[100]!,
          child: Container(
            margin: const EdgeInsets.only(bottom: 12),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 6,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Row(
              children: [
                Container(
                  width: 48,
                  height: 48,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: double.infinity,
                        height: 16,
                        color: Colors.white,
                      ),
                      const SizedBox(height: 8),
                      Container(
                        width: double.infinity,
                        height: 12,
                        color: Colors.white,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildEmptyState(ScalingUtility scale) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Iconsax.messages,
            size: 80,
            color: Colors.grey,
          ),
          const SizedBox(height: 16),
          Text(
            'No conversations yet',
            style: TextStyle(
              fontSize: 18,
              color: Colors.grey[600],
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 40),
            child: Text(
              'When users start messaging, conversations will appear here.',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.grey,
              ),
            ),
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {
              FocusManager.instance.primaryFocus?.unfocus();
              controller.getAllMessages();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: ColorConstants.adminPrimaryColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            ),
            child: const Text(
              'Refresh',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNoResultsFound() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Iconsax.search_normal_1,
            size: 60,
            color: Colors.grey,
          ),
          const SizedBox(height: 16),
          Text(
            'No results found',
            style: TextStyle(
              fontSize: 18,
              color: Colors.grey[600],
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Try searching with different keywords',
            style: TextStyle(
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }

  // Widget _buildFloatingActionButton() {
  //   return FloatingActionButton(
  //     onPressed: () => _showNewChatDialog(),
  //     backgroundColor: ColorConstants.adminPrimaryColor,
  //     child: const Icon(Iconsax.message_add, color: Colors.white),
  //     elevation: 4,
  //   );
  // }

  void _showNewChatDialog() {
    Get.defaultDialog(
      title: 'Start New Chat',
      content: Column(
        children: [
          const Text('Select a user to start a new conversation'),
          const SizedBox(height: 16),
          Obx(() {
            if (controller.getAllUserStatus.value.isLoading) {
              return const CircularProgressIndicator();
            }
            final users = controller.adminGetAllMessageModel?.data?.keys
                    .map((key) => controller.adminGetAllMessageModel?.data?[key]?.first.user)
                    .whereType<User>()
                    .toList() ??
                [];

            return DropdownButtonFormField<User>(
              decoration: InputDecoration(
                labelText: 'Select User',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              items: users.map((user) {
                return DropdownMenuItem<User>(
                  value: user,
                  child: Text(user.name ?? 'Unknown User'),
                );
              }).toList(),
              onChanged: (user) {
                if (user != null) {
                  Get.back();
                  controller.userID.value = user.id.toString();
                  controller.getUserMessages();
                  Get.to(() => AdminChatScreen());
                }
              },
            );
          }),
        ],
      ),
      confirm: TextButton(
        onPressed: () => Get.back(),
        child: const Text('Cancel'),
      ),
    );
  }

  String _formatTime(String dateTime) {
    try {
      final DateTime parsedDate = DateTime.parse(dateTime);
      final now = DateTime.now();
      final today = DateTime(now.year, now.month, now.day);
      final yesterday = DateTime(now.year, now.month, now.day - 1);
      final messageDate = DateTime(parsedDate.year, parsedDate.month, parsedDate.day);

      if (messageDate == today) {
        return '${parsedDate.hour}:${parsedDate.minute.toString().padLeft(2, '0')}';
      } else if (messageDate == yesterday) {
        return 'Yesterday';
      } else {
        return '${parsedDate.day}/${parsedDate.month}';
      }
    } catch (e) {
      return dateTime;
    }
  }
}
