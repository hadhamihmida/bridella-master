import 'package:bridella/business/models/market_place.dart';
import 'package:bridella/cart/models/cart.dart';
import 'package:flutter/material.dart';

import '../../app_core/services/constants.dart';
import '../../app_core/services/size_config.dart';
import '../../business/screens/product_details_screen.dart';

class CartCard extends StatelessWidget {
  const CartCard({
    Key? key,
    required this.orderPrdouct,
  }) : super(key: key);

  final OrderProduct orderPrdouct;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.of(context).push(
        MaterialPageRoute(
            builder: (context) => DetailsScreen(product: orderPrdouct.item)),
      ),
      child: Row(
        children: [
          SizedBox(
            width: 88,
            child: AspectRatio(
              aspectRatio: 0.88,
              child: Container(
                padding: EdgeInsets.all(getProportionateScreenWidth(10)),
                decoration: BoxDecoration(
                  color: const Color(0xFFF5F6F9),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Image.network(orderPrdouct.item.productImgs['0']),
              ),
            ),
          ),
          const SizedBox(width: 20),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                orderPrdouct.item.productName,
                style: const TextStyle(color: Colors.black, fontSize: 16),
                maxLines: 2,
              ),
              const SizedBox(height: 10),
              Text.rich(
                TextSpan(
                  text: "\dt${orderPrdouct.item.productPrice}",
                  style: const TextStyle(
                      fontWeight: FontWeight.w600, color: kPrimaryColor),
                  children: [
                    TextSpan(
                        text: " x${orderPrdouct.quantity}",
                        style: Theme.of(context).textTheme.bodyText1),
                  ],
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
