class ApiEndPoints {
  static const String baseUrl = "https://f0a7c147768e.ngrok-free.app";

  // Auth
  static const String login = "$baseUrl/api/auth/login";
  static const String register = "$baseUrl/api/user/register";
  static const String verify = "$baseUrl/api/user/auth/verify";

 //complaint
 static const String addComplaint="$baseUrl/api/user/complaint";
 static const String getAllComplaint="$baseUrl/api/user/complaint";

  //
    static const String getAllCompanies="$baseUrl/api/user/companies";


}
