import 'package:bridella/authentication/screens/sign_in_screen.dart';
import 'package:bridella/guests/screens/guest_scaffold.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../app_core/screens/Bridella_Scaffold.dart';
import '../../app_core/services/show_snackbar.dart';
import '../../state_management_helpers/auth_provider.dart';
import '../../users/services/user_db.dart';

class FirebaseAuthMethods {
  final FirebaseAuth _auth;
  FirebaseAuthMethods(this._auth);

  // FOR EVERY FUNCTION HERE
  // POP THE ROUTE USING: Navigator.of(context).pushNamedAndRemoveUntil('/', (Route<dynamic> route) => false);

  // GET USER DATA
  // using null check operator since this method should be called only
  // when the user is logged in
  User get user => _auth.currentUser!;

  // STATE PERSISTENCE STREAM
  Stream<User?> get authState => FirebaseAuth.instance.authStateChanges();
  // OTHER WAYS (depends on use case):
  // Stream get authState => FirebaseAuth.instance.userChanges();
  // Stream get authState => FirebaseAuth.instance.idTokenChanges();
  // KNOW MORE ABOUT THEM HERE: https://firebase.flutter.dev/docs/auth/start#auth-state
  final CollectionReference _social =
      FirebaseFirestore.instance.collection('social');
  // EMAIL SIGN UP
  Future signUpWithEmail({
    required String email,
    required String password,
    required String accType,
    required String? weddingDate,
    required BuildContext context,
  }) async {
    try {
      await _auth
          .createUserWithEmailAndPassword(
        email: email,
        password: password,
      )
          .then((value) {
        UserCredential userCredential = value;
        User? user = userCredential.user;
        userCredential.additionalUserInfo!.isNewUser
            ? user != null
                ? BridellaUserDbServices().createNewUser(
                    user,
                    accType,
                    weddingDate,
                  )
                : null
            : null;
        // create a social doc for the user using his id
        user != null
            ? _social
                .doc(user.email)
                .set({'friends': {}, 'friend-requests': {}})
            : null;

        showSnackBar(context, 'Successfully registred');
        if (accType == 'groom' || accType == 'bride') {
          Navigator.pushReplacementNamed(context, BridellaScaffold.routeName);
        } else if (accType == 'guest') {
          Navigator.pushReplacementNamed(context, GuestScaffold.routeName);
        }
      });

      //  await sendEmailVerification(context);
    } on FirebaseAuthException catch (e) {
      // if you want to display your own custom error message

      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              scrollable: true,
              content: Text(e.message!),
              elevation: 2,
            );
          });
      // Displaying the usual firebase error message
    }
  }

  // EMAIL LOGIN
  Future<void> loginWithEmail({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    try {
      await _auth
          .signInWithEmailAndPassword(
        email: email,
        password: password,
      )
          .then((value) {
        if (value.user != null) {
          showSnackBar(context, 'Successfully login');

          Navigator.pushReplacementNamed(
              context, BridellaAuthProvider.routeName);
        }
      });

      /* if (!user.emailVerified) {
        await sendEmailVerification(context);
        // restrict access to certain things using provider
        // transition to another page instead of home screen
      }*/
    } on FirebaseAuthException catch (e) {
      if (e.code == 'wrong-password') {
        showSnackBar(context, 'The password is wrong');
      } else {
        showSnackBar(context, e.message!);
      }
      // Displaying the usual firebase error message
    }
  }

  // EMAIL VERIFICATION
  Future<void> sendEmailVerification(BuildContext context) async {
    try {
      _auth.currentUser!.sendEmailVerification();
      showSnackBar(context, 'Email verification sent!');
      message('Email verification sent!');
      showSnackBar(context, 'Task successfully added');
    } on FirebaseAuthException catch (e) {
      ; // Display error message
      showSnackBar(context, e.message!);
    }
  }
/*
  // GOOGLE SIGN IN
  Future<void> signInWithGoogle(BuildContext context) async {
    try {
      if (kIsWeb) {
        GoogleAuthProvider googleProvider = GoogleAuthProvider();

        googleProvider
            .addScope('https://www.googleapis.com/auth/contacts.readonly');

        await _auth.signInWithPopup(googleProvider);
      } else {
        final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

        final GoogleSignInAuthentication? googleAuth =
            await googleUser?.authentication;

        if (googleAuth?.accessToken != null && googleAuth?.idToken != null) {
          // Create a new credential
          final credential = GoogleAuthProvider.credential(
            accessToken: googleAuth?.accessToken,
            idToken: googleAuth?.idToken,
          );
          UserCredential userCredential =
              await _auth.signInWithCredential(credential);

          // if you want to do specific task like storing information in firestore
          // only for new users using google sign in (since there are no two options
          // for google sign in and google sign up, only one as of now),
          // do the following:

          // if (userCredential.user != null) {
          //   if (userCredential.additionalUserInfo!.isNewUser) {}
          // }
        }
      }
    } on FirebaseAuthException catch (e) {
      showSnackBar(context, e.message!); // Displaying the error message
    }
  }

*/

  // SIGN OUT
  Future<void> signOut(BuildContext context) async {
    try {
      await _auth.signOut().then((value) {
        Navigator.pop(context);
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (BuildContext context) => const SignInScreen()));
      });
    } on FirebaseAuthException catch (e) {
      showSnackBar(context, e.message!); // Displaying the error message
    }
  }

  // DELETE ACCOUNT
  Future<void> deleteAccount(BuildContext context) async {
    try {
      await _auth.currentUser!.delete();
    } on FirebaseAuthException catch (e) {
      showSnackBar(context, e.message!); // Displaying the error message
      // if an error of requires-recent-login is thrown, make sure to log
      // in user again and then delete account.
    }
  }
}
