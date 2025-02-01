import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:probcell_solutions/core/constants/color_constant.dart';
import 'package:probcell_solutions/core/utils/scaling_utils.dart';
import 'package:probcell_solutions/presentation/profile/profile_controller.dart';

class ProfileScreen extends GetView<ProfileController> {
const ProfileScreen({ Key? key }) : super(key: key);

  @override
   Widget build(BuildContext context) {
    ScalingUtility scale = ScalingUtility(context: context)..setCurrentDeviceSize();
    return Scaffold(
      backgroundColor: ColorConstants.white,
      appBar: AppBar(
        backgroundColor: ColorConstants.white,
        surfaceTintColor: ColorConstants.white,
        title: Text('Profile'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Text(
            //   'Personal Data',
            //   style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            // ),
            Center(
              child: Stack(
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundImage: NetworkImage('https://via.placeholder.com/150'),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: GestureDetector(
                      onTap: () {
                        // Add your image update logic here
                      },
                      child: CircleAvatar(
                        radius: 15,
                        backgroundColor: Colors.blue,
                        child: Icon(
                          Icons.camera_alt,
                          color: Colors.white,
                          size: 15,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            _buildInfoRow('Full Name', 'Albert Stevano Bajefski',scale),
            _buildInfoRow('Date of birth', '19/06/1999',scale),
            _buildInfoRow('Gender', 'Male',scale),
            _buildInfoRow('Phone', '+1325-433-7656',scale),
            _buildInfoRow('Email', 'albertstevano@gmail.com',scale),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value, ScalingUtility scale) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '$label:',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: scale.getScaledHeight(10)),
            Container(
              padding: scale.getPadding(horizontal: 10, vertical: 10),
              width: scale.fullWidth,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              value,
              style: TextStyle(fontSize: 18),
            ),
          ),
        ],
      ),
    );
  }
}