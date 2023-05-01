import 'package:flutter/material.dart';

import 'app_core/services/constants.dart';
import 'business/models/market_place.dart';

List<Map<String, dynamic>> categories = [
  {"icon": "assets/icons/Flash Icon.svg", "text": "Flash Deal"},
  {"icon": "assets/icons/Bill Icon.svg", "text": "Bill"},
  {"icon": "assets/icons/Game Icon.svg", "text": "Game"},
  {"icon": "assets/icons/Gift Icon.svg", "text": "Daily Gift"},
  {"icon": "assets/icons/Discover.svg", "text": "More"},
  {"icon": "assets/icons/Discover.svg", "text": "More"},
  {"icon": "assets/icons/Discover.svg", "text": "More"},
  {"icon": "assets/icons/Discover.svg", "text": "More"},
  {"icon": "assets/icons/Discover.svg", "text": "More"},
  {"icon": "assets/icons/Discover.svg", "text": "More"},
  {"icon": "assets/icons/Discover.svg", "text": "More"},
  {"icon": "assets/icons/Discover.svg", "text": "More"},
];
List<Map<String, dynamic>> wishlist = [
  {
    "description": "Ma7leha 💗 Support me guys xD.",
    "image": "assets/testImages/book_case@2x.png",
    "createdAt": "",
    "user_uid": "Bill",
    "avatar": "assets/testImages/Profile Image.jpg",
    "name": "Rihab Hmeda"
  },
  {
    "description": "Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
    "image": "assets/testImages/plastic_chair@2x.png",
    "createdAt": "",
    "user_uid": "Bill",
    "avatar": "assets/testImages/Profile Image.jpg",
    "name": "Rihab Hmeda"
  },
];
List<BridellaProduct> favouriteList = [];

