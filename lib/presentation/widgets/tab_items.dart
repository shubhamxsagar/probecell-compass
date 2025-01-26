import 'package:flutter/material.dart';
import 'package:probcell_solutions/core/theme/app_style.dart';

class TabItem extends StatelessWidget {
  final String title;

  const TabItem({required this.title, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Center(
        child: Text(
          title,
          overflow: TextOverflow.ellipsis,
          style: AppStyle.textStylepoppins600black14,
        ),
      ),
    );
  }
}
