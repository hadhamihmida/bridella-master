import 'package:bridella/app_core/screens/Bridella_Scaffold.dart';
import 'package:bridella/app_core/services/bridella_settings.dart';
import 'package:bridella/app_core/services/routes.dart';
import 'package:bridella/app_core/services/theme.dart';
import 'package:bridella/guests/screens/guest_scaffold.dart';
import 'package:bridella/onBoarding/on_boarding_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:streaming_shared_preferences/streaming_shared_preferences.dart';

import '../users/models/user.dart';

class Bridella extends StatefulWidget {
  static String routeName = "/";

  const Bridella({
    super.key,
  });

  @override
  State<Bridella> createState() => _BridellaState();
}

class _BridellaState extends State<Bridella> {
  // This widget is the root of the app.
  @override
  Widget build(BuildContext context) {
    final firebaseUser = context.watch<User?>();
    final bridellaUser = Provider.of<BridellaUser?>(context);

    final settings = Provider.of<BridellaSettings>(context, listen: false);
    print('the app is initiallied : $firebaseUser');

    return PreferenceBuilder(
        preference: settings.darkMode,
        builder: (BuildContext context, bool dark) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Bridella',
            theme: bridellaTheme(dark),
            routes: routes,
            home: home(bridellaUser, firebaseUser),
          );
        });
  }
}

Widget home(BridellaUser? user, User? firebaseUser) {
  if (firebaseUser == null) {
    return const OnBoardingScreen();
  } else if (user == null) {
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  } else if (user.accType == AcountType.guest) {
    return const GuestScaffold();
  } else if (user.accType == AcountType.bride ||
      user.accType == AcountType.groom) {
    return const BridellaScaffold();
  }
  return const Center(
    child: CircularProgressIndicator(),
  );
}
