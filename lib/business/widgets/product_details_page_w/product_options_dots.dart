/*
import 'package:bridella/business/models/market_place.dart';
import 'package:flutter/material.dart';

import '../../../app_core/services/constants.dart';
import '../../../app_core/services/size_config.dart';
import '../../../app_core/widgets/rounded_icon_btn.dart';

class OptionsDots extends StatefulWidget {
  const OptionsDots({
    Key? key,
    required this.product,
  }) : super(key: key);

  final BridellaProduct product;

  @override
  State<OptionsDots> createState() => _OptionsDotsState();
}

class _OptionsDotsState extends State<OptionsDots> {
  int quantity =
      0; // listen to this in provider  or move all this page in the detail page
  @override
  Widget build(BuildContext context) {
    // Now this is fixed and only for demo
    int selectedColor = 3;
    return
  }
}

class ColorDot extends StatelessWidget {
  const ColorDot({
    Key? key,
    required this.color,
    this.isSelected = false,
  }) : super(key: key);

  final Color color;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 2),
      padding: EdgeInsets.all(getProportionateScreenWidth(8)),
      height: getProportionateScreenWidth(40),
      width: getProportionateScreenWidth(40),
      decoration: BoxDecoration(
        color: Colors.transparent,
        border:
            Border.all(color: isSelected ? kPrimaryColor : Colors.transparent),
        shape: BoxShape.circle,
      ),
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: color,
          shape: BoxShape.circle,
        ),
      ),
    );
  }
}
*/