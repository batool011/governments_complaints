import 'package:flutter/material.dart';
import '../../../../core/constant/class/app_color.dart';

class CustomLabelTextField extends StatelessWidget {
  const CustomLabelTextField({super.key, required this.text});
  final String text;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6, top: 12),
      child: Text(
        text,
        style: TextStyle(color: AppColor.primaryColor),
      ),
    );
  }
}
