class MarketPlace {
  // final String currency; //  Dinar, $, Bridella Coin, etc.
  final String businessId;
  final List<BridellaCategory> categories;
  final List<BridellaProduct> products;
  final List<BridellaOptions>? options;
  final String providerCat;
  // todo: add a cash banner :)

  MarketPlace(
      {required this.businessId,
      required this.categories,
      required this.products,
      this.options,
      required this.providerCat});
}

class BridellaCategory {
  final String catId;
  final int catPos;
  final String catName;

  final String? catImg;
  final bool catAvail;
  final List<String> items;

  BridellaCategory({
    required this.catId,
    required this.catPos,
    required this.catName,
    required this.catImg,
    required this.catAvail,
    required this.items,
  });
}

class BridellaProduct {
  final String productId;
  final String productName;
  final double productPrice;
  final bool productAvailable;
  final String? shortDesc;
  final String? longDesc;
  final Map<String, dynamic> productImgs;
  final bool inPromo;
  final double promoPrice;

  final double ratingScore;
  final Map<String, dynamic> options;

  BridellaProduct({
    required this.productId,
    required this.productName,
    required this.productPrice,
    required this.shortDesc,
    required this.longDesc,
    required this.inPromo,
    required this.promoPrice,
    required this.ratingScore,
    required this.productAvailable,
    required this.productImgs,

    //
    this.options = const {},
    //
  });
}

class BridellaOptions {
  final String optionId;
  final String optionName;
  final String defaultChoice;
  final List choices;

  BridellaOptions({
    required this.optionId,
    required this.optionName,
    required this.defaultChoice,
    required this.choices,
  });
}
