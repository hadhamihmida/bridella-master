import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import '../../app_core/services/size_config.dart';
import '../../business/screens/product_details_screen.dart';
import '../models/cart.dart';
import '../widgets/cart_card.dart';
import '../widgets/check_out_card.dart';

class CartScreen extends StatelessWidget {
  static String routeName = "/cart";

  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      appBar: buildAppBar(context),
      body: const Body(),
      bottomNavigationBar: const CheckoutCard(),
    );
  }

  AppBar buildAppBar(BuildContext context) {
    final bridellaCart = Provider.of<BridellaCart>(context);
    return AppBar(
      centerTitle: true,
      elevation: 1,
      leading: IconButton(
        onPressed: () => Navigator.pop(context), // change to .pop
        icon: SvgPicture.asset(
          "assets/icons/Back ICon.svg",
        ),
      ),
      title: Column(
        children: [
          const Text(
            "Your Cart",
            style: TextStyle(color: Colors.black),
          ),
          Text(
            "${bridellaCart.cart.length} items",
            style: Theme.of(context).textTheme.caption,
          ),
        ],
      ),
    );
  }
}

class Body extends StatefulWidget {
  const Body({super.key});

  @override
  BodyState createState() => BodyState();
}

class BodyState extends State<Body> {
  @override
  Widget build(BuildContext context) {
    final bridellaCart = Provider.of<BridellaCart>(context);
    return Padding(
      padding:
          EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
      child: ListView.builder(
        itemCount: bridellaCart.cart.length,
        itemBuilder: (context, index) => Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Dismissible(
            key: const Key(''),
            direction: DismissDirection.endToStart,
            onDismissed: (direction) {
              setState(() {
                bridellaCart.cart.removeAt(index);
              });
            },
            background: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                color: const Color(0xFFFFE6E6),
                borderRadius: BorderRadius.circular(15),
              ),
              child: Row(
                children: [
                  const Spacer(),
                  SvgPicture.asset("assets/icons/Trash.svg"),
                ],
              ),
            ),
            child: CartCard(orderPrdouct: bridellaCart.cart[index]),
          ),
        ),
      ),
    );
  }
}
