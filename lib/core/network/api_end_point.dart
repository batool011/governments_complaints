class ApiEndPoints {
  static const String baseUrl = "https://66884f1dc9f7.ngrok-free.app";

  // Auth
  static const String login = "$baseUrl/api/auth/login";
  static const String register = "$baseUrl/api/user/register";
  static const String verify = "$baseUrl/api/user/auth/verify";
  static const String noti = "$baseUrl/api/auth/notifications";

 //complaint
 static const String addComplaint="$baseUrl/api/user/complaint";
 static const String getAllComplaint="$baseUrl/api/user/complaint";
  static  String getComplaintDetail (int id)=>"$baseUrl/api/user/complaint/$id";


  static const String updateComplaint = '$baseUrl/api/user/complaint';

  //
    static const String getAllCompanies="$baseUrl/api/user/companies";
     


//التقارير 
    static const String getAllReports="$baseUrl/api/user/complaint/report";
}
