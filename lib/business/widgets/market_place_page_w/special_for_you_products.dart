import 'package:bridella/business/widgets/market_place_page_w/product_card.dart';
import 'package:flutter/material.dart';

import '../../../app_core/services/size_config.dart';
import '../../../dummy_data.dart';
import 'section_title.dart';

class SpecialForYouProducts extends StatelessWidget {
  const SpecialForYouProducts({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding:
              EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
          child: SectionTitle(title: "Special for you", press: () {}),
        ),
        SizedBox(height: getProportionateScreenWidth(20)),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              ...List.generate(
                demothreeProducts.length,
                (index) {
                  if (demothreeProducts[index].ratingScore > 4) {
                    return ProductCard(product: demothreeProducts[index]);
                  }

                  return const SizedBox
                      .shrink(); // here by default width and height is 0
                },
              ),
              SizedBox(width: getProportionateScreenWidth(20)),
            ],
          ),
        )
      ],
    );
  }
}
