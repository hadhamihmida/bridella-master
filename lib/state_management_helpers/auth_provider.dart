import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../authentication/services/auth_services.dart';
import 'bridella_user_provider.dart';

class BridellaAuthProvider extends StatelessWidget {
  static String routeName = "/auth_provider";
  const BridellaAuthProvider({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<FirebaseAuthMethods>(
          create: (_) => FirebaseAuthMethods(FirebaseAuth.instance),
        ),
        StreamProvider(
          create: (context) => context.read<FirebaseAuthMethods>().authState,
          initialData: null,
        ),
      ],
      child: const BridellaUserProvider(),
    );

    /* StreamProvider<User?>.value(
      initialData: null,
      value: FirebaseAuth.instance.authStateChanges(),
      child: const BridellaUserProvider(),
    );*/
  }
}
