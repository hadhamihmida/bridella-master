import 'package:bridella/business/models/market_place.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MenuDatabaseServices {
  // firestore references
  final CollectionReference _mp =
      FirebaseFirestore.instance.collection('marketplace');
  final CollectionReference _orders =
      FirebaseFirestore.instance.collection('orders');

  ///Create MarketPlace object from firestore
/*  MarketPlace? marketPlacefromFireStore(DocumentSnapshot doc) {
    if (doc.exists) {
      Map<String, dynamic> marketPlace = doc.data() as Map<String, dynamic>;

      /// create [BridellaCategory] list from market place data
      Map<String, dynamic> categoriesMap = marketPlace['categories'];
      List<BridellaCategory> bridellaCategories =
          List<BridellaCategory>.from(categoriesMap.entries.map((category) {
        Map<String, dynamic> categoryData = category.value;
        List itemsList = categoryData['items'] ?? [""];
        return BridellaCategory(
            catId: category.key,
            catPos: categoryData['catPos'] ?? 0,
            catName: categoryData['catName'] ?? "",
            catImg: categoryData['catImg'] ?? "",
            catAvail: categoryData['catAvail'] ?? true,
            items: itemsList.cast<String>());
      }))
            ..sort();

      /// create [BridellaProduct] list market place data
      Map<String, dynamic> productsMap = marketPlace['items'];

      List<BridellaProduct> bridellaProducts =
          List<BridellaProduct>.from(productsMap.entries.map((product) {
        Map<String, dynamic> productData = product.value;
        num productPrice = productData['productPrice'] ?? 0;
        num promoPrice = productData['promoPrice'] ?? 0;
        return BridellaProduct(
            productId: product.key,
            productName: productData['productName'] ?? '',
            productPrice: productPrice.toDouble(),
            shortDesc: productData['shortDesc'] ?? '',
            longDesc: productData['longDesc'] ?? '',
            inPromo: productData['inPromo'] ?? false,
            promoPrice: promoPrice.toDouble(),
            ratingScore: productData['ratingScore'] ?? 5,
            productAvailable: productData['available'] ?? true,
            productImgs: productData['productImgs'] ?? {},
            options: productData['iOpt'] ?? {});
      }));

      /// create [option] list from market place data
      /*  Map<String, dynamic> optionsMap = marketPlace['options'];
      List<BridellaOptions> bridellaOptions =
          List<BridellaOptions>.from(optionsMap.entries.map((option) {
        Map<String, dynamic> optData = option.value;
        List choices = optData['choices'] ?? [];

        return BridellaOptions(
            optionId: option.key,
            optionName: optData['optionName'] ?? "",
            defaultChoice: optData['defChoice'] ?? "",
            choices: choices.cast<String>());
      }));*/

      return MarketPlace(
          businessId: marketPlace['businessId'],
          categories: bridellaCategories,
          products: bridellaProducts,
          options: [],
          providerCat: marketPlace['providerCat']);
    } else {
      return null;
    }
  }

  ///Firestore MarketPlace Stream
  Stream<MarketPlace?> marketPlaceStream(String bid, String mid) =>
      _mp.doc(mid).snapshots().map(marketPlacefromFireStore);*/
// this is used
  Stream<List<MarketPlace>>? mpListStream() {
    try {
      return _mp.snapshots().map((markets) => markets.docs.map((doc) {
            Map<String, dynamic> marketPlace =
                doc.data() as Map<String, dynamic>;

            /// create [BridellaCategory] list from market place data
            Map<String, dynamic> categoriesMap =
                marketPlace['categories'] is Map<String, dynamic>
                    ? marketPlace['categories']
                    : {};
            List<BridellaCategory> bridellaCategories =
                List<BridellaCategory>.from(
                    categoriesMap.entries.map((category) {
              Map<String, dynamic> categoryData = category.value;
              Map<String, dynamic> itemMap = categoryData['items'] ?? {};
              List<String> itemsList = [];
              itemMap.forEach((k, v) => itemsList.add(v));
              num catPos =
                  categoryData['catPos'] is num ? categoryData['catPos'] : 0;
              return BridellaCategory(
                  catId: category.key,
                  catPos: catPos.toInt(),
                  catName: categoryData['catName'] is String
                      ? categoryData['catName']
                      : "",
                  //catDesc: categoryData['catDesc'] ?? "",
                  catImg: categoryData['catIcon'] is String
                      ? categoryData['catIcon']
                      : "",
                  catAvail: categoryData['catAvailable'] is bool
                      ? categoryData['catAvailable']
                      : true,
                  items: itemsList);
            }));

            /// create [BridellaProduct] list market place data
            Map<String, dynamic> productsMap =
                marketPlace['items'] is Map<String, dynamic>
                    ? marketPlace['items']
                    : {};

            List<BridellaProduct> bridellaProducts =
                List<BridellaProduct>.from(productsMap.entries.map((product) {
              Map<String, dynamic> productData = product.value;
              num productPrice =
                  productData['price'] is num ? productData['price'] : 0;
              num promoPrice = productData['promoPrice'] is num
                  ? productData['promoPrice']
                  : 0;
              return BridellaProduct(
                productId: product.key,
                productName: productData['name'] is String
                    ? productData['name']
                    : 'Bridella Product',
                productPrice: productPrice.toDouble(),
                shortDesc: productData['shortDesc'] is String
                    ? productData['shortDesc']
                    : 'No description for the moment',
                longDesc: productData['longDesc'] is String
                    ? productData['longDesc']
                    : 'No description for the moment',
                inPromo: productData['inPromo'] is bool
                    ? productData['inPromo']
                    : false,
                promoPrice: promoPrice.toDouble(),
                ratingScore: 5,
                productAvailable: productData['available'] is bool
                    ? productData['available']
                    : true,
                productImgs: productData['imgs'] is Map<String, dynamic>
                    ? productData['imgs']
                    : {},
                options: productData['options'] is Map<String, dynamic>
                    ? productData['options']
                    : {},
              );
            }));

            /// create [option] list from market place data
            /*    Map<String, dynamic> optionsMap = marketPlace['options'];
         List<BridellaOptions> bridellaOptions =
              List<BridellaOptions>.from(optionsMap.entries.map((option) {
            Map<String, dynamic> optData = option.value;
            List choices = optData['choices'] ?? [];

            return BridellaOptions(
                optionId: option.key,
                optionName: optData['optionName'] ?? "",
                defaultChoice: optData['defChoice'] ?? "",
                choices: choices.cast<String>());
          }));*/

            return MarketPlace(
              // currency: marketPlace['currency'] ?? "dt",
              businessId: marketPlace['businessId'] is String
                  ? marketPlace['businessId']
                  : '',
              categories: bridellaCategories,
              products: bridellaProducts,
              options: [],
              providerCat: marketPlace['providerCat'] is String
                  ? marketPlace['providerCat']
                  : '',
            );
          }).toList());
    } catch (e) {
      print(e);
    }
  }

// confirm an order
  Future confirmOrder(Map<String, dynamic> orderData) async {
    await _orders.doc().set(orderData);
  }
}
