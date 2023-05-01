import 'package:bridella/business/models/market_place.dart';
import 'package:bridella/dummy_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../app_core/services/constants.dart';
import '../../../app_core/services/show_snackbar.dart';
import '../../../app_core/services/size_config.dart';

class ProductDescription extends StatefulWidget {
  const ProductDescription({
    Key? key,
    required this.product,
    this.pressOnSeeMore,
  }) : super(key: key);

  final BridellaProduct product;
  final GestureTapCallback? pressOnSeeMore;

  @override
  State<ProductDescription> createState() => _ProductDescriptionState();
}

class _ProductDescriptionState extends State<ProductDescription> {
  var seeMorePressed = false;
  bool isFavourite = false;
  bool inPromo = false;

  @override
  Widget build(BuildContext context) {
    BridellaProduct p = widget.product;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding:
              EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.product.productName,
                style: Theme.of(context).textTheme.headline6,
              ),
              inPromo ? initialPriceView(22) : newPriceView(22, 16),
            ],
          ),
        ),
        Align(
          alignment: Alignment.centerRight,
          child: GestureDetector(
            onTap: () => setState(() {
              isFavourite = !isFavourite;
              favouriteList.add(BridellaProduct(
                  productId: p.productId,
                  productName: p.productName,
                  productPrice: p.promoPrice,
                  shortDesc: p.shortDesc,
                  longDesc: p.longDesc,
                  inPromo: inPromo,
                  promoPrice: p.promoPrice,
                  ratingScore: p.ratingScore,
                  productAvailable: p.productAvailable,
                  productImgs: p.productImgs));
              showSnackBar(context, 'Added to my favourites 💗');
            }),
            child: Container(
              padding: EdgeInsets.all(getProportionateScreenWidth(15)),
              width: getProportionateScreenWidth(64),
              decoration: BoxDecoration(
                color: isFavourite
                    ? const Color(0xFFFFE6E6)
                    : const Color(0xFFF5F6F9),
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(20),
                  bottomLeft: Radius.circular(20),
                ),
              ),
              child: SvgPicture.asset(
                "assets/icons/Heart Icon_2.svg",
                color: isFavourite
                    ? kPrimaryColor
                    // ignore: dead_code
                    : const Color(0xFFDBDEE4),
                height: getProportionateScreenWidth(16),
              ),
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(
            left: getProportionateScreenWidth(20),
            right: getProportionateScreenWidth(64),
          ),
          child: Text(
            widget.product.shortDesc ?? '',
            maxLines: seeMorePressed ? 6 : 3,
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: getProportionateScreenWidth(20),
            vertical: 10,
          ),
          child: GestureDetector(
            onTap: () {
              setState(() {
                seeMorePressed = !seeMorePressed;
              });
            },
            child: Row(
              children: const [
                Text(
                  "See More Detail",
                  style: TextStyle(
                      fontWeight: FontWeight.w600, color: kPrimaryColor),
                ),
                SizedBox(width: 5),
                Icon(
                  Icons.arrow_forward_ios,
                  size: 12,
                  color: kPrimaryColor,
                ),
              ],
            ),
          ),
        )
      ],
    );
  }

  Widget initialPriceView(double price) => Text(
        "\$$price",
        style: TextStyle(
          fontSize: getProportionateScreenWidth(18),
          fontWeight: FontWeight.w600,
          color: kPrimaryColor,
        ),
      );
  Widget newPriceView(double price, double promoPrice) => Row(
        children: [
          Text("\$$promoPrice",
              style: TextStyle(
                  fontSize: getProportionateScreenWidth(18),
                  fontWeight: FontWeight.w300,
                  color: kTextColor,
                  decoration: TextDecoration.lineThrough,
                  decorationColor: kTextColor,
                  decorationStyle: TextDecorationStyle.solid)),
          const SizedBox(
            width: 4,
          ),
          Text(
            "\$$price",
            style: TextStyle(
              fontSize: getProportionateScreenWidth(18),
              fontWeight: FontWeight.w600,
              color: kPrimaryColor,
            ),
          ),
        ],
      );
}
