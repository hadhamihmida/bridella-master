import 'package:bridella/cart/models/cart.dart';
import 'package:bridella/planner/models/budget.dart';
import 'package:bridella/planner/models/task.dart';
import 'package:bridella/planner/services/budget_db.dart';
import 'package:bridella/social/models/social.dart';
import 'package:bridella/social/services/social_db.dart';
import 'package:bridella/wishes/services/wish_db.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../app_core/bridella_app.dart';
import '../business/models/business.dart';
import '../business/models/market_place.dart';
import '../business/services/business_db.dart';
import '../business/services/market_place_db.dart';
import '../planner/services/task_db.dart';
import '../users/models/user.dart';
import '../wishes/models/wish.dart';

class BridellaMultiProvider extends StatelessWidget {
  static String routeName = "/multi_providers";
  const BridellaMultiProvider({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<User?>(context);
    final bride = Provider.of<BridellaUser?>(context);

    return MultiProvider(
      providers: [
        /// providing the list of wishes of the current user
        /// todo: provide all the shared wishist for a groupe of users
        /// then filter them for evrey use case
        StreamProvider<List<Wish>?>.value(
            value: auth != null && bride != null
                ? WishDataBase().wishesFromFirestore(auth.email!)
                : null,
            initialData: const []),

        // providing list of posts of current user
        StreamProvider<List<Post>?>.value(
            value: auth != null && bride != null
                ? WishDataBase().postsFromFireStore()
                : null,
            initialData: const []),

        // providing list of tasks of current user
        StreamProvider<List<Task>?>.value(
            value: auth != null && bride != null
                ? TaskDataBase().tasksFromFirestore(auth.uid)
                : null,
            initialData: const []),
        // providing the Budget of current user
        StreamProvider<Budget?>.value(
            value: auth != null && bride != null
                ? BudgetDB().budgetFromFirebase(auth.uid)
                : null,
            initialData: null),
        // providing the user social : it contains friends and friend requests
        StreamProvider<Social?>.value(
            value: auth != null && bride != null
                ? SocialDataBase().socialStream(auth.email!)
                : null,
            initialData: null),
        // providing the list of chats
        /*  StreamProvider<List<Chat>?>.value(
            value: auth != null && bride != null
                ? SocialDataBase().recentChats(bride.chatsIds ?? [])
                : null,
            initialData: null),*/
        // providing the list of market places
        StreamProvider<List<MarketPlace>?>.value(
            value: auth != null && bride != null
                ? MenuDatabaseServices().mpListStream()
                : null,
            initialData: null),
        // providing the list of businesses
        StreamProvider<List<Business>?>.value(
            value: auth != null && bride != null
                ? BusinessDataBase().firestoreProBusinessListStream()
                : null,
            initialData: null),
        // providing the cart
        ChangeNotifierProvider(create: (context) => BridellaCart()),
      ],
      child: const Bridella(),
    );
  }
}
