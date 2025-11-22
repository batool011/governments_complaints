// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:homy/core/utils/customp_app_bar.dart';
// import 'package:shimmer/shimmer.dart';

// class CustomCachedNetworkImage extends StatelessWidget {
//   const CustomCachedNetworkImage({
//     super.key,
//     required this.imageUrl,
//     this.fit,
//   });
//   final String imageUrl;
//   final BoxFit? fit;
//   @override
//   Widget build(BuildContext context) {
//     return CachedNetworkImage(
//       imageUrl: imageUrl,
//       fit: fit,
//       progressIndicatorBuilder: (context, url, downloadProgress) =>
//     Shimmer.fromColors(
//       period: Duration(seconds: 3),
//       baseColor: Colors.grey[850]!,
//       highlightColor: Colors.grey[800]!,
//       child: Container(
//         height: 60.h,
//         width: 60.w,
//         decoration: BoxDecoration(
//           color: Colors.black
//         ),
//       ),
//     ),
//       errorWidget: (context, url, error) => const Icon(Icons.error),
//     );
//   }
// }
