class ApiEndPoints {
  static const String baseUrl = "http://10.41.92.10:8000";

  // Auth
  static const String login = "$baseUrl/api/auth/login";
  static const String register = "$baseUrl/api/user/register";
  static const String verify = "$baseUrl/api/user/auth/verify";

 //complaint
 static const String addComplaint="$baseUrl/api/user/complaint";
 static const String getAllComplaint="$baseUrl/api/user/complaint";
  static  String getComplaintDetail (int id)=>"$baseUrl/api/user/complaint/$id";


  static const String updateComplaint = '$baseUrl/api/user/complaint';

  //
    static const String getAllCompanies="$baseUrl/api/user/companies";


}
