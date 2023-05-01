import 'package:bridella/app_core/services/constants.dart';
import 'package:bridella/business/models/business.dart';
import 'package:bridella/business/models/market_place.dart';
import 'package:bridella/business/screens/business_view_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../app_core/services/size_config.dart';
import '../../app_core/widgets/custom_app_bar.dart';
import '../widgets/business_list_page_w/rating_bar.dart';

class BusinessListScreen extends StatelessWidget {
  static String routeName = "/business_list_s";
  //final List<BizTitle>? bizList;
  const BusinessListScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    List<Business>? bizlist = Provider.of<List<Business>?>(context) ?? [];
    List<MarketPlace>? marketplace =
        Provider.of<List<MarketPlace>?>(context) ?? [];

    return Scaffold(
      appBar: ClassicAppBar.defaultAppBar(
        context,
        title: 'Our providers',
        actions: [],
      ),
      body: SafeArea(
          child: Column(children: [
        SizedBox(height: getProportionateScreenHeight(20)),
        Container(
          width: SizeConfig.screenWidth * 0.8,
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
                hintText: 'Search Providers',
                prefixIcon: const Icon(Icons.search)),
          ),
        ),
        SizedBox(height: getProportionateScreenWidth(10)),
        bizlist.isEmpty
            ? const Center(
                child: Text('Nothing to show here'),
              )
            : Expanded(
                child: ListView.builder(
                shrinkWrap: true,
                physics: const ClampingScrollPhysics(),
                itemCount: bizlist.length,

                //bizList.length,
                itemBuilder: (_, index) {
                  Business thisbiz = bizlist[index];
                  MarketPlace thisMp = marketplace
                      .where((mp) => thisbiz.businessId == mp.businessId)
                      .single;

                  return GestureDetector(
                    onTap: () => Navigator.of(context).push(
                      MaterialPageRoute(
                          builder: (context) => BusinessPage(
                              business: thisbiz, marketPlace: thisMp)),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 15, top: 10),
                      child: businessTile(thisbiz.businessName, thisbiz.logo,
                          thisbiz.ratingScore, thisbiz.businessDesc),
                    ),
                  );
                },
              ))
      ])),
    );
  }

  Widget businessTile(
      String name, String img, double score, String description) {
    return Card(
      color: bridellaBGColor,
      margin: const EdgeInsets.symmetric(horizontal: 8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      elevation: 2,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(width: 5),
          _bizImage(img),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                  ),
                  const SizedBox(height: 5),
                  _bizScore(score),
                  const SizedBox(height: 5),
                  Text(
                    description,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _bizScore(double score) {
    return Row(
      children: [
        StarRatingBar(score: score),
        const SizedBox(width: 10),
        Text(
          score.toString(),
        ),
      ],
    );
  }

  Widget _bizImage(String image) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(15.0),
      child: Image.network(
        image,
        height: 100,
        width: 100,
        fit: BoxFit.cover,
      ),
    );
  }
}
