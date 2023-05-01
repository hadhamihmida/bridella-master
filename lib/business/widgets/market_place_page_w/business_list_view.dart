import 'package:bridella/business/screens/business_list_screen.dart';
import 'package:bridella/business/widgets/market_place_page_w/section_title.dart';
import 'package:flutter/material.dart';

import '../../../app_core/services/constants.dart';
import '../../../app_core/services/size_config.dart';

class BusinessesListView extends StatelessWidget {
  const BusinessesListView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding:
              EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
          child: SectionTitle(
            title: "Our Providers",
            press: () {
              Navigator.pushNamed(context, BusinessListScreen.routeName);
            },
          ),
        ),
        SizedBox(height: getProportionateScreenWidth(20)),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              const BusinessCard(
                image: "assets/testImages/b1.jpg",
                category: "Makeup",
                numOfBrands: 18,
              ),
              const BusinessCard(
                image: "assets/testImages/b2.jpg",
                category: "Furniture",
                numOfBrands: 24,
              ),
              SizedBox(width: getProportionateScreenWidth(20)),
            ],
          ),
        ),
      ],
    );
  }
}

class BusinessCard extends StatelessWidget {
  const BusinessCard({
    Key? key,
    required this.category,
    required this.image,
    required this.numOfBrands,
  }) : super(key: key);

  final String category, image;
  final int numOfBrands;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(left: getProportionateScreenWidth(20)),
        child: Hero(
          tag: category,
          child: GestureDetector(
            onTap: () {},
            child: SizedBox(
              width: getProportionateScreenWidth(242),
              height: getProportionateScreenWidth(100),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Stack(
                  children: [
                    Image.asset(
                      image,
                      fit: BoxFit.cover,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            const Color(0xFF343434).withOpacity(0.4),
                            const Color(0xFF343434).withOpacity(0.15),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: getProportionateScreenWidth(15.0),
                        vertical: getProportionateScreenWidth(10),
                      ),
                      child: Text.rich(
                        TextSpan(
                          style: const TextStyle(color: bridellaBGColor),
                          children: [
                            TextSpan(
                              text: "$category\n",
                              style: TextStyle(
                                fontSize: getProportionateScreenWidth(18),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            TextSpan(text: "$numOfBrands Brands")
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}
