import 'package:flutter/material.dart';
import 'package:governments_complaints/core/constant/class/app_color.dart';

class CustomLabelTextField extends StatelessWidget {
  const CustomLabelTextField({super.key, required this.text});
  final String text;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6, top: 12,left: 20),
      child: Text(
        text,
        style: const TextStyle(color: AppColor.primaryColor),
      ),
    );
  }
}
