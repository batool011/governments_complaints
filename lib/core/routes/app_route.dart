import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:governments_complaints/features/complaint/presentation/screens/complaints_screen.dart';
import 'package:governments_complaints/features/complaint/presentation/screens/detail_comlaint_screen.dart';
import 'package:governments_complaints/features/home/presentation/screens/home_page_screen.dart';
import 'package:governments_complaints/features/nav_bar/presentation/binding/home_binding.dart';
import 'package:governments_complaints/features/splash/presentation/screens/splashscreen.dart';


import '../../features/auth/presentation/binding/auth_binding.dart';
import '../../features/auth/presentation/screen/login_screen.dart';
import '../../features/auth/presentation/screen/otp_screen.dart';
import '../../features/auth/presentation/screen/register_screen.dart';
import '../../features/complaint/presentation/binding/complaint_binding.dart';
import '../../features/complaint/presentation/screens/add_complaint_screen.dart';


class Routes {
//auth
  static const otpScreen = '/otpScreen';
  static const registerScreen = '/registerScreen';
  static const loginScreen = '/loginScreen';
//home
  static const homepage = '/homepage';

  //complaint
  static const addcomplaintScreen='/addcomplaintScreen';
  static const ComplaintsScreen='/complaintScreen';
  static const detailScreen ='/detailScreen';

  //profile
  static const profile='profile';

  //splash
  static const Splashscreen='/splashScreen';

}

class AppRoute {
  static final routes = [
    GetPage(
      name: Routes.registerScreen,
      page: () => const RegisterScreen(),
      binding: AuthBinding(),
    ),
    GetPage(
      name: Routes.loginScreen,
      page: () => const LoginScreen(),
      binding: AuthBinding(),
    ),
    GetPage(
      name: Routes.otpScreen,
      page: () => const OtpScreen(),
      binding: AuthBinding(),
    ),
    GetPage(name: Routes.addcomplaintScreen, 
    page: ()=>const AddComplaintScreen(),
    binding: ComplaintBinding()
    ),
     GetPage(name: Routes.ComplaintsScreen, 
    page: ()=>const ComplaintsScreen(),
    binding: ComplaintBinding()
    ),
  //  GetPage(name: Routes.home,
   //     page: ()=> NavBarScreen(),
      //  binding: HomeBinding()
   // ),
   GetPage(name: Routes.homepage, 
    page: ()=>const HomePage(),
    binding: HomeBinding()
    ),

    GetPage(name: Routes.detailScreen,
        page: ()=>const DetailComplaintScreen(),
        binding: ComplaintBinding()
    ),
        GetPage(name: Routes.Splashscreen,
        page: ()=>const Splashscreen(),
    ),



  ];
}
