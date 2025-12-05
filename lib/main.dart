import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:governments_complaints/features/complaint/presentation/binding/complaint_binding.dart';

import 'core/notification/push_notification_services.dart';
import 'core/routes/app_route.dart';
import 'firebase_options.dart';
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await FirebaseMessagingService().initNotificationsSettings();
  //await GetStorage.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialBinding: ComplaintBinding(),
      debugShowCheckedModeBanner:  false,

      initialRoute: Routes.loginScreen,
      getPages: AppRoute.routes,      

    );
  }
}
