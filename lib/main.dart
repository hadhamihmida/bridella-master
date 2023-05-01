import 'dart:convert';

import 'package:bridella/app_core/services/bridella_settings.dart';
import 'package:bridella/state_management_helpers/auth_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:streaming_shared_preferences/streaming_shared_preferences.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  final preferences = await StreamingSharedPreferences.instance;

  runApp(Provider<BridellaSettings>.value(
      value: BridellaSettings(preferences),
      child: const BridellaAuthProvider()));
}

class Firing extends StatefulWidget {
  Firing({Key? key}) : super(key: key);

  @override
  State<Firing> createState() => _FiringState();
}

class _FiringState extends State<Firing> {
  bool pushing = false;
  @override
  Widget build(BuildContext context) {
    DocumentReference mp = FirebaseFirestore.instance
        .collection('marketplace')
        .doc('QpyBTf7Yr8o7VasK6Qo0');

    Future<void> additem() {
      return mp
          .set({
            "items": {
              "model-001": {
                'available': true,
                'name': '',
                'imgs': {
                  '0':
                      'https://firebasestorage.googleapis.com/v0/b/bridella-eb876.appspot.com/o/business%2Fmeublatex%2Fmarketplace%2Fimg%2Fmodel-001.png?alt=media&token=4ea26eff-7226-41f0-b2ed-689a328b1cf7'
                },
                'options': {},
                'longDesc': '',
                'shortDesc': '',
                'inPromo': false,
                'promoPrice': 12,
                'price': 15,
              },
              "model-002": {
                'available': true,
                'name': '',
                'imgs': {
                  '0':
                      'https://firebasestorage.googleapis.com/v0/b/bridella-eb876.appspot.com/o/business%2Fmeublatex%2Fmarketplace%2Fimg%2Fmodel-002.png?alt=media&token=1879b517-9d30-44aa-b2eb-65e1b1be1c48'
                },
                'options': {},
                'longDesc': '',
                'shortDesc': '',
                'inPromo': false,
                'promoPrice': 12,
                'price': 15,
              },
              "model-003": {
                'available': true,
                'name': '',
                'imgs': {
                  '0':
                      'https://firebasestorage.googleapis.com/v0/b/bridella-eb876.appspot.com/o/business%2Fmeublatex%2Fmarketplace%2Fimg%2Fmodel-003.png?alt=media&token=377dd051-a9e9-433f-9d04-290649d53b78'
                },
                'options': {},
                'longDesc': '',
                'shortDesc': '',
                'inPromo': false,
                'promoPrice': 12,
                'price': 15,
              },
              "model-004": {
                'available': true,
                'name': '',
                'imgs': {
                  '0':
                      'https://firebasestorage.googleapis.com/v0/b/bridella-eb876.appspot.com/o/business%2Fmeublatex%2Fmarketplace%2Fimg%2Fmodel-004.png?alt=media&token=d0008283-8f56-4c26-aa0a-4c3d9f019b2d'
                },
                'options': {},
                'longDesc': '',
                'shortDesc': '',
                'inPromo': false,
                'promoPrice': 12,
                'price': 15,
              },
              "dr-model1": {
                'available': true,
                'name': '',
                'imgs': {
                  '0':
                      'https://firebasestorage.googleapis.com/v0/b/bridella-eb876.appspot.com/o/business%2Fmeublatex%2Fmarketplace%2Fimg%2Fdr-model1.png?alt=media&token=bda1aed9-74dd-4793-92e5-cd90bee35169'
                },
                'options': {},
                'longDesc': '',
                'shortDesc': '',
                'inPromo': false,
                'promoPrice': 12,
                'price': 15,
              },
              "dr-model2": {
                'available': true,
                'name': '',
                'imgs': {
                  '0':
                      'https://firebasestorage.googleapis.com/v0/b/bridella-eb876.appspot.com/o/business%2Fmeublatex%2Fmarketplace%2Fimg%2Fdr-model2.jpg?alt=media&token=a5f06350-2f69-4c5c-8469-525143fe7e89'
                },
                'options': {},
                'longDesc': '',
                'shortDesc': '',
                'inPromo': false,
                'promoPrice': 12,
                'price': 15,
              },
              "model-01": {
                'available': true,
                'name': '',
                'imgs': {
                  '0':
                      'https://firebasestorage.googleapis.com/v0/b/bridella-eb876.appspot.com/o/business%2Fmeublatex%2Fmarketplace%2Fimg%2Fmodel-01.png?alt=media&token=a44f9815-d380-4465-adb1-17f5b2270490'
                },
                'options': {},
                'longDesc': '',
                'shortDesc': '',
                'inPromo': false,
                'promoPrice': 12,
                'price': 15,
              },
              "model-02": {
                'available': true,
                'name': '',
                'imgs': {
                  '0':
                      'https://firebasestorage.googleapis.com/v0/b/bridella-eb876.appspot.com/o/business%2Fmeublatex%2Fmarketplace%2Fimg%2Fmodel-04.jpg?alt=media&token=6cdee1de-7c60-4255-8eb4-936c7349c786'
                },
                'options': {},
                'longDesc': '',
                'shortDesc': '',
                'inPromo': false,
                'promoPrice': 12,
                'price': 15,
              },
              "model-03": {
                'available': true,
                'name': '',
                'imgs': {
                  '0':
                      'https://firebasestorage.googleapis.com/v0/b/bridella-eb876.appspot.com/o/business%2Fmeublatex%2Fmarketplace%2Fimg%2Fmodel-03.jpg?alt=media&token=a6c5e249-0ef3-4035-be04-f4d01d34f753'
                },
                'options': {},
                'longDesc': '',
                'shortDesc': '',
                'inPromo': false,
                'promoPrice': 12,
                'price': 15,
              },
              "model-04": {
                'available': true,
                'name': '',
                'imgs': {
                  '0':
                      'https://firebasestorage.googleapis.com/v0/b/bridella-eb876.appspot.com/o/business%2Fmeublatex%2Fmarketplace%2Fimg%2Fmodel-02.png?alt=media&token=b3725b99-eca4-4b65-af35-bebac8c04e1e'
                },
                'options': {},
                'longDesc': '',
                'shortDesc': '',
                'inPromo': false,
                'promoPrice': 12,
                'price': 15,
              },
              "model-1": {
                'available': true,
                'name': '',
                'imgs': {
                  '0':
                      'https://firebasestorage.googleapis.com/v0/b/bridella-eb876.appspot.com/o/business%2Fmeublatex%2Fmarketplace%2Fimg%2Fmodel-1.png?alt=media&token=ac9ab64d-6610-4091-aebd-9a8efa8f0364'
                },
                'options': {},
                'longDesc': '',
                'shortDesc': '',
                'inPromo': false,
                'promoPrice': 12,
                'price': 15,
              },
              "model-2": {
                'available': true,
                'name': '',
                'imgs': {
                  '0':
                      'https://firebasestorage.googleapis.com/v0/b/bridella-eb876.appspot.com/o/business%2Fmeublatex%2Fmarketplace%2Fimg%2Fmodel-1.png?alt=media&token=ac9ab64d-6610-4091-aebd-9a8efa8f0364'
                },
                'options': {},
                'longDesc': '',
                'shortDesc': '',
                'inPromo': false,
                'promoPrice': 12,
                'price': 15,
              },
            }
          }, SetOptions(merge: true))
          .then((value) => print("item Added"))
          .catchError((error) => print("Failed to add item: $error"));
    }

    read() => FutureBuilder<DocumentSnapshot>(
          future: mp.get(),
          builder:
              (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
            if (snapshot.hasError) {}

            if (snapshot.hasData && !snapshot.data!.exists) {}

            if (snapshot.connectionState == ConnectionState.done) {
              Map<String, dynamic> data =
                  snapshot.data!.data() as Map<String, dynamic>;

              var encoder = const JsonEncoder.withIndent("     ");
              //  encoder.convert(data);
              print(encoder.convert(data));
            }

            return Text("loading");
          },
        );
    return MaterialApp(
        home: Scaffold(
            body: ElevatedButton(
      onPressed: () => additem(),
      child: const Text('set'),
    )));
  }
}
