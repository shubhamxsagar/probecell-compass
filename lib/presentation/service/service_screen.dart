import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:probcell_solutions/core/constants/color_constant.dart';
import 'package:probcell_solutions/core/constants/image_constant.dart';
import 'package:probcell_solutions/core/theme/app_style.dart';
import 'package:probcell_solutions/core/utils/scaling_utils.dart';
import 'package:probcell_solutions/presentation/service/service_controller.dart';

class ServiceScreen extends GetView<ServiceController> {
  const ServiceScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ScalingUtility scale = ScalingUtility(context: context)..setCurrentDeviceSize();
    return Scaffold(
      backgroundColor: ColorConstants.white,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: scale.getScaledHeight(180),
            floating: false,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              centerTitle: true,
              title: Text(
                'OUR SERVICES',
                style: AppStyle.textStylepoppins600white16.copyWith(
                  shadows: [
                    Shadow(
                      color: Colors.black.withOpacity(0.3),
                      blurRadius: 4,
                      offset: Offset(1, 1),
                    ),
                  ],
                ),
              ),
              background: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      ColorConstants.primaryColor,
                      ColorConstants.secondaryColor,
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: Center(
                  child: Image.asset(
                    ImageConstant.logo,
                    width: scale.getScaledWidth(80),
                    height: scale.getScaledHeight(80),
                  ),
                ),
              ),
            ),
            elevation: 10,
            backgroundColor: ColorConstants.primaryColor, // Add this line
            stretch: true, // Optional: makes the background stretch when overscrolled
          ),
          // SliverToBoxAdapter(
          //   child: Padding(
          //     padding: scale.getPadding(horizontal: 20, top: 20),
          //     child: Text(
          //       'Professional Services for Your Research Needs',
          //       style: AppStyle.textStylepoppins600black16.copyWith(
          //         fontSize: 18,
          //         color: ColorConstants.primaryColor,
          //       ),
          //     ),
          //   ),
          // ),
          SliverPadding(
              padding: scale.getPadding(all: 16),
              sliver: SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    final service = controller.services[index];
                    return _buildServiceCard(scale, service, index);
                  },
                  childCount: controller.services.length,
                ),
              )),
        ],
      ),
    );
  }

  Widget _buildServiceCard(ScalingUtility scale, Map<String, dynamic> service, int index) {
    return Obx(() {
      final isExpanded = controller.expandedIndex.value == index;
      return Padding(
        padding: scale.getPadding(vertical: 8),
        child: AnimatedContainer(
          duration: Duration(milliseconds: 300),
          curve: Curves.easeInOut,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            gradient: LinearGradient(
              colors: isExpanded
                  ? [
                      ColorConstants.primaryColor.withOpacity(0.1),
                      ColorConstants.secondaryColor.withOpacity(0.05),
                    ]
                  : [
                      Colors.white,
                      Colors.white,
                    ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.08),
                blurRadius: 12,
                offset: Offset(0, 4),
              ),
            ],
          ),
          child: Theme(
            data: Theme.of(Get.context!).copyWith(
              dividerColor: Colors.transparent,
            ),
            child: ExpansionTile(
              onExpansionChanged: (expanded) {
                controller.toggleExpansion(index);
                if (expanded) {
                  // Haptic feedback when expanding
                  Feedback.forTap(Get.context!);
                }
              },
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              collapsedShape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              tilePadding: scale.getPadding(horizontal: 16, vertical: 8),
              title: Row(
                children: [
                  // Number indicator circle
                  Container(
                    width: scale.getScaledWidth(28),
                    height: scale.getScaledHeight(28),
                    decoration: BoxDecoration(
                      color: isExpanded ? ColorConstants.primaryColor : Colors.grey[300],
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: Text(
                        '${index + 1}',
                        style: AppStyle.textStylepoppins600black16.copyWith(
                          color: isExpanded ? Colors.white : Colors.black,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ),
                  // SizedBox(width: scale.getScaledWidth(12)),
                  // AnimatedContainer(
                  //   duration: Duration(milliseconds: 300),
                  //   width: scale.getScaledWidth(40),
                  //   height: scale.getScaledHeight(40),
                  //   decoration: BoxDecoration(
                  //     color: isExpanded
                  //         ? ColorConstants.primaryColor.withOpacity(0.2)
                  //         : Colors.grey[100],
                  //     shape: BoxShape.circle,
                  //   ),
                  //   child: Center(
                  //     child: Image.asset(
                  //       ImageConstant.image,
                  //       width: scale.getScaledWidth(24),
                  //       color: isExpanded
                  //           ? ColorConstants.primaryColor
                  //           : Colors.grey[600],
                  //     ),
                  //   ),
                  // ),
                  SizedBox(width: scale.getScaledWidth(12)),
                  Expanded(
                    child: Text(
                      service['title']! as String,
                      style: AppStyle.textStylepoppins600black16.copyWith(
                        color: isExpanded ? ColorConstants.primaryColor : Colors.black,
                      ),
                    ),
                  ),
                ],
              ),
              trailing: AnimatedRotation(
                turns: isExpanded ? 0.5 : 0,
                duration: Duration(milliseconds: 300),
                child: Icon(
                  Icons.keyboard_arrow_down,
                  color: isExpanded ? ColorConstants.primaryColor : Colors.grey[600],
                ),
              ),
              children: [
                Padding(
                  padding: scale.getPadding(horizontal: 16, bottom: 16),
                  child: Column(
                    children: (service['features'] as List<Map<String, String>>)
                        .map((feature) => _buildFeatureItem(scale, feature))
                        .toList(),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }

  Widget _buildFeatureItem(ScalingUtility scale, Map<String, String> feature) {
    return Padding(
      padding: scale.getPadding(vertical: 8),
      child: Container(
        width: double.infinity,
        padding: scale.getPadding(all: 16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 8,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  Icons.check_circle,
                  color: ColorConstants.primaryColor,
                  size: 20,
                ),
                SizedBox(width: scale.getScaledWidth(8)),
                Expanded(
                  child: Text(
                    feature['feature']!,
                    style: AppStyle.textStylepoppins500black14,
                  ),
                ),
              ],
            ),
            SizedBox(height: scale.getScaledHeight(12)),
            Row(
              children: [
                Expanded(
                  flex: 1,
                  child: _buildDetailChip(
                    icon: Icons.currency_rupee,
                    text: feature['fees']!,
                    color: ColorConstants.primaryColor.withOpacity(0.1),
                  ),
                ),
                SizedBox(width: scale.getScaledWidth(8)),
                Expanded(
                  flex: 1,
                  child: _buildDetailChip(
                    icon: Icons.access_time,
                    text: feature['time']!,
                    color: ColorConstants.secondaryColor.withOpacity(0.1),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailChip({required IconData icon, required String text, required Color color}) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            size: 14,
            color: ColorConstants.primaryColor,
          ),
          SizedBox(width: 4),
          Expanded(
            child: Text(
              text,
              style: AppStyle.textStylepoppins500black14.copyWith(
                color: Colors.black87,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
