import 'package:bridella/business/widgets/market_place_page_w/special_for_you_products.dart';
import 'package:flutter/material.dart';

import '../../app_core/services/animation.dart';
import '../../app_core/services/size_config.dart';
import '../widgets/market_place_page_w/business_list_view.dart';
import '../widgets/market_place_page_w/categories_component.dart';
import '../widgets/market_place_page_w/home_header.dart';
import '../widgets/market_place_page_w/special_offers.dart';

class MarketPlaceScreen extends StatelessWidget {
  static String routeName = "/market_place";

  const MarketPlaceScreen({super.key});
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: getProportionateScreenHeight(20)),
            const HomeHeader(),
            SizedBox(height: getProportionateScreenWidth(10)),
            // const DiscountBanner(),
            const SpecialOffers(),
            const FadeAnimation(
                transFactor: 0.0, delay: 0.8, child: Categories()),
            const BusinessesListView(),
            SizedBox(height: getProportionateScreenWidth(30)),
            const SpecialForYouProducts(),
            SizedBox(height: getProportionateScreenWidth(30)),
          ],
        ),
      ),

      /*  bottomNavigationBar: const CustomBottomNavBar(
        selectedMenu: MenuState.marketPLace,
      ), */
    );
  }
}
