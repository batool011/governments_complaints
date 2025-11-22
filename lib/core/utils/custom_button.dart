import 'package:flutter/material.dart';

import '../constant/class/app_color.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({super.key,required this.onPressed, required this.text});
  final void Function() onPressed;
  final String text;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 140,vertical: 15),
        margin: const EdgeInsets.symmetric(horizontal: 5),
        decoration: BoxDecoration(
          color: AppColor.primaryColor,
          borderRadius: BorderRadius.circular(15)
        ),
        child: Text(text,style: TextStyle(color: AppColor.white,fontSize: 15,fontWeight: FontWeight.bold),),
      ),
    );
  }
}
