import 'package:bridella/app_core/services/constants.dart';
import 'package:flutter/material.dart';

import '../../app_core/screens/Bridella_Scaffold.dart';
import '../../app_core/services/size_config.dart';
import '../../app_core/widgets/default_button.dart';

class OrderSucessScreen extends StatelessWidget {
  static String routeName = "/login_success";

  const OrderSucessScreen({super.key});
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      body: Column(
        children: [
          SizedBox(height: SizeConfig.screenHeight * 0.04),
          Image.asset(
            "assets/testImages/success2.png",
            height: SizeConfig.screenHeight * 0.4, //40%
          ),
          SizedBox(height: SizeConfig.screenHeight * 0.08),
          Text(
            "Your order is successfully placed !",
            style: TextStyle(
              fontSize: getProportionateScreenWidth(18),
              fontWeight: FontWeight.bold,
              color: kSecondaryColor,
            ),
          ),
          const Spacer(),
          SizedBox(
            width: SizeConfig.screenWidth * 0.6,
            child: DefaultButton(
              text: "Continue shopping",
              press: () {
                Navigator.pushReplacementNamed(
                    context, BridellaScaffold.routeName);
              },
            ),
          ),
          const Spacer(),
        ],
      ),
    );
  }
}
