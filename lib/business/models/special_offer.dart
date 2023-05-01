class SpecialOffer {
  final String discount;
  final String title;
  final String detail;
  final String icon;

  SpecialOffer({
    required this.discount,
    required this.title,
    required this.detail,
    required this.icon,
  });
}

final homeSpecialOffers = <SpecialOffer>[
  SpecialOffer(
    discount: '25%',
    title: "Today’s Special!",
    detail: 'Get discount for every order, only valid for today',
    icon: 'assets/testImages/sofa.png',
  ),
  SpecialOffer(
    discount: '35%',
    title: "Tomorrow will be better!",
    detail: 'Please give me a star!',
    icon: 'assets/testImages/shiny_chair.png',
  ),
  SpecialOffer(
    discount: '100%',
    title: "Not discount today!",
    detail: 'If you have any problem, contact me',
    icon: 'assets/testImages/lamp.png',
  ),
  SpecialOffer(
    discount: '75%',
    title: "It's for you!",
    detail: 'Wish you have a funny time',
    icon: 'assets/testImages/plastic_chair@2x.png',
  ),
  SpecialOffer(
    discount: '65%',
    title: "Still Waiting!",
    detail: 'Buy now',
    icon: 'assets/testImages/book_case@2x.png',
  ),
];
