import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../core/constant/class/app_color.dart';

class StatueCard extends StatelessWidget {
  const StatueCard({super.key, required this.status});
  final String status;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 3),
      decoration: BoxDecoration(
        color: getStatusColor(status),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        status,
        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
          fontWeight: FontWeight.w500,
          fontSize: 10,
          color: AppColor.white,
        ),
      ),
    );
  }
}

Color getStatusColor(String? status) {
  switch (status?.toLowerCase()) {
    case 'انتظار':
      return AppColor.orange;
    case 'canceled' ||'ملغي':
      return AppColor.red;
    case 'completed'||'مكتمل':
      return AppColor.green;
    default:
      return Colors.black;
  }
}
