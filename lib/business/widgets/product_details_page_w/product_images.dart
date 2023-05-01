import 'package:bridella/business/models/market_place.dart';
import 'package:flutter/material.dart';

import '../../../app_core/services/constants.dart';
import '../../../app_core/services/size_config.dart';

class ProductImages extends StatefulWidget {
  const ProductImages({
    Key? key,
    required this.product,
  }) : super(key: key);

  final BridellaProduct product;

  @override
  _ProductImagesState createState() => _ProductImagesState();
}

class _ProductImagesState extends State<ProductImages> {
  String selectedImage = '0';

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: getProportionateScreenWidth(238),
          child: AspectRatio(
            aspectRatio: 1,
            child: Hero(
              tag: widget.product.productId,
              child: Image.network(widget.product.productImgs[selectedImage],
                  errorBuilder: (context, error, stackTrace) =>
                      Image.asset('assets/testImages/ph.jpg')),
            ),
          ),
        ),
        // SizedBox(height: getProportionateScreenWidth(20)),

        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ...List.generate(widget.product.productImgs.length,
                (index) => buildSmallProductPreview(index.toString())),
          ],
        )
      ],
    );
  }

  GestureDetector buildSmallProductPreview(String index) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedImage = index.toString();
        });
      },
      child: AnimatedContainer(
          duration: defaultDuration,
          margin: const EdgeInsets.only(right: 15),
          padding: const EdgeInsets.all(8),
          height: getProportionateScreenWidth(48),
          width: getProportionateScreenWidth(48),
          decoration: BoxDecoration(
            color: bridellaBGColor,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
                color:
                    kPrimaryColor.withOpacity(selectedImage == index ? 1 : 0)),
          ),
          child: Image.network(widget.product.productImgs[index],
              errorBuilder: (context, error, stackTrace) =>
                  Image.asset('assets/testImages/ph.jpg'))),
    );
  }
}
