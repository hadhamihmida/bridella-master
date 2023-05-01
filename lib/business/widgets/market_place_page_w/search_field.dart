import 'package:flutter/material.dart';

import '../../../app_core/services/constants.dart';
import '../../../app_core/services/size_config.dart';

class SearchField extends StatelessWidget {
  SearchField({super.key, this.w, this.tag = 'Search product'});
  double? w = SizeConfig.screenWidth * 0.6;
  String? tag = 'Search product';

  @override
  Widget build(BuildContext context) {
    return Container(
      width: SizeConfig.screenWidth * 0.6,
      decoration: BoxDecoration(
        color: kSecondaryColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(15),
      ),
      child: TextField(
        onChanged: (value) => debugPrint(value),
        decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(
                horizontal: getProportionateScreenWidth(20),
                vertical: getProportionateScreenWidth(9)),
            border: InputBorder.none,
            focusedBorder: InputBorder.none,
            enabledBorder: InputBorder.none,
            hintText: tag,
            prefixIcon: const Icon(Icons.search)),
      ),
    );
  }
}
