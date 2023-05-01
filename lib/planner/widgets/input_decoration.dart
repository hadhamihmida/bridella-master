import 'package:flutter/material.dart';

import '../../app_core/services/constants.dart';

InputDecoration decoration({String? label, String? hint, Widget? sufIcon}) {
  return InputDecoration(
    filled: true,
    focusColor: kPrimaryLightColor,
    border: InputBorder.none,
    // labelText: label,
    labelStyle: const TextStyle(color: kPrimaryColor),
    contentPadding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
    hintText: hint,

    enabledBorder: InputBorder.none,
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: const BorderSide(color: kPrimaryColor),
      gapPadding: 10,
    ),
    // fillColor: kPrimaryLightColor,
    hintStyle: const TextStyle(fontSize: 12),
    floatingLabelBehavior: FloatingLabelBehavior.auto,
    suffixIcon: sufIcon,
  );
}
