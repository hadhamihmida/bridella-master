import 'package:bridella/planner/widgets/time_call_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../app_core/services/constants.dart';
import '../../app_core/services/size_config.dart';

class PlannerBanner extends StatelessWidget {
  const PlannerBanner({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(

        // alignment: AlignmentDirectional.topCenter,
        fit: StackFit.loose,
        clipBehavior: Clip.none,
        children: [
          // base
          Container(
            margin: EdgeInsets.all(getProportionateScreenWidth(5)),
            padding: EdgeInsets.symmetric(
              horizontal: getProportionateScreenWidth(20),
              vertical: getProportionateScreenWidth(15),
            ),
            width: double.infinity,
            height: SizeConfig.screenHeight * 0.15,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                gradient:  LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment(0.8, 1),
            colors: <Color>[
              Color(0xff1f005c),
              Color(0xff5b0060),
              Color(0xff870160),
              Color(0xffac255e),
              Color(0xffca485c),
              Color(0xffe16b5c),
              Color(0xfff39060),
              Color(0xffffb56b),
            ], // Gradient from https://learnui.design/tools/gradient-generator.html
           
          ),
          ),
          ),
          // floating image
          Positioned(
            top: -50,
            right: 50,
            child: SvgPicture.asset(
              'assets/testImages/tasks_img2.svg',
              width: 130,
              height: 130,
            ),
          ),
          //
          Positioned(left: 20, top: 50, child: Timecall()),
          Positioned(
              right: 30,
              bottom: 20,
              child: Text(
                '4/5 Tasks',
                style: TextStyle(
                    fontSize: getProportionateScreenWidth(16),
                    color: bridellaBGColor
                    
                    ),
              )),
        ]);
  }
}
