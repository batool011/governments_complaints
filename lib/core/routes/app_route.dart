import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:governments_complaints/features/nav_bar/presentation/binding/home_binding.dart';
import 'package:governments_complaints/features/nav_bar/presentation/screens/nav_bar_screen.dart';

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
  static const home = '/home';

  //complaint
  static const addcomplaintScreen='/addcomplaintScreen';
  static const ComplaintsScreen='/complaintScreen';
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
    page: ()=>const AddComplaintScreen(),
    binding: ComplaintBinding()
    ),
    GetPage(name: Routes.home,
        page: ()=> NavBarScreen(),
        binding: HomeBinding()
    ),
  ];
}
