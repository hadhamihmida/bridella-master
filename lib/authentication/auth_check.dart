import 'package:bridella/app_core/screens/Bridella_Scaffold.dart';
import 'package:bridella/onBoarding/on_boarding_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AuthWrapper extends StatelessWidget {
  const AuthWrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final firebaseUser = context.watch<User?>();

    if (firebaseUser != null) {
      return const BridellaScaffold();
    }
    return const OnBoardingScreen();
  }
}
