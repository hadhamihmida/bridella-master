import 'package:bridella/app_core/services/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../models/user.dart';

class BridellaUserDbServices {
  final CollectionReference users =
      FirebaseFirestore.instance.collection('users');

  //Create serviniownerUser object from database
  BridellaUser? brideUserFromFireStore(DocumentSnapshot snapshot) {
    if (snapshot.exists) {
      Map<String, dynamic> brideUser = snapshot.data() as Map<String, dynamic>;

      return BridellaUser(
        uid: brideUser['uid'],
        displayName: brideUser['displayName'] ?? 'Anonymous',
        accType: stringToEnum(brideUser['accType']),
        urlAvatar: brideUser['urlAvatar'],
        partnerAvatar: brideUser['partnerAvatar'],
        bio: brideUser['bio'] ?? "Hey I'm using Bridella",
        email: brideUser['email'] ?? 'not defined',
        firstName: brideUser['firstName'] ?? 'not defined',
        lastName: brideUser['lastName'] ?? 'not defined',
        gender: brideUser['gender'] ?? 'not defined',
        phoneNumber: brideUser['phoneNumber'] ?? 'not defined',
        verfied: brideUser['verified'] ?? false,
        address: brideUser['address'] ?? '',
        weddingDate: brideUser['weddingDate'] ?? '',
      );

      // if we gonna acess the object from this object we define it as a list else as a map
    } else {
      return null;
    }
  }

  //Database serviniownerUser stream
  Stream<BridellaUser?> firestoreBrideStream(String uid) {
    return users.doc(uid).snapshots().map(brideUserFromFireStore);
  }

  //Create new user profile entry
  Future createNewUser(User user, String accType, String? weddingDate) async {
    return await users.doc(user.uid).set({
      'uid': user.uid,
      'accType': accType,
      'displayName': user.displayName,
      'email': user.email,
      'urlAvatar': user.photoURL ??
          'https://firebasestorage.googleapis.com/v0/b/bridella-eb876.appspot.com/o/users%2Fv2.png?alt=media&token=40d9e936-a88d-46f8-87b6-e07db6c9b3cc',
      'partnerAvatar':
          'https://firebasestorage.googleapis.com/v0/b/bridella-eb876.appspot.com/o/users%2Fv2.png?alt=media&token=40d9e936-a88d-46f8-87b6-e07db6c9b3cc',
      'firstName': null,
      'lastName': null,
      'gender': accType == 'groom'
          ? 'male'
          : accType == 'bride'
              ? 'female'
              : null,
      'address': null,
      'phoneNumber': null,
      'bio': null,
      'verified': false,
      'weddingDate': weddingDate,
    });
  }

  //Update user profile
  Future updateUserInfo(String uid, Map<String, dynamic> userInfo) async {
    return await users.doc(uid).update(userInfo);
  }
}

AcountType? stringToEnum(String s) {
  switch (s) {
    case 'bride':
      return AcountType.bride;
    case 'groom':
      return AcountType.groom;
    case 'guest':
      return AcountType.guest;
  }
  return null;
}
