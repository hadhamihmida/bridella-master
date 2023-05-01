import 'dart:math';

import 'package:bridella/app_core/widgets/custom_app_bar.dart';
import 'package:bridella/cart/models/cart.dart';
import 'package:bridella/cart/models/pay_methods_enum.dart';
import 'package:bridella/cart/screens/order_success_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../app_core/services/constants.dart';
import '../../app_core/services/size_config.dart';
import '../../app_core/widgets/default_button.dart';
import '../../business/services/market_place_db.dart';
import '../../planner/models/budget.dart';
import '../../planner/services/budget_db.dart';
import '../../users/models/user.dart';

class CheckoutScreen extends StatefulWidget {
  static String routeName = "/Check_out";
  const CheckoutScreen({super.key});

  @override
  _CheckoutScreenState createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  MenuDatabaseServices mp = MenuDatabaseServices();
  BudgetDB budgetDb = BudgetDB();

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    final user = Provider.of<BridellaUser>(context);
    final bridellaCart = Provider.of<BridellaCart>(context);
    final budgetList = Provider.of<Budget>(context);
    final item = bridellaCart.cart.first.item;

    return SafeArea(
        child: Scaffold(
            appBar: ClassicAppBar.defaultAppBar(context,
                title: 'Confirm your order', actions: []),
            body: Scrollbar(
                child: ListView(
              // crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                textChunk('Shipping Address'),
                AdressCard(
                  title: user.displayName ?? 'unknown',
                  linkText: 'Change',
                  onLinkTap: (() => {}),
                  child: const FittedBox(
                    child: Text('Monastir 5000 à coté de Nafouraa',
                        style: TextStyle(color: kSecondaryColor)),
                  ),
                ),
                textChunk('Payment'),
                paymentMethodsView(),
                SizedBox(
                  height: SizeConfig.screenHeight * .15,
                ),
                summaryChnuk(),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 12.0),
                  child: DefaultButton(
                    text: "Submit Order",
                    press: () {
                      // confirm an order
                      final Map<String, dynamic> itemData = {
                        'desc': '',
                        'certifiedBridella': true,
                        'price': item.productPrice,
                        'name': item.productName,
                        'estimatedPrice': item.productPrice
                      };
                      final Random random = Random();

                      String generateID() {
                        var id = random.nextInt(100).toString();
                        final List<String> idsList = [];
                        for (var item in budgetList.items) {
                          idsList.add(item.id);
                        }
                        while (idsList.contains(id)) {
                          id = random.nextInt(100).toString();
                        }

                        return id.toString();
                      }

                      budgetDb
                          .createBudgetItem(user.uid, generateID(), itemData)
                          .then((value) => Navigator.pushNamed(
                              context, OrderSucessScreen.routeName));
                      /*    mp.confirmOrder({
                        'clientName': user.displayName,
                        'clientAddress': user.address ?? '',
                        'clientPhoneNumber': user.phoneNumber ?? '',
                        'items': { '0' : bridellaCart.cart.first.item.},
                      });*/
                    },
                  ),
                ),
                const SizedBox(
                  height: 12,
                )
              ],
            ))));
  }

  ///
  ///
  ///
  ///
  ///
  ///
  ///
  ///
  ///
  ///

  Widget textChunk(String title) => Padding(
        padding: const EdgeInsets.all(8),
        child: Text(
          title,
          style: TextStyle(
            fontSize: getProportionateScreenWidth(18),
            color: Colors.black,
          ),
        ),
      );

  Widget paymentMethodsView() {
    return Padding(
      padding: const EdgeInsets.all(13.0),
      child: Center(
          child: Column(
        children: <Widget>[
          buildPaymentElement(
              'mastercard.png', 'Credit Card', PayMethods.creditCard),
          const SizedBox(
            height: 6,
          ),
          buildPaymentElement(
              'pay.png', 'Cash on delivery', PayMethods.cashOnDelivrey)
        ],
      )),
    );
  }

  PayMethods selectedPayMethod = PayMethods.cashOnDelivrey;

  @override
  void initState() {
    super.initState();
  }

  Widget buildPaymentElement(
      String methodIcon, String methodName, PayMethods method) {
    return Container(
      width: SizeConfig.screenWidth,
      height: 55.0,
      decoration: BoxDecoration(
        border: method == selectedPayMethod
            ? Border.all(width: 2.0, color: kPrimaryColor)
            : Border.all(width: 0.3, color: Colors.grey),
        borderRadius: const BorderRadius.all(Radius.circular(5.0)),
        color: Colors.transparent,
      ),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.only(right: 20.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Radio(
                      value: method,
                      groupValue: selectedPayMethod,
                      onChanged: (PayMethods? value) {
                        setState(() {
                          selectedPayMethod = value!;
                        });
                      },
                      activeColor: kPrimaryColor),
                  Text(methodName,
                      style: method == selectedPayMethod
                          ? const TextStyle(
                              fontSize: 15.0,
                              fontWeight: FontWeight.w500,
                              color: kSecondaryColor)
                          : const TextStyle(
                              fontSize: 15.0,
                              fontWeight: FontWeight.w500,
                              color: Colors.grey)),
                ],
              ),
              Image.asset("assets/icons/$methodIcon", width: 50.0),
            ],
          ),
        ),
      ),
    );
  }

  Widget summaryChnuk() {
    var width = SizeConfig.screenHeight;
    final bridellaCart = Provider.of<BridellaCart>(context);

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Sub-total',
                  style: TextStyle(
                      fontSize: 15.0,
                      fontWeight: FontWeight.w400,
                      color: Colors.grey)),
              Text('${bridellaCart.cartTotal} dt',
                  style: const TextStyle(
                      fontSize: 15.0,
                      fontWeight: FontWeight.w400,
                      color: Colors.black)),
            ],
          ),
          const SizedBox(height: 15.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Text('Shipping fee',
                  style: TextStyle(
                      fontSize: 15.0,
                      fontWeight: FontWeight.w400,
                      color: Colors.grey)),
              Text('0.00 dt',
                  style: TextStyle(
                      fontSize: 15.0,
                      fontWeight: FontWeight.w400,
                      color: Colors.black)),
            ],
          ),
          const SizedBox(height: 15.0),
          Container(width: width, height: 1.0, color: Colors.grey),
          const SizedBox(height: 15.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Total Payment',
                  style: TextStyle(
                      fontSize: 15.0,
                      fontWeight: FontWeight.w500,
                      color: Colors.black)),
              Text('${bridellaCart.cartTotal} dt',
                  style: const TextStyle(
                      fontSize: 15.0,
                      fontWeight: FontWeight.w500,
                      color: Colors.black)),
            ],
          ),
        ],
      ),
    );
  }
}

class AdressCard extends StatelessWidget {
  final String title;
  final String linkText;
  final Function onLinkTap;
  final Widget child;

  const AdressCard(
      {Key? key,
      required this.title,
      required this.linkText,
      required this.child,
      required this.onLinkTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    // var width = SizeConfig.screenWidth;
    return Container(
        height: SizeConfig.screenWidth / 4,
        margin: const EdgeInsets.all(12),
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(12)),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                  color: Colors.grey.withOpacity(0.3),
                  blurRadius: 5,
                  offset: const Offset(0.0, 2.2))
            ]),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                SizedBox(
                    child: Text(
                  title,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                )),
                Container(
                  alignment: Alignment.centerRight,
                  child: InkWell(
                      onTap: (() => {onLinkTap()}),
                      child: Text(
                        linkText,
                        style: const TextStyle(color: kPrimaryColor),
                      )),
                )
              ],
            ),
            Container(
                padding: const EdgeInsets.symmetric(vertical: 5), child: child)
          ],
        ));
  }
}
