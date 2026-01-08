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
    this.onTapIcon,
    this.hintText
  });
  final IconData? suffixIcon;
  final IconData prifixIcon;
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final  bool? obscureText;
  final void Function()? onTapIcon;
  final String ?hintText;
  @override
  Widget build(BuildContext context) {
    return Container(
      // height: 60,
      margin: EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(15),
           border: Border.all(color: AppColor.primaryColor,width: 1,style: BorderStyle.solid),
      ),
      child: TextFormField(
        
        validator: validator,
        controller: controller,
        obscureText: obscureText == null || obscureText == false ? false : true,
        decoration: InputDecoration(
          hintText: hintText,
          filled: true,
          fillColor: Colors.transparent,
       border: InputBorder.none,
          prefixIcon: Icon(
            prifixIcon,
            color: AppColor.iconColor,
          ),
          suffixIcon: InkWell(
            onTap: onTapIcon,
            child: Icon(
              suffixIcon,
              color: AppColor.iconColor,
            ),
          ),
          errorBorder: InputBorder.none,
        ),
        
      ),
    );
  }
}
