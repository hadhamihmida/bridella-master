import 'package:bridella/app_core/services/constants.dart';
import 'package:bridella/app_core/widgets/custom_app_bar.dart';
import 'package:bridella/dummy_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../app_core/services/size_config.dart';
import '../../business/screens/products_view_screen.dart';

class FavouritePage extends StatelessWidget {
  static String routeName = "/favourite_page";
  const FavouritePage({super.key});

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      appBar:
          ClassicAppBar.defaultAppBar(context, title: 'Favourite', actions: []),
      body: SizedBox(
        width: SizeConfig.screenWidth,
        child: favouriteList.isEmpty
            ? emptyView(context)
            : SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: getProportionateScreenWidth(25)),
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 25),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ...List.generate(
                            favouriteList.length,
                            (index) =>
                                ProdcutCardTest(product: favouriteList[index])),
                      ],
                    ),
                  ),
                ),
              ),
      ),
    );
  }
}

Widget emptyView(BuildContext c) => Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Flexible(
            child: AspectRatio(
              aspectRatio: 5,
              child: SvgPicture.asset(
                "assets/testImages/fav.svg",
              ),
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          const Text(
            "You don't have any favourites yet.",
            style: TextStyle(fontSize: 18.0, color: kTextColor),
          ),
        ],
      ),
    );
