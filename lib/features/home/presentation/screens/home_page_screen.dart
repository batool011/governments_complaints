import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:governments_complaints/core/constant/class/app_color.dart';
import 'package:governments_complaints/features/home/presentation/widgets/build_app_bar.dart';
import 'package:governments_complaints/features/home/presentation/widgets/build_quick_action_card.dart';
import 'package:governments_complaints/features/home/presentation/widgets/build_stats_section.dart';

import '../../../../core/routes/app_route.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      backgroundColor:Color.fromARGB(255, 247, 243, 231),
      body: SingleChildScrollView(
        child: Column(
          children: [
            BuildAppBar(),
            
            // الإحصائيات
            BuildStatsSection()
            ,
            // الخدمات السريعة
           BuildQuickActionCard(),
            
           
            
            const SizedBox(height: 20),
          ],
        ),
      ),
      
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
 
   

 



 