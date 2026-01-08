import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:governments_complaints/core/constant/class/app_asset.dart';
import 'package:governments_complaints/core/constant/class/app_color.dart';
import 'package:governments_complaints/core/routes/app_route.dart';

import '../../../../core/network/token_storage.dart';


class Splashscreen extends StatefulWidget {
  const Splashscreen({super.key});

  @override
  State<Splashscreen> createState() => _SplashscreenState();
}

class _SplashscreenState extends State<Splashscreen> {
   @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 3), () async{

        final isLogged = await TokenStorage.isLoggedIn();
        if (isLogged) {
          Get.offAllNamed(Routes.homepage);
        }
        else if (!isLogged) {
          Get.offAllNamed(Routes.loginScreen);
        }

    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:  Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              AppColor.primaryColor,           
            // const Color.fromARGB(255, 38, 105, 40)  ,
             const Color.fromARGB(255, 100, 142, 191), 
             AppColor.secondaryColor      
            ],
          ),
          
        ),
        height: double.infinity,
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
       children: [
        SizedBox(height: 100),
        Image.asset(AppAsset.splash),
        SizedBox(height: 40),
        Text("منصة بلاغ",style: TextStyle(color: AppColor.secondaryColor,
        fontWeight: FontWeight.bold,
        fontSize: 50),),
        SizedBox(height: 180),
       Align(
        alignment: AlignmentGeometry.bottomRight,
         child: Text("الجمهورية العربية السورية ",style: TextStyle(color: AppColor.primaryColor,fontSize: 25),)
       )
       ],
            ),
      ),
    );
  }
}