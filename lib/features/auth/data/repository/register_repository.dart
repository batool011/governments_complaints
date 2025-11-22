// import 'dart:convert';

// import 'package:dio/dio.dart';

// class LoginRepository {
//   Future<Either<String, LoginModel>> login(
//       {required String email, required String password, required String fcm_token}) async {
    
      
//       final response = await getIt<ApiConsumer>().post(
//           "${ApiEndPoints.baseUrl}/login",
//     data: {ApiKey.email :email,ApiKey.password:password,ApiKey.fcm_token:fcm_token});
//     print("===============================================");
//     print(response.statusCode);
//     print(response.body);
//     var data= jsonDecode(response.body);
//       if(response.statusCode ==200){
//         return Right(LoginModel.fromJson(data));
//       }
//     else{
//     final data = jsonDecode(response.body);
//       final message = data["message"] ?? "خطأ غير معروف";
//       return Left(message);
//     }
//     }
//   }

