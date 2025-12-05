/*import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:governments_complaints/core/constant/class/app_color.dart';
import 'package:governments_complaints/core/constant/class/app_strings.dart';
import 'package:governments_complaints/features/complaint/presentation/screens/add_complaint_screen.dart';
import 'package:governments_complaints/features/home/presentation/screens/home_page_screen.dart';
import 'package:governments_complaints/features/nav_bar/presentation/controller/home_controller.dart';
import 'package:governments_complaints/features/notification/presentation/screens/notification_screen.dart';

import 'package:governments_complaints/features/profile/presentation/screens/profile_screens.dart';
import 'package:governments_complaints/features/settings/presentation/screens/setting_screen.dart';


class NavBarScreen extends GetView<HomeController> {

  final List<Widget> pages = [
    ProfileScreens(),
    SettingScreen(),
    HomePage(),
    NotificationScreen(),
    AddComplaintScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Scaffold(
          body: Obx(() => pages[controller.selectedIndex.value]),

          bottomNavigationBar: Obx(() {
            return BottomAppBar(
              height: 60,
              padding: const EdgeInsets.symmetric(horizontal: 3),
              child: BottomNavigationBar(
                selectedItemColor: AppColor.primaryColor,
                unselectedItemColor: AppColor.grey,
                type: BottomNavigationBarType.fixed,
                selectedFontSize: 10,
                unselectedFontSize: 10,
                currentIndex: controller.selectedIndex.value,
                onTap: controller.changeTab,
                items: const [
                  BottomNavigationBarItem(
                    icon: Icon(Icons.person),
                    label: 'الملف الشخصي',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.settings),
                    label: 'الإعدادات',
                  ),
                  BottomNavigationBarItem(
                    icon: SizedBox.shrink(),
                    label: '',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.notifications),
                    label: 'الإشعارات',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.add),
                    label: 'إضافة شكوى',
                  ),
                ],
              ),
            );
          }),
        ),

        Positioned(
          bottom: 25,
          left: MediaQuery.of(context).size.width / 2 - 29,
          child: GestureDetector(
            onTap: () => controller.changeTab(2), // تغيير إلى الصفحة الرئيسية
            child: Container(
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: AppColor.primaryColor,
                shape: BoxShape.circle,
                border: Border.all(color: Colors.white70, width: 3),
              ),
              child: const Icon(Icons.home, color: AppColor.white),
            ),
          ),
        ),
      ],
    );
  }
}*/