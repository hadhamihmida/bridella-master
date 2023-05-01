import 'package:bridella/app_core/screens/Bridella_Scaffold.dart';
import 'package:bridella/business/models/business.dart';
import 'package:bridella/business/screens/product_details_screen.dart';
import 'package:bridella/business/screens/products_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../app_core/services/constants.dart';
import '../../app_core/services/size_config.dart';
import '../models/market_place.dart';

import '../widgets/rating_chunk.dart';

class BusinessPage extends StatefulWidget {
  static String routeName = '/business_page';
  final Business business;
  final MarketPlace marketPlace;

  const BusinessPage(
      {super.key, required this.business, required this.marketPlace});

  @override
  State<BusinessPage> createState() => _BusinessPageState();
}

class _BusinessPageState extends State<BusinessPage> {
  @override
  Widget build(BuildContext context) {
    List<BridellaCategory> cats = widget.marketPlace.categories;
    SizeConfig().init(context);
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: bridellaBGColor,
        title: Text(widget.business.businessName),
        leading: IconButton(
          icon: SvgPicture.asset(
            "assets/icons/Back ICon.svg",
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        clipBehavior: Clip.none,
        child: SafeArea(
          top: false,
          child: Column(
            children: [
              SizedBox(
                height: getProportionateScreenHeight(25),
              ),
              homeHeader(),
              SizedBox(
                height: getProportionateScreenHeight(25),
              ),
              // categories : Begin
              Container(
                padding: const EdgeInsets.symmetric(vertical: kDefaultPaddin),
                child: SizedBox(
                  height: 32,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: cats.length,
                    itemBuilder: (context, index) =>
                        buildCategory(cats[index].catName, index),
                  ),
                ),
              ),
              // end
              SizedBox(
                  height: getProportionateScreenHeight(600),
                  child: ListView(children: [_buildBody(selectedIndex)])),

              SizedBox(
                height: getProportionateScreenHeight(25),
              ),
            ],
          ),
        ),
      ),
    );
  }

  int selectedIndex = 0;

  Widget buildCategory(String catName, int index) {
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
                color: selectedIndex == index
                    ? const Color(0xFF535353)
                    : kTextLightColor,
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

  Widget _buildBody(int index) {
    List<BridellaCategory> categories = widget.marketPlace.categories;
    print(categories.length);
    List<CategoryPage> catPages =
        List.from(categories.map((cat) => CategoryPage(
              category: cat,
              mp: widget.marketPlace,
            )));
    return Column(
      children: [
        catPages[index],
        const SizedBox(height: 100),
      ],
    );
  }

  Widget homeHeader() => Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.center,
        children: [
          Image.network(
            widget.business.bannerImage,
            fit: BoxFit.fitWidth,
            width: double.infinity,
            height: getProportionateScreenHeight(200),
          ),
          Positioned(
              bottom: getProportionateScreenWidth(-25),
              child: Container(
                width: SizeConfig.screenWidth * 0.85,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: TextField(
                  onChanged: (value) => debugPrint(value),
                  decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(
                          horizontal: getProportionateScreenWidth(20),
                          vertical: getProportionateScreenWidth(9)),
                      border: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      hintText: 'Search product',
                      prefixIcon: const Icon(Icons.search)),
                ),
              ))
        ],
      );
}

class CategoryPage extends StatelessWidget {
  const CategoryPage({Key? key, required this.category, required this.mp})
      : super(key: key);
  final BridellaCategory category;
  final MarketPlace mp;

  @override
  Widget build(BuildContext context) {
    int listCount = category.items.length;
    print('*******${category.catName}');
    List<BridellaProduct> catItems = List<BridellaProduct>.from(mp.products
        .where((product) =>
            category.items.any((iId) => product.productId == iId))).toList();

    return Padding(
      padding: const EdgeInsets.all(8),
      child: ListView.builder(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: listCount,
        scrollDirection: Axis.vertical,
        itemBuilder: ((context, index) {
          BridellaProduct product = catItems[index];
          return ProductCard(product: product);
        }),
      ),
    );
  }
}

class ProductCard extends StatelessWidget {
  const ProductCard({Key? key, required this.product}) : super(key: key);
  final BridellaProduct product;

  @override
  Widget build(BuildContext context) {
    bool isJpg = product.productImgs['1'].toString().contains('.jpg');

    return Container(
      width: getProportionateScreenWidth(370),
      //height: getProportionateScreenWidth(80),
      padding: EdgeInsets.all(getProportionateScreenWidth(8)),
      child: GestureDetector(
        onTap: () => Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => DetailsScreen(product: product))),
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  //   padding: EdgeInsets.all(getProportionateScreenWidth(0)),
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
                      child: AspectRatio(
                          aspectRatio: 1, //3
                          child: Image.network(product.productImgs['0']))),
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
                      onTap: () {
                        Navigator.pushNamed(
                            context, BridellaScaffold.routeName);
                      },
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
            Positioned(right: 20, top: 15, child: ratingChunk())
          ],
        ),
      ),
    );
  }
}
