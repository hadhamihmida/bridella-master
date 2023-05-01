import 'package:bridella/app_core/bridella_app.dart';
import 'package:bridella/app_core/screens/Bridella_Scaffold.dart';
import 'package:bridella/app_core/screens/settings_page.dart';
import 'package:bridella/business/screens/business_list_screen.dart';
import 'package:bridella/business/screens/categories_screen.dart';
import 'package:bridella/cart/screens/checkout_screen.dart';
import 'package:bridella/guests/screens/guest_scaffold.dart';
import 'package:bridella/planner/screens/budget_screen.dart';
import 'package:bridella/social/screens/chat_home.dart';
import 'package:bridella/onBoarding/on_boarding_screen.dart';
import 'package:bridella/state_management_helpers/auth_provider.dart';
import 'package:flutter/widgets.dart';

import '../../authentication/screens/complete_profile_screen.dart';
import '../../authentication/screens/forgot_password_screen.dart';
import '../../cart/screens/order_success_screen.dart';
import '../../authentication/screens/sign_in_screen.dart';
import '../../authentication/screens/sign_up_screen.dart';
import '../../business/screens/market_place_screen.dart';
import '../../cart/screens/cart_screen.dart';
import '../../social/screens/friend_profile.dart';
import '../../social/screens/friends_page.dart';
import '../../planner/widgets/calendar_view.dart';
import '../../state_management_helpers/multi_providers.dart';
import '../../users/screens/edit_profile_page.dart';
import '../../users/screens/favourite_screen.dart';
import '../../users/screens/profile_screen.dart';
import '../../wishes/screens/my_wishlist_screen.dart';
import '../../wishes/screens/timeline_screen.dart';
import '../screens/notifications_page.dart';

// We use name route
// All our routes will be available here
final Map<String, WidgetBuilder> routes = {
  BridellaAuthProvider.routeName: (context) => const BridellaAuthProvider(),
  BridellaMultiProvider.routeName: (context) => const BridellaMultiProvider(),
  OnBoardingScreen.routeName: (context) => const OnBoardingScreen(),
  BridellaScaffold.routeName: (context) => const BridellaScaffold(),
  GuestScaffold.routeName: (context) => const GuestScaffold(),
  SignInScreen.routeName: (context) => const SignInScreen(),
  ForgotPasswordPage.routeName: (context) => const ForgotPasswordPage(),
  OrderSucessScreen.routeName: (context) => const OrderSucessScreen(),
  SignUpScreen.routeName: (context) => const SignUpScreen(),
  CompleteProfileScreen.routeName: (context) => const CompleteProfileScreen(),
  MarketPlaceScreen.routeName: (context) => const MarketPlaceScreen(),
  BusinessListScreen.routeName: (context) => const BusinessListScreen(),

  // ProductsViewScreen.routeName: (context) => const ProductsViewScreen(),
  CartScreen.routeName: (context) => const CartScreen(),
  CategoriesPage.routeName: (context) => CategoriesPage(),
  ProfilePage.routeName: (context) => const ProfilePage(),
  EditProfilePage.routeName: (context) => const EditProfilePage(),
  MywishlistBridge.routeName: (context) => const MywishlistBridge(),
  BudgetPage.routeName: (context) => const BudgetPage(),
  FavouritePage.routeName: (context) => const FavouritePage(),
  SettingPage.routeName: (context) => SettingPage(),
  NotificationsPage.routeName: (context) => const NotificationsPage(),
  //TableEventsExample.routeName: (context) => const TableEventsExample(),
  TimeLinePage.routeName: (context) => const TimeLinePage(),
  ChatHome.routeName: (context) => const ChatHome(),
  // BusinessPage.routeName: (context) => const BusinessPage(),
  FriendsPage.routeName: (context) => const FriendsPage(),
  CheckoutScreen.routeName: (context) => const CheckoutScreen()
};
