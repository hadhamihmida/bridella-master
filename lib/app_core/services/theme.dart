import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'constants.dart';

ThemeData bridellaTheme(bool dark) {
  return ThemeData(
    useMaterial3: true,
    scaffoldBackgroundColor: bridellaBGColor /* const Color(0xFFf2f2f2) */,
    fontFamily: "Muli",
    brightness: dark ? Brightness.dark : Brightness.light,
    appBarTheme: appBarTheme(),
    //iconTheme: IconThemeData(color: Color.fromARGB(255, 230, 84, 179)),
    textTheme: textTheme(),
    inputDecorationTheme: inputDecorationTheme(),
    visualDensity: VisualDensity.adaptivePlatformDensity,
  );
}

InputDecorationTheme inputDecorationTheme() {
  OutlineInputBorder outlineInputBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(28),
    borderSide: const BorderSide(color: kTextColor),
    gapPadding: 10,
  );
  return InputDecorationTheme(
    // If  you are using latest version of flutter then lable text and hint text shown like this
    // if you r using flutter less then 1.20.* then maybe this is not working properly
    // if we are define our floatingLabelBehavior in our theme then it's not applayed
    floatingLabelBehavior: FloatingLabelBehavior.always,
    contentPadding: const EdgeInsets.symmetric(horizontal: 42, vertical: 20),
    enabledBorder: outlineInputBorder,
    focusedBorder: outlineInputBorder,
    border: outlineInputBorder,
  );
}

TextTheme textTheme() {
  return const TextTheme(
    bodyText1: TextStyle(color: kTextColor),
    bodyText2: TextStyle(color: kTextColor),
  );
}

AppBarTheme appBarTheme() {
  return AppBarTheme(
   // color: Color.fromARGB(255, 255, 252, 253),
    elevation: 0, //0
   // iconTheme: const IconThemeData(color: Color.fromARGB(255, 243, 125, 164)),
    toolbarTextStyle: const TextTheme(
      headline6: TextStyle(color: kTextColor, fontSize: 18),
    ).bodyText2,
    titleTextStyle: const TextTheme(
      headline6: TextStyle(color: kTextColor, fontSize: 18),
    ).headline6,
    systemOverlayStyle: SystemUiOverlayStyle.dark,
  );
}
