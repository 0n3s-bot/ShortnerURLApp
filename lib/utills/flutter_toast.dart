import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:fluttertoast/fluttertoast.dart' as my_toast;

class Toast {
  // Toast(LoginErrorResponse loginErrorResponse);

  static showMessage(
    String message, {
    Color? txtcolor,
    color,
    bool isError = false,
  }) {
    return Fluttertoast.showToast(
        timeInSecForIosWeb: 4,
        msg: message,
        toastLength: my_toast.Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,

        // timeInSecForIosWeb: 3,
        backgroundColor: color ?? (isError ? Colors.red : Colors.green),
        textColor: txtcolor ?? Colors.white,
        fontSize: 16);
  }
}
