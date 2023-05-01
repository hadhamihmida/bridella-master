import 'package:bridella/app_core/bridella_app.dart';
import 'package:bridella/app_core/services/show_snackbar.dart';
import 'package:bridella/app_core/services/size_config.dart';
import 'package:bridella/business/models/market_place.dart';
import 'package:bridella/wishes/services/wish_db.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../app_core/services/constants.dart';
import '../../users/models/user.dart';

showWishDialog(BuildContext context, BridellaProduct product) {
  showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(25.0))),
          contentPadding: const EdgeInsets.all(0),
          scrollable: true,
          content: AddingtoWishlistView(product: product),
          elevation: 5,
        );
      });
}

class AddingtoWishlistView extends StatefulWidget {
  const AddingtoWishlistView({Key? key, required this.product})
      : super(key: key);
  final BridellaProduct product;

  @override
  State<AddingtoWishlistView> createState() => _AddingtoWishlistViewState();
}

class _AddingtoWishlistViewState extends State<AddingtoWishlistView> {
  bool loading = false;

  final Map<String, dynamic> wishData = {
    'comments': {},
    'likes': {},
  };
  @override
  Widget build(BuildContext context) {
    WishDataBase wishDB = WishDataBase();
    final user = Provider.of<BridellaUser?>(context);

    return SizedBox(
      width: SizeConfig.screenWidth * 0.75,
      child: loading
          ? Container(
              alignment: Alignment.center,
              height: SizeConfig.screenWidth * 0.75,
              child: const CircularProgressIndicator(
                color: kPrimaryColor,
              ),
            )
          : Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                const SizedBox(
                  height: 8.0,
                ),
                Row(
                  // mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const SizedBox(
                      width: 5,
                    ),
                    ClipOval(
                        child: Material(
                      color: Colors.transparent,
                      child: Ink.image(
                        image: NetworkImage(user!.urlAvatar ??
                            'https://firebasestorage.googleapis.com/v0/b/bridella-eb876.appspot.com/o/users%2Fv2.png?alt=media&token=ba0765ef-244b-4ced-867f-5a58457dbe42'),
                        fit: BoxFit.cover,
                        width: 40,
                        height: 40,
                      ),
                    )),
                    const SizedBox(
                      width: 5,
                    ),
                    SizedBox(
                        width: SizeConfig.screenWidth * .6,
                        height: SizeConfig.screenWidth / 8,
                        child: TextField(
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.all(1),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide:
                                  const BorderSide(color: bridellaBGColor),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide:
                                  const BorderSide(color: kPrimaryColor),
                            ),
                            border: InputBorder.none,
                            hintText: "Your feeling :)",
                          ),
                          onChanged: (value) {
                            wishData['desc'] = value;
                            setState(() {});
                          },
                        ))
                  ],
                ),
                const SizedBox(
                  height: 8,
                ),
                ClipRRect(
                  borderRadius: BorderRadius.circular(15.0),
                  child: Image.network(
                    widget.product.productImgs['0'],
                    height: SizeConfig.screenHeight * .2,
                    width: SizeConfig.screenHeight * .4,
                    fit: BoxFit.contain,
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                SizedBox(
                    width: SizeConfig.screenWidth * 0.4,
                    child: SizedBox(
                      width: double.infinity,
                      height: getProportionateScreenHeight(56),
                      child: TextButton(
                        style: TextButton.styleFrom(
                          shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(25.0),
                                  bottomRight: Radius.circular(25.0))),
                          foregroundColor: bridellaBGColor,
                          backgroundColor: kPrimaryColor,
                        ),
                        onPressed: () {
                          setState(() {
                            /// check if the wish already exists in database
                            wishData['wishImg'] =
                                widget.product.productImgs['0'];
                            wishData['wishName'] = widget.product.productName;
                            wishData['tobuyId'] = widget.product.productId;
                            wishData['price'] = widget.product.productPrice;
                            wishData['ownerName'] = user.displayName;
                            wishData['ownerAvatar'] = user.urlAvatar;

                            loading = true;
                          });
                          print(wishData);
                          if (wishData['desc'] == null ||
                              wishData['desc'].toString().isEmpty) {
                            showSnackBar(
                                context, "Description can't be empty!");

                            setState(() {
                              loading = false;
                            });
                          } else if (user != null) {
                            setState(() {
                              wishData['ownerEmail'] = user.email;
                            });

                            wishDB.createWish(wishData).then((value) {
                              showSnackBar(
                                  context, 'Wish successfully added 🎁');
                              Navigator.pop(context);
                            });
                          } else {
                            setState(() {
                              showSnackBar(context, 'Somthing went wrong');

                              loading = false;
                            });
                          }
                        },
                        child: Text(
                          'Post to Timeline',
                          style: TextStyle(
                            fontSize: getProportionateScreenWidth(18),
                            color: bridellaBGColor,
                          ),
                        ),
                      ),
                    )),
              ],
            ),
    );
  }
}
