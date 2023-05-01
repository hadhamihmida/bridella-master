import 'package:bridella/app_core/services/show_snackbar.dart';
import 'package:bridella/wishes/models/wish.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class WishDataBase {
  // firestore references
  final CollectionReference _wishes =
      FirebaseFirestore.instance.collection('wishes');

  Stream<List<Wish>>? wishesFromFirestore(String email) {
    try {
      return _wishes
          .where('ownerEmail', isEqualTo: email)
          .snapshots()
          .map((wishes) => wishes.docs.map((doc) {
                Map<String, dynamic> wishMap =
                    doc.data() as Map<String, dynamic>;
                // wishMap['wishId'] = doc.id;
                return Wish.fromMap(wishMap);
              }).toList());
    } catch (e) {
      print(e);
    }
    return null;
  }

  Stream<List<Post>>? postsFromFireStore() {
    return _wishes.snapshots().map((wishes) => wishes.docs.map((doc) {
          Map<String, dynamic> wishMap = doc.data() as Map<String, dynamic>;

          print(wishMap);
          return Post(wish: Wish.fromMap(wishMap));
        }).toList());
  }

  // Create a wish that have the same creator ID
  Future createWish(Map<String, dynamic> wishData) async {
    String docId = _wishes.doc().id;
    wishData['wishId'] = docId;
    await _wishes.doc(docId).set(wishData);
  }

  // Create a wish that have the same creator ID
  Future deleteWish(String wishId) async {
    _wishes.doc(wishId).delete().then(
          (value) => message('Wish deleted'),
          onError: (e) => message('Somthing went wrong , Try later'),
        );
  }
}
