import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:governments_complaints/core/constant/class/app_color.dart';
import 'package:governments_complaints/core/constant/class/app_strings.dart';
import 'package:governments_complaints/features/nav_bar/presentation/controller/home_controller.dart';


class NavBarScreen extends GetView<HomeController> {
  final List<Widget> pages = [
    Container(color: Colors.green),
    Container(color: Colors.pink),
    Container(color: Colors.yellow,),
     Container(color: Colors.orange,),
      Container(color: Colors.purpleAccent,)
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
                    label: 'Profile',
                  ),
                    BottomNavigationBarItem(
                    icon: Icon(Icons.settings),
                    label: 'Setting',
                  ),
                  BottomNavigationBarItem(
                    icon: SizedBox.shrink(),
                    label: '',
                  ),
                   BottomNavigationBarItem(
                    icon: Icon(Icons.person),
                    label: 'Notification',
                  ),
                    BottomNavigationBarItem(
                    icon: Icon(Icons.add),
                    label: 'Add Complaints',
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
            onTap: () => controller.changeTab(1),
            child: Container(
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: AppColor.primaryColor,
                shape: BoxShape.circle,
                border: Border.all(color: Colors.white70, width: 3),
              ),
              child: const Icon(Icons.home,color: AppColor.white,),
            ),
          ),
        ),
      ],
    );
  }
}
