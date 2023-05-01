import 'package:bridella/users/models/bride.dart';
import 'package:bridella/users/models/user.dart';
import 'package:bridella/users/services/user_db.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'multi_providers.dart';

class BridellaUserProvider extends StatelessWidget {
  const BridellaUserProvider({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<User?>(context);
    return StreamProvider<BridellaUser?>.value(
      value: auth != null
          ? BridellaUserDbServices().firestoreBrideStream(auth.uid)
          : null,
      initialData: null,
      child: const BridellaMultiProvider(),
    );
  }
}
