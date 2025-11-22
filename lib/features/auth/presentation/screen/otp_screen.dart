import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:get/get.dart';
import 'package:governments_complaints/core/constant/class/app_color.dart';
import 'package:governments_complaints/core/constant/class/app_strings.dart';
import 'package:governments_complaints/core/routes/app_route.dart';
import 'package:governments_complaints/core/utils/custom_button.dart';
import 'package:governments_complaints/features/auth/presentation/controller/otp_controller.dart';

class OtpScreen extends GetView<OtpController> {
  const OtpScreen({super.key});

  @override
  Widget build(BuildContext context) {
   
    return Scaffold(
    
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
        
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 40),
               Text(
                AppStrings.enterYourVerficationCode.tr,
                style:const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 30),
        
  
              OtpTextField(
                numberOfFields: 6,
                focusedBorderColor: AppColor.primaryColor,
                showFieldAsBox: true,
                fieldWidth: 50,
                borderRadius: BorderRadius.circular(8),
                onCodeChanged: (String code) {
                  controller.otpCode.value = code;
                },
                onSubmit: (String verificationCode) {
                 controller.otpCode.value = verificationCode;
                },
              ),
        
              const SizedBox(height: 40),
              Obx(() => Text(
                    controller.otpCode.value.isEmpty
                        ? ''
                        : 'الرمز الحالي: ${controller.otpCode.value}',
                    style: const TextStyle(fontSize: 18),
                  )),
        
             CustomButton(onPressed: (){
              controller.checkOtpCode();
             }, text: AppStrings.confirm.tr,)
            ],
          ),
        ),
      ),
    );
  }
}
