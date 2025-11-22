// import 'package:flutter/material.dart';
// import 'package:fluttertoast/fluttertoast.dart';

// void navigate(
//     {required BuildContext context, required String rout, dynamic args}) {
//   Navigator.pushNamed(context, rout, arguments: args);
// }

// void navigateReplacement(
//     {required BuildContext context, required String rout, dynamic args}) {
//   Navigator.pushReplacementNamed(context, rout, arguments: args);
// }

// void showToast({required String message, required ToastState toastState}) {
//   Fluttertoast.showToast(
//       msg: message,
//       toastLength: Toast.LENGTH_SHORT,
//       gravity: ToastGravity.CENTER,
//       timeInSecForIosWeb: 3,
//       backgroundColor: getState(toastState),
//       textColor: Colors.white,
//       fontSize: 16.0);
// }

// enum ToastState { success, error, warning }

// Color getState(ToastState toastState) {
//   switch (toastState) {
//     case ToastState.error:
//       return Colors.red;
//     case ToastState.success:
//       return Colors.green;
//     case ToastState.warning:
//       return Colors.orange;
//   }
// }
