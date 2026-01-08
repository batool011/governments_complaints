import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:governments_complaints/features/auth/presentation/controller/Login_controller.dart';

import '../constant/class/app_color.dart';

class CustomButton extends GetView<LoginController> {
  const CustomButton({super.key,required this.onPressed, required this.text});
  final void Function() onPressed;
  final String text;
  @override
  Widget build(BuildContext context) {
    final disabled = controller.isBlocked.value || controller.isLoading.value;

    return  Center(
      child: GestureDetector(
        onTap: onPressed,
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 30,vertical: 15),
          margin: const EdgeInsets.symmetric(horizontal: 10),
          decoration: BoxDecoration(
              color:disabled?AppColor.grey :AppColor.primaryColor,
              borderRadius: BorderRadius.circular(15)
          ),
          child: Center(child: Text(text,style: TextStyle(color: AppColor.white,fontSize: 15,fontWeight: FontWeight.bold),),),
        ),
      ),
    );
  }
}
