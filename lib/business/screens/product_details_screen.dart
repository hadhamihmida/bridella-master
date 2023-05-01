import 'package:bridella/business/models/market_place.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../app_core/services/constants.dart';
import '../../app_core/services/show_snackbar.dart';
import '../../app_core/services/size_config.dart';
import '../../app_core/widgets/default_button.dart';
import '../../app_core/widgets/rounded_icon_btn.dart';
import '../../cart/models/cart.dart';
import '../../cart/screens/cart_screen.dart';
import '../widgets/product_details_page_w/mp_custom_app_bar.dart';
import '../widgets/product_details_page_w/product_description.dart';
import '../widgets/product_details_page_w/product_images.dart';
import '../widgets/product_details_page_w/top_rounded_container.dart';

class DetailsScreen extends StatelessWidget {
  static String routeName = "/details";

  const DetailsScreen({super.key, required this.product});
  final BridellaProduct product;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F6F9),
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(AppBar().preferredSize.height),
        child: MPcustomAppBar(product: product),
      ),
      body: Body(product: /*agrs.*/ product),
    );
  }
}

class ProductDetailsArguments {
  final BridellaProduct product;

  ProductDetailsArguments({required this.product});
}

class Body extends StatefulWidget {
  final BridellaProduct product;

  const Body({Key? key, required this.product}) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  int quantity = 1;
  int selectedOption = 0;
  @override
  Widget build(BuildContext context) {
    final bridellaCart = Provider.of<BridellaCart>(context);
    return ListView(
      children: [
        ProductImages(product: widget.product),
        TopRoundedContainer(
          color: bridellaBGColor,
          child: Column(
            children: [
              ProductDescription(
                product: widget.product,
                pressOnSeeMore: () {},
              ),
              TopRoundedContainer(
                color: const Color(0xFFF6F7F9),
                child: Column(
                  children: [
                    //
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: getProportionateScreenWidth(20)),
                      child: Row(
                        children: [
                          ...List.generate(
                            //  widget.product.options.length,
                            3,
                            (index) => GestureDetector(
                                onTap: () {
                                  setState(() {
                                    selectedOption = index;
                                  });
                                },
                                child: widget.product.options.isEmpty
                                    ? SizeDot(
                                        size: 'XL',
                                        //   color: widget.product.options[index.toString()],
                                        isSelected: index == selectedOption,
                                      )
                                    : ColorDot(
                                        color: widget
                                            .product.options[index.toString()],
                                      )
                                /*SizeDot(
                                size: 'XL',
                                //   color: widget.product.options[index.toString()],
                                isSelected: index == selectedOption,
                              ),*/
                                ),
                          ),
                          const Spacer(),
                          RoundedIconBtn(
                            icon: Icons.remove,
                            press: () {
                              setState(() {
                                quantity > 0 ? quantity-- : null;
                              });
                            },
                          ),
                          //   SizedBox(width: getProportionateScreenWidth(20)),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 11),
                            child: Text(
                              quantity.toString(),
                              // style: Theme.of(context).textTheme.headline6,
                            ),
                          ),
                          RoundedIconBtn(
                            icon: Icons.add,
                            showShadow: true,
                            press: () {
                              setState(() {
                                quantity++;
                              });
                            },
                          ),
                        ],
                      ),
                    ), //
                    // OptionsDots(product: widget.product),
                    TopRoundedContainer(
                      color: bridellaBGColor,
                      child: Padding(
                        padding: EdgeInsets.only(
                          left: SizeConfig.screenWidth * 0.15,
                          right: SizeConfig.screenWidth * 0.15,
                          bottom: getProportionateScreenWidth(40),
                          top: getProportionateScreenWidth(15),
                        ),
                        child: DefaultButton(
                          text: "Add To Cart",
                          press: () {
                            if (quantity == 0) {
                              message('How many ? 🧐');
                            } else {
                              bridellaCart.addToCart(OrderProduct(
                                  item: widget.product,
                                  quantity: quantity,
                                  subTotal:
                                      widget.product.productPrice * quantity));
                              Navigator.pushNamed(
                                  context, CartScreen.routeName);

                              message('Successfully added to your cart!');
                            }
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class ColorDot extends StatelessWidget {
  const ColorDot({
    Key? key,
    required this.color,
    this.isSelected = false,
  }) : super(key: key);

  final Color color;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 2),
      padding: EdgeInsets.all(getProportionateScreenWidth(8)),
      height: getProportionateScreenWidth(40),
      width: getProportionateScreenWidth(40),
      decoration: BoxDecoration(
        color: Colors.transparent,
        border:
            Border.all(color: isSelected ? kPrimaryColor : Colors.transparent),
        shape: BoxShape.circle,
      ),
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: color,
          shape: BoxShape.circle,
        ),
      ),
    );
  }
}

class SizeDot extends StatelessWidget {
  const SizeDot({
    Key? key,
    required this.size,
    this.isSelected = false,
  }) : super(key: key);

  final String size;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return Container(
        alignment: Alignment.center,
        margin: const EdgeInsets.only(right: 2),
        padding: EdgeInsets.all(getProportionateScreenWidth(8)),
        height: getProportionateScreenWidth(35),
        width: getProportionateScreenWidth(35),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(
              color: isSelected ? kPrimaryColor : Colors.transparent),
          shape: BoxShape.circle,
        ),
        child: FittedBox(
          child: Text(
            size.toUpperCase(),
            style: const TextStyle(color: Colors.black),
          ),
        ));
  }
}