List<BridellaProduct> demothreeProducts = [
  BridellaProduct(
      productId: '01',
      productAvailable: true,
      productImgs: {
        '0': "assets/testImages/p1.png",
        '1': "assets/testImages/p2.png",
        '2': "assets/testImages/test3.jpg",
        '3': "assets/testImages/test4.jpg",
      },
      productName: 'Lipstick HINDASH',
      productPrice: 10,
      promoPrice: 9,
      inPromo: false,
      shortDesc: 'description',
      longDesc:
          '''Lorem ipsum dolor sit amet, consectetur adipiscing elit. Etiam tempor porta elementum. Praesent tempor blandit enim eget ultricies. Integer dapibus hendrerit massa ac hendrerit. Nunc quis tellus eleifend, rhoncus velit posuere, volutpat felis. Fusce a diam ac magna lacinia fringilla. Mauris dui sem, ornare nec massa ac, dignissim eleifend magna. Etiam sed lorem eget ipsum eleifend maximus vel et purus. Ut dapibus lacus volutpat, maximus nisi ac, commodo erat.''',
      ratingScore: 4.9,
      options: {
        '0': const Color(0xFFF6625E),
        '1': const Color(0xFF836DB8),
        '2': const Color(0xFFDECB9C),
        '3': bridellaBGColor,
      }),
  BridellaProduct(
      productId: '02',
      productAvailable: true,
      productImgs: {
        '0': "assets/testImages/ps4_console_white_1.png",
        '1': "assets/testImages/ps4_console_white_2.png",
        '2': "assets/testImages/ps4_console_white_3.png",
        '3': "assets/testImages/ps4_console_white_4.png",
      },
      productName: 'product 2',
      productPrice: 55,
      promoPrice: 25,
      inPromo: false,
      shortDesc: 'description',
      longDesc: '''
Lorem ipsum dolor sit amet, consectetur adipiscing elit. 
Etiam tempor porta elementum. Praesent tempor blandit enim eget ultricies.
 Integer dapibus hendrerit massa ac hendrerit. Nunc quis tellus eleifend, 
 rhoncus velit posuere, volutpat felis. Fusce a diam ac magna lacinia fringilla.
  Mauris dui sem, ornare nec massa ac, dignissim eleifend magna. Etiam sed lorem
   eget ipsum eleifend maximus vel et purus.
 Ut dapibus lacus volutpat, maximus nisi ac, commodo erat.
''',
      ratingScore: 4.9,
      options: {
        '0': const Color(0xFFF6625E),
        '1': const Color(0xFF836DB8),
        '2': const Color(0xFFDECB9C),
        '3': bridellaBGColor,
      }),
  BridellaProduct(
      productId: '03',
      productAvailable: true,
      productImgs: {
        '0': "assets/testImages/sofa.png",
      },
      productName: 'Sofa',
      productPrice: 5,
      promoPrice: 3,
      inPromo: false,
      shortDesc: 'description',
      longDesc:
          '''Lorem ipsum dolor sit amet, consectetur adipiscing elit. Etiam tempor porta elementum. Praesent tempor blandit enim eget ultricies. Integer dapibus hendrerit massa ac hendrerit. Nunc quis tellus eleifend, rhoncus velit posuere, volutpat felis. Fusce a diam ac magna lacinia fringilla. Mauris dui sem, ornare nec massa ac, dignissim eleifend magna. Etiam sed lorem eget ipsum eleifend maximus vel et purus. Ut dapibus lacus volutpat, maximus nisi ac, commodo erat.''',
      ratingScore: 4.9,
      options: {
        '0': const Color(0xFFF6625E),
        '1': const Color(0xFF836DB8),
        '2': const Color(0xFFDECB9C),
        '3': bridellaBGColor,
      }),
];
List<BridellaProduct> demoProducts = [
  BridellaProduct(
      productId: '01',
      productAvailable: true,
      productImgs: {
        '0': "assets/testImages/test1.jpg",
        '1': "assets/testImages/test2.jpg",
        '2': "assets/testImages/test3.jpg",
        '3': "assets/testImages/test4.jpg",
      },
      productName: 'product 1',
      productPrice: 10,
      promoPrice: 9,
      inPromo: false,
      shortDesc: 'description',
      longDesc:
          '''Lorem ipsum dolor sit amet, consectetur adipiscing elit. Etiam tempor porta elementum. Praesent tempor blandit enim eget ultricies. Integer dapibus hendrerit massa ac hendrerit. Nunc quis tellus eleifend, rhoncus velit posuere, volutpat felis. Fusce a diam ac magna lacinia fringilla. Mauris dui sem, ornare nec massa ac, dignissim eleifend magna. Etiam sed lorem eget ipsum eleifend maximus vel et purus. Ut dapibus lacus volutpat, maximus nisi ac, commodo erat.''',
      ratingScore: 4.9,
      options: {
        '0': const Color(0xFFF6625E),
        '1': const Color(0xFF836DB8),
        '2': const Color(0xFFDECB9C),
        '3': bridellaBGColor,
      }),
  BridellaProduct(
      productId: '01',
      productAvailable: true,
      productImgs: {
        '0': "assets/testImages/ps4_console_white_1.png",
        '1': "assets/testImages/ps4_console_white_2.png",
        '2': "assets/testImages/ps4_console_white_3.png",
        '3': "assets/testImages/ps4_console_white_4.png",
      },
      productName: 'product 1',
      productPrice: 10,
      promoPrice: 9,
      inPromo: false,
      shortDesc: 'description',
      longDesc:
          '''Lorem ipsum dolor sit amet, consectetur adipiscing elit. Etiam tempor porta elementum. Praesent tempor blandit enim eget ultricies. Integer dapibus hendrerit massa ac hendrerit. Nunc quis tellus eleifend, rhoncus velit posuere, volutpat felis. Fusce a diam ac magna lacinia fringilla. Mauris dui sem, ornare nec massa ac, dignissim eleifend magna. Etiam sed lorem eget ipsum eleifend maximus vel et purus. Ut dapibus lacus volutpat, maximus nisi ac, commodo erat.''',
      ratingScore: 4.9,
      options: {
        '0': const Color(0xFFF6625E),
        '1': const Color(0xFF836DB8),
        '2': const Color(0xFFDECB9C),
        '3': bridellaBGColor,
      }),
  BridellaProduct(
      productId: '01',
      productAvailable: true,
      productImgs: {
        '0': "assets/testImages/ps4_console_white_1.png",
        '1': "assets/testImages/ps4_console_white_2.png",
        '2': "assets/testImages/ps4_console_white_3.png",
        '3': "assets/testImages/ps4_console_white_4.png",
      },
      productName: 'product 1',
      productPrice: 10,
      promoPrice: 9,
      inPromo: false,
      shortDesc: 'description',
      longDesc:
          '''Lorem ipsum dolor sit amet, consectetur adipiscing elit. Etiam tempor porta elementum. Praesent tempor blandit enim eget ultricies. Integer dapibus hendrerit massa ac hendrerit. Nunc quis tellus eleifend, rhoncus velit posuere, volutpat felis. Fusce a diam ac magna lacinia fringilla. Mauris dui sem, ornare nec massa ac, dignissim eleifend magna. Etiam sed lorem eget ipsum eleifend maximus vel et purus. Ut dapibus lacus volutpat, maximus nisi ac, commodo erat.''',
      ratingScore: 4.9,
      options: {
        '0': const Color(0xFFF6625E),
        '1': const Color(0xFF836DB8),
        '2': const Color(0xFFDECB9C),
        '3': bridellaBGColor,
      }),
  BridellaProduct(
      productId: '001',
      productAvailable: true,
      productImgs: {
        '0': "assets/testImages/ps4_console_white_1.png",
        '1': "assets/testImages/ps4_console_white_2.png",
        '2': "assets/testImages/ps4_console_white_3.png",
        '3': "assets/testImages/ps4_console_white_4.png",
      },
      productName: 'product 1',
      productPrice: 10,
      promoPrice: 9,
      inPromo: false,
      shortDesc: 'description',
      longDesc:
          '''Lorem ipsum dolor sit amet, consectetur adipiscing elit. Etiam tempor porta elementum. Praesent tempor blandit enim eget ultricies. Integer dapibus hendrerit massa ac hendrerit. Nunc quis tellus eleifend, rhoncus velit posuere, volutpat felis. Fusce a diam ac magna lacinia fringilla. Mauris dui sem, ornare nec massa ac, dignissim eleifend magna. Etiam sed lorem eget ipsum eleifend maximus vel et purus. Ut dapibus lacus volutpat, maximus nisi ac, commodo erat.''',
      ratingScore: 4.9,
      options: {
        '0': const Color(0xFFF6625E),
        '1': const Color(0xFF836DB8),
        '2': const Color(0xFFDECB9C),
        '3': bridellaBGColor,
      }),
  BridellaProduct(
      productId: '0001',
      productAvailable: true,
      productImgs: {
        '0': "assets/testImages/ps4_console_white_1.png",
        '1': "assets/testImages/ps4_console_white_2.png",
        '2': "assets/testImages/ps4_console_white_3.png",
        '3': "assets/testImages/ps4_console_white_4.png",
      },
      productName: 'product 1',
      productPrice: 10,
      promoPrice: 9,
      inPromo: false,
      shortDesc: 'description',
      longDesc:
          '''Lorem ipsum dolor sit amet, consectetur adipiscing elit. Etiam tempor porta elementum. Praesent tempor blandit enim eget ultricies. Integer dapibus hendrerit massa ac hendrerit. Nunc quis tellus eleifend, rhoncus velit posuere, volutpat felis. Fusce a diam ac magna lacinia fringilla. Mauris dui sem, ornare nec massa ac, dignissim eleifend magna. Etiam sed lorem eget ipsum eleifend maximus vel et purus. Ut dapibus lacus volutpat, maximus nisi ac, commodo erat.''',
      ratingScore: 4.9,
      options: {
        '0': const Color(0xFFF6625E),
        '1': const Color(0xFF836DB8),
        '2': const Color(0xFFDECB9C),
        '3': bridellaBGColor,
      }),
  BridellaProduct(
      productId: '01',
      productAvailable: true,
      productImgs: {
        '0': "assets/testImages/ps4_console_white_1.png",
        '1': "assets/testImages/ps4_console_white_2.png",
        '2': "assets/testImages/ps4_console_white_3.png",
        '3': "assets/testImages/ps4_console_white_4.png",
      },
      productName: 'product 1',
      productPrice: 10,
      promoPrice: 9,
      inPromo: false,
      shortDesc: 'description',
      longDesc:
          '''Lorem ipsum dolor sit amet, consectetur adipiscing elit. Etiam tempor porta elementum. Praesent tempor blandit enim eget ultricies. Integer dapibus hendrerit massa ac hendrerit. Nunc quis tellus eleifend, rhoncus velit posuere, volutpat felis. Fusce a diam ac magna lacinia fringilla. Mauris dui sem, ornare nec massa ac, dignissim eleifend magna. Etiam sed lorem eget ipsum eleifend maximus vel et purus. Ut dapibus lacus volutpat, maximus nisi ac, commodo erat.''',
      ratingScore: 4.9,
      options: {
        '0': const Color(0xFFF6625E),
        '1': const Color(0xFF836DB8),
        '2': const Color(0xFFDECB9C),
        '3': bridellaBGColor,
      }),
  BridellaProduct(
    productId: '02',
    productAvailable: true,
    productImgs: {
      '0': "assets/testImages/ps4_console_white_1.png",
      '1': "assets/testImages/ps4_console_white_2.png",
      '2': "assets/testImages/ps4_console_white_3.png",
      '3': "assets/testImages/ps4_console_white_4.png",
    },
    productName: 'product 2',
    productPrice: 55,
    promoPrice: 25,
    inPromo: false,
    shortDesc: 'description',
    longDesc: '''
Lorem ipsum dolor sit amet, consectetur adipiscing elit. 
Etiam tempor porta elementum. Praesent tempor blandit enim eget ultricies.
 Integer dapibus hendrerit massa ac hendrerit. Nunc quis tellus eleifend, 
 rhoncus velit posuere, volutpat felis. Fusce a diam ac magna lacinia fringilla.
  Mauris dui sem, ornare nec massa ac, dignissim eleifend magna. Etiam sed lorem
   eget ipsum eleifend maximus vel et purus.
 Ut dapibus lacus volutpat, maximus nisi ac, commodo erat.
''',
    ratingScore: 4.9,
  ),
  BridellaProduct(
    productId: '03',
    productAvailable: true,
    productImgs: {
      '0': "assets/testImages/ps4_console_white_1.png",
      '1': "assets/testImages/ps4_console_white_2.png",
      '2': "assets/testImages/ps4_console_white_3.png",
      '3': "assets/testImages/ps4_console_white_4.png",
    },
    productName: 'product 3',
    productPrice: 5,
    promoPrice: 3,
    inPromo: false,
    shortDesc: 'description',
    longDesc:
        '''Lorem ipsum dolor sit amet, consectetur adipiscing elit. Etiam tempor porta elementum. Praesent tempor blandit enim eget ultricies. Integer dapibus hendrerit massa ac hendrerit. Nunc quis tellus eleifend, rhoncus velit posuere, volutpat felis. Fusce a diam ac magna lacinia fringilla. Mauris dui sem, ornare nec massa ac, dignissim eleifend magna. Etiam sed lorem eget ipsum eleifend maximus vel et purus. Ut dapibus lacus volutpat, maximus nisi ac, commodo erat.''',
    ratingScore: 4.9,
  ),
];

