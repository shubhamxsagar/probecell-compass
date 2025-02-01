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
    return Padding(
      padding: scale.getPadding(horizontal: 20, vertical: 10),
      child: Column(
        children: [
          AppBar(
            surfaceTintColor: ColorConstants.white,
              title: FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(
                  'PROBECELL COMPASS',
                  style: AppStyle.textStylepoppins600blackLight20,
                ),
              ),
              leadingWidth: scale.getScaledWidth(60),
              leading: Image.asset(ImageConstant.logo),
              backgroundColor: ColorConstants.white,
            ),
          Expanded(
            child: ListView.builder(
              shrinkWrap: true,
              // padding: EdgeInsets.all(16),
              itemCount: controller.services.length,
              itemBuilder: (context, index) {
                final service = controller.services[index];
                  
                return Obx(() {
                  final isExpanded = controller.expandedIndex.value == index;
                  
                  return Card(
                    color: Colors.white,
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    margin: EdgeInsets.symmetric(vertical: 8),
                    child: ExpansionTile(
                      tilePadding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      title: Text(
                        service['title'] as String,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: ColorConstants.secondaryColor,
                        ),
                      ),
                      trailing: Icon(
                        isExpanded ? Icons.expand_less : Icons.expand_more,
                        color: ColorConstants.secondaryColor,
                      ),
                      initiallyExpanded: isExpanded,
                      onExpansionChanged: (expanded) {
                        if (expanded) {
                          controller.expandedIndex.value = index;
                        } else {
                          controller.expandedIndex.value = -1;
                        }
                      },
                      children: (service['features'] as List).map((feature) {
                        return Container(
                          margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                          padding: EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: Colors.grey[100],
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                feature['feature'] as String,
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black87,
                                ),
                              ),
                              SizedBox(height: 8),
                              Row(
                                children: [
                                  Icon(Icons.attach_money, size: 16, color: Colors.green),
                                  SizedBox(width: 4),
                                  Text(
                                    'Fees: ${feature['fees']}',
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.green,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 4),
                              Row(
                                children: [
                                  Icon(Icons.access_time, size: 16, color: Colors.orange),
                                  SizedBox(width: 4),
                                  Text(
                                    'Time: ${feature['time']}',
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.orange,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        );
                      }).toList(),
                    ),
                  );
                });
              },
            ),
          ),
        ],
      ),
    );
  }
}
