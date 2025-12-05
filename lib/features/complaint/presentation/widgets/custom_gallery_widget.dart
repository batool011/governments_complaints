// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:governments_complaints/features/complaint/presentation/controller/compaint_controller.dart';
// import '../../../../core/constant/class/app_color.dart';
//
// class CustomGalleryWidget extends GetView<ComplaintsController> {
//   const CustomGalleryWidget({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Obx(() {
//       return Wrap(
//         spacing: 8,
//         runSpacing: 8,
//         children: [
//           if (controller.networkImages.isNotEmpty)
//             for (var image in controller.networkImages)
//               Stack(
//                 children: [
//                   ClipRRect(
//                     borderRadius: BorderRadius.circular(12),
//                     child: Container(
//                       width: 25,
//                       height: 25,
//                       decoration: BoxDecoration(
//                         border: Border.all(
//                           color: AppColor.primaryColor,
//                           width: 1.5,
//                         ),
//                         image: DecorationImage(
//                           image: NetworkImage(image.url!),
//                           fit: BoxFit.cover,
//                         ),
//                       ),
//                     ),
//                   ),
//                   Positioned(
//                     top: 4,
//                     right: 4,
//                     child: GestureDetector(
//                       onTap: () {
//                         controller.networkImages.remove(image);
//                      //   controller.deletedImages.add(image.id!);
//                       },
//                       child: Container(
//                         decoration: const BoxDecoration(
//                           color: AppColor.primaryColor,
//                           shape: BoxShape.circle,
//                         ),
//                         padding: const EdgeInsets.all(2),
//                         child: const Icon(
//                           Icons.close,
//                           size: 14,
//                           color: Colors.white,
//                         ),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//           // Display selected images
//           for (var image in controller.selectedImages)
//             Stack(
//               children: [
//                 ClipRRect(
//                   borderRadius: BorderRadius.circular(12),
//                   child: Container(
//                     width: 25,
//                     height: 25,
//                     decoration: BoxDecoration(
//                       border: Border.all(
//                         color: AppColor.primaryColor,
//                         width: 1.5,
//                       ),
//                       image: DecorationImage(
//                         image: FileImage(image),
//                         fit: BoxFit.cover,
//                       ),
//                     ),
//                   ),
//                 ),
//                 Positioned(
//                   top: 4,
//                   right: 4,
//                   child: GestureDetector(
//                     onTap: () => controller.removeImage(image),
//                     child: Container(
//                       decoration: const BoxDecoration(
//                         color: AppColor.primaryColor,
//                         shape: BoxShape.circle,
//                       ),
//                       padding: const EdgeInsets.all(2),
//                       child: const Icon(
//                         Icons.close,
//                         size: 14,
//                         color: Colors.white,
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//
//           // Add image container
//           GestureDetector(
//             onTap: controller.pickImages,
//             child: Container(
//               width: 25,
//               height: 25,
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(12),
//                 border: Border.all(color: AppColor.primaryColor),
//               ),
//               child: Center(),
//             ),
//           ),
//         ],
//       );
//     });
//   }
// }
