class ApiEndPoints {
  static const String baseUrl = "https://25cdc00935d3.ngrok-free.app";

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
      static const String getAllProduct="$baseUrl/products";
        static const String deleteProduct="$baseUrl/products";



}
