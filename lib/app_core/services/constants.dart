import 'package:bridella/app_core/services/size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

//const kPrimaryColor = Color(0xFFFF7643);
//const bridellaBGColor = Color(0xFFf2f2f2);
//0xffe6204c
const bridellaBGColor = Colors.white;
const kPrimaryColor = Color.fromARGB(255, 218, 49, 91);
const kPrimaryLightColor =
    Color.fromARGB(255, 255, 218, 226); // Color.fromARGB(255, 233, 181, 192);
const kPrimaryGradientColor = LinearGradient(
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
  colors: [
    Color(0xffe6204c),
    Color(0xfff4365c),
    Color(0xfff5365c),
  ],
);
const kSecondaryColor = Color(0xff323232); //0xFF979797
const kTextColor = Color(0xff323232); //   0xFF757575
MaterialColor testColor = const MaterialColor(
  0xffe6204c,
  <int, Color>{
    50: Color(0xfff4365c),
    100: Color(0xfff5365c),
  },
);

const kAnimationDuration = Duration(milliseconds: 200);

final headingStyle = TextStyle(
  fontSize: getProportionateScreenWidth(28),
  fontWeight: FontWeight.bold,
  color: Colors.black,
  height: 1.5,
);
final SecondaryStyle = TextStyle(
  fontSize: getProportionateScreenWidth(16),
  color: Colors.black,
  height: 1.5,
);

const defaultDuration = Duration(milliseconds: 250);

// Form Error
final RegExp emailValidatorRegExp =
    RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
const String kEmailNullError = "Please Enter your email";
const String kInvalidEmailError = "Please Enter Valid Email";
const String kPassNullError = "Please Enter your password";
const String kShortPassError = "Password is too short";
const String kMatchPassError = "Passwords don't match";
const String kNamelNullError = "Please Enter your name";
const String kPhoneNumberNullError = "Please Enter your phone number";
const String kAddressNullError = "Please Enter your address";

final otpInputDecoration = InputDecoration(
  contentPadding:
      EdgeInsets.symmetric(vertical: getProportionateScreenWidth(15)),
  border: outlineInputBorder(),
  focusedBorder: outlineInputBorder(),
  enabledBorder: outlineInputBorder(),
);

OutlineInputBorder outlineInputBorder() {
  return OutlineInputBorder(
    borderRadius: BorderRadius.circular(getProportionateScreenWidth(15)),
    borderSide: const BorderSide(color: kTextColor),
  );
}

String safeString(dynamic a, String onErrorValue) {
  return a is String ? a : onErrorValue;
}

int safeInt(dynamic a, int onErrorValue) {
  return a is int ? a : onErrorValue;
}

double safeDouble(dynamic a, double onErrorValue) {
  return a is double ? a : onErrorValue;
}

Map<String, dynamic> safeMap(dynamic a, Map<String, dynamic> onErrorValue) {
  return a is Map<String, dynamic> ? a : onErrorValue;
}

SlidableAction sa(
        Color color, String label, void Function(BuildContext)? func) =>
    SlidableAction(
      onPressed: func,
      //  borderRadius: BorderRadius.circular(10),
      backgroundColor: color,
      label: label,
      padding: const EdgeInsets.all(2),
    );
String avatar =
    'https://firebasestorage.googleapis.com/v0/b/bridella-eb876.appspot.com/o/users%2Fv2.png?alt=media&token=ba0765ef-244b-4ced-867f-5a58457dbe42';
