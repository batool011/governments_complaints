import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:governments_complaints/core/constant/class/app_asset.dart';
import 'package:governments_complaints/core/constant/class/app_color.dart';
import 'package:governments_complaints/core/constant/class/app_strings.dart';
import 'package:governments_complaints/core/constant/function/valid.dart';
import 'package:governments_complaints/core/utils/custom_button.dart';
import 'package:governments_complaints/features/auth/presentation/controller/Login_controller.dart';
import 'package:governments_complaints/features/auth/presentation/widget/custom_label_text_field.dart';
import 'package:governments_complaints/features/auth/presentation/widget/custom_text_field.dart';
import 'package:logger/logger.dart';

import '../../../../core/routes/app_route.dart';

class LoginScreen extends GetView<LoginController> {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var logger = Logger(
      printer: PrettyPrinter(
         dateTimeFormat: DateTimeFormat.dateAndTime,
         stackTraceBeginIndex: 5
      ),
    );
    return Scaffold(
      //backgroundColor: AppColor.secondaryColor,
      body: SafeArea(
        child: Stack(
          children: [
            Positioned.fill(
              child: Image.asset(
                AppAsset.vector,
                fit: BoxFit.cover,
                color: AppColor.primaryColor,
                colorBlendMode: BlendMode.srcIn, // اختياري
              ),
            ),

            SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Icon(Icons.arrow_back_ios),
                  const SizedBox(height: 17),
                   Center(
                    child: Text(
                      AppStrings.email.tr,
                      style:const TextStyle(
                        fontSize: 42,
                        fontWeight: FontWeight.bold,
                        color: AppColor.primaryColor,
                        letterSpacing: 5,
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                   Text(
                    AppStrings.login.tr,
                    style:const TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: AppColor.baseFontColor,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    AppStrings.pleaseEnterYourDeatails.tr,
                    style: const TextStyle(
                      fontSize: 16,
                      color: AppColor.baseFontColor,
                    ),
                  ),
                  const SizedBox(height: 60),
                  Form(
                    key: controller.formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomLabelTextField(
                          text: AppStrings.email.tr,

                        ),
                        CustomTextField(
                          controller: controller.emailController,
                          prifixIcon: Icons.email,
                          hintText: "  XYZ123@gmail.com",

                        ),
                       CustomLabelTextField(
                          text: AppStrings.password.tr,
                        ),
                        Obx(
                          () => CustomTextField(
                            hintText: " xxxxxxxx",
                            controller: controller.passwordController,
                            prifixIcon: Icons.password,
                          obscureText: controller.isPasswordHidden.value,

                            onTapIcon: () => controller
                                .togglePasswordVisibility(),
                            suffixIcon: controller.isPasswordHidden.value
                                ? Icons.visibility_off
                                : Icons.visibility,
                            validator: (value) =>
                                validInput(value, 3, 6, "password"),
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.symmetric(vertical: 30),
                          child: Row(
                            children: [
                              SizedBox(width: 6),
                            ],
                          ),
                        ),
                        const SizedBox(height: 10),
                      Obx((){
                        final disabled = controller.isBlocked.value || controller.isLoading.value;

                        return
                        controller.isLoading.value ? Center(child: const CircularProgressIndicator(color: AppColor.primaryColor,)):
                        CustomButton(
                          // onPressed: () {
                          //   if (controller.formKey.currentState!.validate()) {
                          //     controller.login();
                          //
                          //   }
                          //
                          // }
                            text: disabled
                            ? "حاول بعد ${controller.retryAfterSeconds.value}s"
                            : AppStrings.login.tr,
                          onPressed: disabled
                              ? (){}
                              : () {
                            if (controller.formKey.currentState!.validate()) {
                              controller.login();
                            }
                          },
                        );
                      }),
                      SizedBox(height: 30,),
                      Row(
                        children: [
                          Text("don't have an account ? "),
                          GestureDetector(onTap: (){Get.toNamed(Routes.registerScreen);},child: Text("Register"),)
                        ],
                      )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