List<Map<String, dynamic>> bizListt = [
  {
    'name': 'Fatales',
    'image': 'assets/testImages/b1.jpg',
    'score': 4.9,
    'description': 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.'
  },
  {
    'name': 'Meublatex',
    'image': 'assets/testImages/b2.jpg',
    'score': 4.8,
    'description':
        'Lorem ipsum dolor sit amet, consectetur adipiscing elit.Etiam tempor porta elementum'
  }
];

class UserPreferences {
  static const myUser = TestUser(
    imagePath:
        'https://images.unsplash.com/photo-1554151228-14d9def656e4?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=333&q=80',
    name: 'Sarah Abs',
    email: 'sarah.abs@gmail.com',
    about:
        'Certified Personal Trainer and Nutritionist with years of experience in creating effective diets and training plans focused on achieving individual customers goals in a smooth way.',
    isDarkMode: false,
  );
}

final urlImages = [
  'https://images.unsplash.com/photo-1554151228-14d9def656e4?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=633&q=80',
  'https://images.unsplash.com/photo-1494790108377-be9c29b29330?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=634&q=80',
  'https://images.unsplash.com/photo-1616766098956-c81f12114571?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=634&q=80',
];

class TestUser {
  final String imagePath;
  final String name;
  final String email;
  final String about;
  final bool isDarkMode;

  const TestUser({
    required this.imagePath,
    required this.name,
    required this.email,
    required this.about,
    required this.isDarkMode,
  });
}

final List tasksList = [
  {
    "title": "This is the title ",
    "subtitle": "This is the subtitle ",
    "isActive": false,
  },
  {
    "title": "This is the title ",
    "subtitle": "This is the subtitle ",
    "isActive": false,
  },
  {
    "title": "This is the title ",
    "subtitle": "This is the subtitle ",
    "isActive": true,
  },
  {
    "title": "This is the title ",
    "subtitle": "This is the subtitle ",
    "isActive": true,
  },
  {
    "title": "This is the title ",
    "subtitle": "This is the subtitle ",
    "isActive": true,
  }
];
