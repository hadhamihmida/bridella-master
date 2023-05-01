import 'package:bridella/app_core/services/constants.dart';
import 'package:flutter/material.dart';

import '../../app_core/services/size_config.dart';

// ignore: must_be_immutable
class Timecall extends StatelessWidget {
  String _text = "";
  final int _nowtime = DateTime.now().hour;

  Timecall({super.key});
  String timeCall() {
    if (_nowtime <= 11) {
      _text = "Good Morning  ☀️";
    }
    if (_nowtime > 11) {
      _text = "Good Afternoon  🌞";
    }
    if (_nowtime >= 16) {
      _text = "Good Evening  🌆";
    }
    if (_nowtime >= 18) {
      _text = "Good Night  🌙";
    }

    return _text;
  }

  @override
  Widget build(BuildContext context) {
    return Text(timeCall(),
        style: TextStyle(
          fontSize: getProportionateScreenWidth(16),
          color: bridellaBGColor,
          fontWeight: FontWeight.bold,
        ));
  }
}
