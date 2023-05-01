class Business {
  final String businessId;
  final String businessType;
  final String businessName;
  final String businessDesc;
  final String addressLine;
  final String city;
  final String postCode;
  final String country;
  final List<dynamic> infoPhone;
  final List<dynamic> imgGallery;
  final String email;
  final String logo;
  final String bannerImage;
  final double ratingScore;
  final int ratingNumbers;
  final Map<String, dynamic> marketplace;
  final List payMethods;
  final bool visible;

  Business(
      {required this.businessId,
      required this.businessType,
      required this.businessName,
      required this.businessDesc,
      required this.addressLine,
      required this.city,
      required this.postCode,
      required this.country,
      required this.infoPhone,
      required this.email,
      required this.logo,
      required this.imgGallery,
      required this.bannerImage,
      required this.ratingScore,
      required this.ratingNumbers,
      required this.marketplace,
      required this.payMethods,
      required this.visible});
}
