import 'package:bridella/business/models/market_place.dart';
import 'package:bridella/business/screens/product_details_screen.dart';
import 'package:bridella/business/screens/products_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../app_core/services/constants.dart';
import '../../app_core/services/size_config.dart';
/*
class ProductsViewScreen extends StatefulWidget {
  static String routeName = "/product_view_screen";
  const ProductsViewScreen({Key? key}) : super(key: key);

  @override
  State<ProductsViewScreen> createState() => _ProductsViewScreenState();
}

class _ProductsViewScreenState extends State<ProductsViewScreen> {
  int _selectIndex = 0;

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      /* appBar: PreferredSize(
        preferredSize: Size.fromHeight(AppBar().preferredSize.height),
        child: const BridellaClassicAppbar(),
      ),*/
      appBar: ClassicAppBar.defaultAppBar(
        context,
        title: 'Products',
        actions: [
          IconButton(
            icon: SvgPicture.asset(
              'assets/icons/Search Icon.svg',
            ),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        children: [
          const SizedBox(height: 24),
          _buildCategories(),
          const SizedBox(height: 20),
          Expanded(
            child: ListView(
              children: [_buildBody(context)],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    return Column(
      children: [
        _buildProductsGridView(),
        const SizedBox(height: 45),
      ],
    );
  }

  Widget _buildCategories() {
    return Container(
      padding: EdgeInsets.only(left: getProportionateScreenWidth(20)),
      height: 40,
      child: ListView.separated(
        itemCount: categories.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: _buildCatItem,
        separatorBuilder: (BuildContext context, int index) {
          return const SizedBox(width: 12);
        },
      ),
    );
  }

  void _onTapItem(int index) {
    setState(() {
      _selectIndex = index;
    });
  }

  Widget _buildCatItem(BuildContext context, int index) {
    final isActive = _selectIndex == index;
    const radius = BorderRadius.all(Radius.circular(19));
    return Container(
      decoration: BoxDecoration(
        borderRadius: radius,
        border:
            Border.all(color: const Color.fromARGB(255, 46, 44, 44), width: 2),
        color: isActive
            ? const Color.fromARGB(255, 46, 44, 44)
            : const Color(0xFFFFFFFF),
      ),
      alignment: Alignment.center,
      child: InkWell(
        borderRadius: radius,
        onTap: () => _onTapItem(index),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 20),
          child: Text(
            categories[index]['text'].toString(),
            style: TextStyle(
              color: isActive
                  ? const Color(0xFFFFFFFF)
                  : const Color.fromARGB(255, 46, 44, 44),
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildProductsGridView() {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Expanded(
        child: ListView.builder(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: demoProducts.length,
          scrollDirection: Axis.vertical,
          /*  gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 200,
              childAspectRatio: 3 / 2,
              crossAxisSpacing: 6,
              mainAxisSpacing: 150),*/
          itemBuilder: ((context, index) {
            return ProdcutCardTest(product: demoProducts[index]);
          }),
        ),
      ),
    );
  }
}*/

class ProdcutCardTest extends StatelessWidget {
  const ProdcutCardTest({Key? key, required this.product}) : super(key: key);
  final BridellaProduct product;

  @override
  Widget build(BuildContext context) {
    bool isJpg = product.productImgs['1'].toString().contains('.jpg');
    return Container(
      width: getProportionateScreenWidth(370),
      // height: getProportionateScreenWidth(80),
      padding: EdgeInsets.all(getProportionateScreenWidth(8)),
      child: GestureDetector(
        onTap: () => Navigator.pushNamed(
          context,
          DetailsScreen.routeName,
          arguments: ProductDetailsArguments(product: product),
        ),
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: isJpg ? null : const EdgeInsets.all(kDefaultPaddin),
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
                      tag: product.productId,
                      child: AspectRatio(
                          aspectRatio: 1.7,
                          child: Image.asset(product.productImgs['1']))),
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          product.productName,
                          style: const TextStyle(color: Colors.black),
                          maxLines: 2,
                        ),
                        Text(
                          "\$${product.productPrice}",
                          style: TextStyle(
                            fontSize: getProportionateScreenWidth(18),
                            fontWeight: FontWeight.w600,
                            color: kPrimaryColor,
                          ),
                        ),
                      ],
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
            Positioned(right: 20, top: 15, child: ratingChunk())
          ],
        ),
      ),
    );
  }

  Widget ratingChunk() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 4),
      decoration: BoxDecoration(
        color: kSecondaryColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        children: [
          const Text(
            "4.5",
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(width: 5),
          SvgPicture.asset(
            "assets/icons/Star Icon.svg",
            color: Colors.orange,
          ),
        ],
      ),
    );
  }
}
