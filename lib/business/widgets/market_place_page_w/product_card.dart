import 'package:bridella/business/models/market_place.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../app_core/services/constants.dart';
import '../../../app_core/services/size_config.dart';
import '../../screens/product_details_screen.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({
    Key? key,
    this.width = 140,
    this.aspectRetio = 1.02,
    required this.product,
  }) : super(key: key);

  final double width, aspectRetio;
  final BridellaProduct product;

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    // check if the main image is a a jpg or png format, so we can rightly render it later
    bool isJpg = product.productImgs['1'].toString().contains('.jpg');

    return Container(
      padding: EdgeInsets.only(left: getProportionateScreenWidth(20)),
      width: getProportionateScreenWidth(width),
      child: GestureDetector(
        onTap: () => Navigator.of(context).push(
          MaterialPageRoute(
              builder: (context) => DetailsScreen(product: product)),
        ),
        /* Navigator.pushNamed(
          context,
          DetailsScreen.routeName,
          arguments: ProductDetailsArguments(product: product),
        ),*/
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AspectRatio(
              aspectRatio: 1.02,
              child: Container(
                padding: isJpg
                    ? null
                    : EdgeInsets.all(getProportionateScreenWidth(20)),
                decoration: BoxDecoration(
                  color: kSecondaryColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(15),
                  image: isJpg
                      ? DecorationImage(
                          image: AssetImage(product.productImgs['1']),
                          fit: BoxFit.cover,
                        )
                      : null,
                ),
                child: Hero(
                  tag: product.productName,
                  child: Image.asset(product.productImgs['0']),
                ),
              ),
            ),
            const SizedBox(height: 10),
            Text(
              product.productName,
              style: const TextStyle(color: Colors.black),
              maxLines: 2,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "\$${product.productPrice}",
                  style: TextStyle(
                    fontSize: getProportionateScreenWidth(18),
                    fontWeight: FontWeight.w600,
                    color: kPrimaryColor,
                  ),
                ),
                InkWell(
                  borderRadius: BorderRadius.circular(50),
                  onTap: () {},
                  child: Container(
                    padding: EdgeInsets.all(getProportionateScreenWidth(8)),
                    height: getProportionateScreenWidth(28),
                    width: getProportionateScreenWidth(28),
                    decoration: BoxDecoration(
                      color: //product.isFavourite
                          true
                              ? kPrimaryColor.withOpacity(0.15)
                              // ignore: dead_code
                              : kSecondaryColor.withOpacity(0.1),
                      shape: BoxShape.circle,
                    ),
                    child: SvgPicture.asset(
                      "assets/icons/Heart Icon_2.svg",
                      color: //product.isFavourite
                          true
                              ? const Color(0xFFFF4848)
                              // ignore: dead_code
                              : const Color(0xFFDBDEE4),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
