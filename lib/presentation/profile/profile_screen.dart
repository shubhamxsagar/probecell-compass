import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:probcell_solutions/core/constants/color_constant.dart';
import 'package:probcell_solutions/core/services/auth_service.dart';
import 'package:probcell_solutions/core/utils/scaling_utils.dart';
import 'package:probcell_solutions/presentation/profile/profile_controller.dart';
import 'package:probcell_solutions/presentation/profile/user_info_model.dart';
import 'package:probcell_solutions/presentation/widgets/custom_text_button.dart';
import 'package:probcell_solutions/presentation/widgets/custom_text_field.dart';

class ProfileScreen extends GetView<ProfileController> {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ScalingUtility scale = ScalingUtility(context: context)..setCurrentDeviceSize();
    return Scaffold(
      backgroundColor: ColorConstants.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: ColorConstants.primaryColor),
          onPressed: () => Get.back(),
        ),
        title: Text(
          'My Profile',
          style: TextStyle(
            color: Colors.black,
            fontSize: 24,
            fontWeight: FontWeight.w700,
          ),
        ),
        centerTitle: true,
        // actions: [
        //   IconButton(
        //     icon: Icon(Icons.edit_outlined, color: ColorConstants.primaryColor),
        //     onPressed: () => _showEditOptions(context, scale),
        //   ),
        // ],
      ),
      body: Obx(() {
        if (controller.status.value.isLoading) {
          return Center(
            child: CircularProgressIndicator(
              color: ColorConstants.primaryColor,
              strokeWidth: 2,
            ),
          );
        }
        if (controller.status.value.isError) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.error_outline, size: 48, color: Colors.red[300]),
                SizedBox(height: 16),
                Text(
                  'Failed to load profile',
                  style: TextStyle(fontSize: 18, color: Colors.grey[600]),
                ),
                SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () => controller.getUserDetails(),
                  child: Text('Retry'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: ColorConstants.primaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  ),
                ),
              ],
            ),
          );
        }
        
        final userInfo = controller.userInfoModel!.userInfo!;
        return SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: scale.getScaledWidth(20)),
          child: Column(
            children: [
              SizedBox(height: scale.getScaledHeight(20)),
              _buildProfileCard(userInfo, scale),
              SizedBox(height: scale.getScaledHeight(30)),
              _buildInfoSection(userInfo, scale, context),
              SizedBox(height: scale.getScaledHeight(40)),
              _buildLogoutButton(scale),
              SizedBox(height: scale.getScaledHeight(40)),
            ],
          ),
        );
      }),
    );
  }

  Widget _buildProfileCard(UserInfo userInfo, ScalingUtility scale) {
    return Container(
      padding: EdgeInsets.all(scale.getScaledWidth(20)),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 16,
            offset: Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        children: [
          Stack(
            alignment: Alignment.bottomRight,
            children: [
              Container(
                width: scale.getScaledWidth(100),
                height: scale.getScaledWidth(100),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: ColorConstants.primaryColor.withOpacity(0.1),
                  border: Border.all(
                    color: ColorConstants.primaryColor.withOpacity(0.3),
                    width: 2,
                  ),
                ),
                child: Icon(
                  Icons.person,
                  size: scale.getScaledWidth(50),
                  color: ColorConstants.primaryColor,
                ),
              ),
            ],
          ),
          SizedBox(height: scale.getScaledHeight(16)),
          Text(
            userInfo.name!,
            style: TextStyle(
              fontSize: scale.getScaledWidth(22),
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: scale.getScaledHeight(4)),
          Text(
            userInfo.email!,
            style: TextStyle(
              fontSize: scale.getScaledWidth(14),
              color: Colors.grey[600],
            ),
          ),
          SizedBox(height: scale.getScaledHeight(16)),
          Divider(height: 1, color: Colors.grey[200]),
          
        ],
      ),
    );
  }

  Widget _buildProfileStatItem(ScalingUtility scale, String title, String value, IconData icon) {
    return Column(
      children: [
        Icon(icon, size: 20, color: ColorConstants.primaryColor),
        SizedBox(height: scale.getScaledHeight(8)),
        Text(
          value,
          style: TextStyle(
            fontSize: scale.getScaledWidth(16),
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: scale.getScaledHeight(4)),
        Text(
          title,
          style: TextStyle(
            fontSize: scale.getScaledWidth(12),
            color: Colors.grey[600],
          ),
        ),
      ],
    );
  }

  Widget _buildInfoSection(UserInfo userInfo, ScalingUtility scale, BuildContext context) {
    return Container(
      padding: EdgeInsets.all(scale.getScaledWidth(20)),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 16,
            offset: Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Personal Information',
            style: TextStyle(
              fontSize: scale.getScaledWidth(18),
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: scale.getScaledHeight(20)),
          _buildInfoTile(
            scale: scale,
            icon: Icons.person_outline,
            label: 'Full Name',
            value: userInfo.name!,
            onEdit: () => _showEditDialog(
              context, 
              'Full Name', 
              userInfo.name!, 
              (value) {
                controller.nameController.text = value;
                controller.changeUserInfo();
              },
            ),
          ),
          Divider(height: 1, color: Colors.grey[200]),
          _buildInfoTile(
            scale: scale,
            icon: Icons.phone_android_outlined,
            label: 'Mobile Number',
            value: userInfo.mobile!,
            onEdit: () => _showEditDialog(
              context, 
              'Mobile', 
              userInfo.mobile!, 
              (value) {
                controller.mobileController.text = value;
                controller.changeUserInfo();
              },
            ),
          ),
          Divider(height: 1, color: Colors.grey[200]),
          _buildInfoTile(
            scale: scale,
            icon: Icons.email_outlined,
            label: 'Email Address',
            value: userInfo.email!,
            onEdit: null, // Email typically shouldn't be editable here
          ),
        ],
      ),
    );
  }

  Widget _buildInfoTile({
    required ScalingUtility scale,
    required IconData icon,
    required String label,
    required String value,
    VoidCallback? onEdit,
  }) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: scale.getScaledHeight(12)),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: ColorConstants.primaryColor.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, size: 20, color: ColorConstants.primaryColor),
          ),
          SizedBox(width: scale.getScaledWidth(16)),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: TextStyle(
                    fontSize: scale.getScaledWidth(14),
                    color: Colors.grey[600],
                  ),
                ),
                SizedBox(height: scale.getScaledHeight(4)),
                Text(
                  value,
                  style: TextStyle(
                    fontSize: scale.getScaledWidth(16),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
          if (onEdit != null)
            IconButton(
              icon: Icon(Icons.edit_outlined, size: 20, color: Colors.grey[600]),
              onPressed: onEdit,
            ),
        ],
      ),
    );
  }

  Widget _buildLogoutButton(ScalingUtility scale) {
    return Container(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () => _showLogoutConfirmation(),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white,
          disabledBackgroundColor: Colors.red,
          padding: EdgeInsets.symmetric(vertical: scale.getScaledHeight(16)),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
            side: BorderSide(color: Colors.red.withOpacity(0.3)),
          ),
          elevation: 0,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.logout, size: 20, color: ColorConstants.primaryColor),
            SizedBox(width: scale.getScaledWidth(10)),
            Text(
              'Logout',
              style: TextStyle(
                color: ColorConstants.primaryColor,
                fontSize: scale.getScaledWidth(16),
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showEditDialog(BuildContext context, String label, String initialValue, Function(String) onSave) {
    final controller = TextEditingController(text: initialValue);
    Get.dialog(
      
      Dialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        child: Padding(
          padding: EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Edit $label',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 20),
              CustomTextField(
                hintText: label,
                textEditingController: controller,
              ),
              SizedBox(height: 24),

                  CustomTextButton(
                    buttonText: 'Save',
                    onTap: () {
                      onSave(controller.text);
                      Get.back();
                    },
                
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showLogoutConfirmation() {
    Get.dialog(
      Dialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        child: Padding(
          padding: EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.logout,
                size: 48,
                color: Colors.red[400],
              ),
              SizedBox(height: 16),
              Text(
                'Logout Confirmation',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 16),
              Text(
                'Are you sure you want to logout?',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey[900],
                ),
              ),
              SizedBox(height: 24),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () => Get.back(),
                      child: Text('Cancel', style: TextStyle(color: Colors.black)),
                      style: OutlinedButton.styleFrom(
                        backgroundColor: Colors.grey[300],
                        padding: EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        Get.back();
                        Get.find<AuthService>().handleLogOut();
                      },
                      child: Text('Logout', style: TextStyle(color: Colors.white)),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        padding: EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showEditOptions(BuildContext context, ScalingUtility scale) {
    Get.bottomSheet(
      Container(
        padding: EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Edit Profile',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 24),
            _buildEditOption(
              scale,
              icon: Icons.camera_alt_outlined,
              label: 'Change Profile Photo',
              onTap: () {
                Get.back();
                // Implement photo change functionality
              },
            ),
            _buildEditOption(
              scale,
              icon: Icons.lock_outline,
              label: 'Change Password',
              onTap: () {
                Get.back();
                // Navigate to change password screen
              },
            ),
            SizedBox(height: 16),
            OutlinedButton(
              onPressed: () => Get.back(),
              child: Text('Cancel'),
              style: OutlinedButton.styleFrom(
                backgroundColor: Colors.grey[600],
                padding: EdgeInsets.symmetric(vertical: 16),
                minimumSize: Size(double.infinity, 0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEditOption(ScalingUtility scale, {required IconData icon, required String label, required VoidCallback onTap}) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: Container(
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: ColorConstants.primaryColor.withOpacity(0.1),
          shape: BoxShape.circle,
        ),
        child: Icon(icon, color: ColorConstants.primaryColor),
      ),
      title: Text(
        label,
        style: TextStyle(
          fontSize: scale.getScaledWidth(16),
          fontWeight: FontWeight.w500,
        ),
      ),
      trailing: Icon(Icons.chevron_right, color: Colors.grey[400]),
      onTap: onTap,
    );
  }
}