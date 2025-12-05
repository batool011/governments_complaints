import 'package:flutter/cupertino.dart';

import '../../../../core/constant/class/app_color.dart';

class CustomContainerDetail extends StatelessWidget {
  const CustomContainerDetail({super.key,required this.txt1, required this.txt2});
  final String txt1;
  final String txt2;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10,vertical: 20),
      margin: EdgeInsets.symmetric(horizontal: 10,vertical: 3),
      decoration: BoxDecoration(
          color: AppColor.primaryColor,
          borderRadius: BorderRadius.circular(25)
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text(txt1,style: TextStyle(color: AppColor.white,fontSize: 14,fontWeight: FontWeight.bold),),
          Text(txt2,style: TextStyle(color: AppColor.white,fontSize: 13,))
        ],
      ),
    );
  }
}
