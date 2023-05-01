import 'package:bridella/app_core/services/constants.dart';
import 'package:bridella/app_core/services/size_config.dart';
import 'package:flutter/material.dart';

class DefaultButton extends StatelessWidget {
  const DefaultButton({
    Key? key,
    this.text,
    this.press,
    this.padding,
  }) : super(key: key);
  final String? text;
  final Function? press;
  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: getProportionateScreenHeight(56),
      child: TextButton(
        style: TextButton.styleFrom(
            foregroundColor: bridellaBGColor,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            backgroundColor: kPrimaryColor,
            padding: padding),
        onPressed: press as void Function()?,
        child: Text(
          text!,
          style: TextStyle(
            fontSize: getProportionateScreenWidth(18),
            color: bridellaBGColor,
          ),
        ),
      ),
    );
  }
}
