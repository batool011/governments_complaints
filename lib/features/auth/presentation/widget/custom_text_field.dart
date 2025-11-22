import 'package:flutter/material.dart';
import 'package:governments_complaints/core/constant/class/app_color.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    required this.prifixIcon,
    this.suffixIcon,
    required this.controller,
     this.validator,
    this.obscureText,
    this.onTapIcon
  });
  final IconData? suffixIcon;
  final IconData prifixIcon;
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final  bool? obscureText;
  final void Function()? onTapIcon;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(30),
      ),
      child: TextFormField(
        validator: validator,
        controller: controller,
        obscureText: obscureText == null || obscureText == false ? false : true,
        decoration: InputDecoration(
          border: InputBorder.none,
          prefixIcon: Icon(
            prifixIcon,
            color: AppColor.primaryColor,
          ),
          suffixIcon: InkWell(
            onTap: onTapIcon,
            child: Icon(
              suffixIcon,
              color: AppColor.primaryColor,
            ),
          ),
          errorBorder: InputBorder.none,
        ),
        
      ),
    );
  }
}
