import 'package:bridella/app_core/services/constants.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

void showSnackBar(BuildContext context, String text) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(text),
    ),
  );
}

void message(String m) => Fluttertoast.showToast(
    msg: m,
    gravity: ToastGravity.BOTTOM,
    backgroundColor: kPrimaryColor,
    // webBgColor: kPrimaryColor,

    timeInSecForIosWeb: 3,
    textColor: Colors.white,
    fontSize: 16.0);
