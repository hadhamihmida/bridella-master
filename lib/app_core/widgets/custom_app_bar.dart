import 'package:bridella/app_core/screens/Bridella_Scaffold.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../services/constants.dart';
import '../services/size_config.dart';

class BridellaClassicAppbar extends StatelessWidget {
  const BridellaClassicAppbar({super.key});

  // AppBar().preferredSize.height provide us the height that appy on our app bar
  Size get preferredSize => Size.fromHeight(AppBar().preferredSize.height);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return SafeArea(
        child: AppBar(
            backgroundColor: bridellaBGColor,
            leading: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: getProportionateScreenWidth(20)),
              child: SizedBox(
                height: getProportionateScreenWidth(40),
                width: getProportionateScreenWidth(40),
                child: TextButton(
                  style: TextButton.styleFrom(
                      foregroundColor: kPrimaryColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(60),
                      ),
                      backgroundColor: bridellaBGColor,
                      
                      padding: EdgeInsets.zero,
                      elevation: 1.0),
                  onPressed: () => Navigator.pop(context),
                  child: SvgPicture.asset(
                    "assets/icons/Back ICon.svg",
                    height: 15,
                  ),
                ),
              ),
            )));
  }
}

abstract class ClassicAppBar {
  static PreferredSizeWidget defaultAppBar(
    BuildContext context, {
    String title = '',
    bool? centerTitle = false,
    List<Widget>? actions,
  }) {
    return AppBar(
      elevation: 1,
      leading: IconButton(
        onPressed: () => Navigator.pop(context), // change to .pop
        icon: SvgPicture.asset(
          "assets/icons/Back ICon.svg",
        ),
      ),
      title: Text(
        title,
        style: TextStyle(color: Colors.white),
      ),
      backgroundColor: Color.fromRGBO(225, 9, 157, 1),
      centerTitle: false,
      actions: actions,
    );
  }
}
