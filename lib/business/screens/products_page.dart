import 'package:bridella/app_core/widgets/custom_app_bar.dart';
import 'package:bridella/business/screens/product_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import '../../app_core/services/constants.dart';
import '../../app_core/services/size_config.dart';
import '../models/market_place.dart';
import '../widgets/rating_chunk.dart';

const kTextColor = Color(0xFF535353);
const kTextLightColor = Color(0xFFACACAC);

const kDefaultPaddin = 20.0;

class BridellaProductsScreen extends StatefulWidget {
  static String routeName = "/test_products_screen";
  final String catName;

  const BridellaProductsScreen({super.key, required this.catName});

  @override
  State<BridellaProductsScreen> createState() => _BridellaProductsScreenState();
}

class _BridellaProductsScreenState extends State<BridellaProductsScreen> {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    final marketplace = Provider.of<List<MarketPlace>?>(context) ?? [];
    List<BridellaCategory> allCategories = [];
    List<BridellaProduct> allPorducts = [];

    for (var market in marketplace) {
      if (market.providerCat == widget.catName) {
        print('${market.providerCat} exits <3');
        allCategories.addAll(market.categories);
        allPorducts.addAll(market.products);
      }
    }

    return Scaffold(
      appBar: ClassicAppBar.defaultAppBar(context, title: widget.catName),
      body: allCategories.isNotEmpty
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                /*  Padding(
            padding: const EdgeInsets.symmetric(horizontal: kDefaultPaddin),
            child: Text(
              catName,
              style: Theme.of(context)
                  .textTheme
                  .headline5
                  ?.copyWith(fontWeight: FontWeight.bold),
            ),
          ),*/
                Container(
                  padding: const EdgeInsets.symmetric(vertical: kDefaultPaddin),
                  child: SizedBox(
                    height: 32,
                    child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: allCategories.length,
                        itemBuilder: (context, index) {
                          return buildCategory(
                              index, allCategories[index].catName);
                        }),
                  ),
                ),
                Expanded(
                    child:
                        buildBody(selectedIndex, allPorducts, allCategories)),
              ],
            )
          : const Center(
              child: Text('No products found'),
            ),
    );
  }

  int selectedIndex = 0;
  Widget buildBody(
      int index, List<BridellaProduct> products, List<BridellaCategory> cats) {
    List<BridellaProduct> catItems = List<BridellaProduct>.from(products.where(
        (product) =>
            cats[index].items.any((iId) => product.productId == iId))).toList();

    List<CategoryPage> catPages = List.from(cats.map((cat) => CategoryPage(
          category: cat,
          products: catItems,
        )));
    return catPages[index];
  }

  Widget buildCategory(int index, String catName) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedIndex = index;
        });
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: kDefaultPaddin),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              catName,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: selectedIndex == index ? kTextColor : kTextLightColor,
              ),
            ),
            Container(
              margin: const EdgeInsets.only(
                  top: kDefaultPaddin / 4), //top padding 5
              height: 2,
              width: 30,
              color: selectedIndex == index ? Colors.black : Colors.transparent,
            )
          ],
        ),
      ),
    );
  }
}

class ItemCard extends StatelessWidget {
  final BridellaProduct product;
  final Function press;
  const ItemCard({
    required this.product,
    required this.press,
  });

  @override
  Widget build(BuildContext context) {
    // check if the main image is a a jpg or png format, so we can rightly render it later
    bool isJpg = product.productImgs['1'].toString().contains('.jpg');
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
              builder: (context) => DetailsScreen(product: product)),
        );
      },
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(0),
                  // For  demo we use fixed height  and width
                  // Now we dont need them
                  // height: 180,
                  // width: 160,
                  decoration: BoxDecoration(
                    color: kSecondaryColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(16),
                    /*  image: isJpg
                        ? DecorationImage(
                            image: NetworkImage(product.productImgs['0']),
                            fit: BoxFit.contain,
                          )
                        : DecorationImage(
                            image: NetworkImage(product.productImgs['0']),
                            fit: BoxFit.contain,
                          ),*/
                  ),

                  child: Hero(
                    tag: product.productId,
                    child: Image.network(product.productImgs['0'],
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) =>
                            Image.asset('assets/testImages/ph.jpg')),
                  ),
                ),
              ),
              /*   Padding(
                padding: const EdgeInsets.symmetric(vertical: kDefaultPaddin / 4),
                child: Text(
                  // products is out demo list
                  product.productName,
                  style: const TextStyle(color: kTextLightColor),
                ),
              ),
              Text(
                "\$${product.productPrice}",
                style: const TextStyle(fontWeight: FontWeight.bold),
              )*/
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
                                ? kPrimaryColor.withOpacity(0.1)
                                // ignore: dead_code
                                : kSecondaryColor.withOpacity(0.1),
                        shape: BoxShape.circle,
                      ),
                      child: SvgPicture.asset(
                        "assets/icons/Heart Icon_2.svg",
                        color: true
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
          Positioned(right: 20, top: 15, child: ratingChunk())
        ],
      ),
    );
  }
}

class CategoryPage extends StatelessWidget {
  const CategoryPage({Key? key, required this.category, required this.products})
      : super(key: key);
  final BridellaCategory category;
  final List<BridellaProduct> products;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: kDefaultPaddin),
        child: GridView.builder(
            itemCount: products.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: kDefaultPaddin,
              crossAxisSpacing: kDefaultPaddin,
              childAspectRatio: 0.75,
            ),
            itemBuilder: (context, index) {
              return ItemCard(product: products[index], press: () {});
            }));
  }
}
