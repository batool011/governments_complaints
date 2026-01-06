import 'package:dartz/dartz.dart';
import 'package:governments_complaints/core/network/api_end_point.dart';
import 'package:governments_complaints/core/network/dio_helper.dart';
import 'package:governments_complaints/core/network/exceptions.dart';
import 'package:governments_complaints/features/home/data/model/complaint_status_model.dart';

class ComplaintRepo {

Future <Either<AppException,List<ComplaintStatusModel>>>getStatus()async{
  final result=await DioHelper.getData(url: ApiEndPoints.getAllReports);
  return result.fold((l){
    return Left(l);
  },
  (r){
   
final List<dynamic>data=r.data['data'];
final status=data.map((item) {
          
            return ComplaintStatusModel.fromJson(item);

        }).toList();
        
        return Right(status);
    
  }
  );

}



}