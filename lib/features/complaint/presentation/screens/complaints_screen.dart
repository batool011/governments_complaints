import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:governments_complaints/core/constant/class/app_color.dart';
import 'package:governments_complaints/core/routes/app_route.dart';
import 'package:governments_complaints/features/complaint/presentation/controller/compaint_controller.dart';

import 'package:governments_complaints/features/complaint/presentation/widgets/complaints_list_widget.dart';


class ComplaintsScreen extends GetView<ComplaintsController> {
  const ComplaintsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor:AppColor.secondaryColor,
      appBar: AppBar(
        backgroundColor: AppColor.primaryColor,
        centerTitle: true,
        title: const Text(
          "قائمة الشكاوى",
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh, color: Colors.white),
            onPressed: controller.refreshComplaints,
          ),
        ],
      ),
      body: const ComplaintsListWidget(),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColor.primaryColor,
        onPressed: () {
       Get.toNamed(Routes.addcomplaintScreen);
        },
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}