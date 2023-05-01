import 'dart:math';

import 'package:bridella/planner/models/budget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../app_core/services/show_snackbar.dart';

class BudgetDB {
  //Create serviniownerUser object from database
  Budget? _budgetFromFB(DocumentSnapshot snapshot) {
    if (snapshot.exists) {
      Map<String, dynamic> budgetData = snapshot.data() as Map<String, dynamic>;

      Map<String, dynamic> productsMap =
          budgetData['products'] is Map<String, dynamic>
              ? budgetData['products']
              : {};
      List<BudgetItem> budgetItemsList =
          List<BudgetItem>.from(productsMap.entries.map((product) {
        Map<String, dynamic> productData = product.value;
        num productPrice =
            productData['price'] is num ? productData['price'] : 0;
        num estimatedPrice = productData['estimatedPrice'] is num
            ? productData['estimatedPrice']
            : 0;
        return BudgetItem(
            id: product.key,
            title: productData['name'] ?? 'Undefined',
            estimatedPrice: estimatedPrice.toDouble(),
            price: productPrice.toDouble(),
            certifiedBridella: productData['certifiedBridella'] ?? false,
            flaged: false,
            completed: false);
      }));

      return Budget(budgetItemsList);

      // if we gonna acess the object from this object we define it as a list else as a map
    } else {
      return null;
    }
  }

  final CollectionReference _users =
      FirebaseFirestore.instance.collection('users');
  //Database serviniownerUser stream
  Stream<Budget?> budgetFromFirebase(String uid) {
    return _users
        .doc(uid)
        .collection('budget')
        .doc(uid)
        .snapshots()
        .map(_budgetFromFB);
  }

  // Create a budget item that have the same creator ID
  Future createBudgetItem(
      String uid, String itemKey, Map<String, dynamic> itemData) async {
    final CollectionReference budget = FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .collection('budget');

    await budget
        .doc(uid)
        .set({
          'products': {itemKey: itemData}
        }, SetOptions(merge: true))
        .then((value) => message('Product added'))
        .catchError(
            (error) => message('Somthing went wrong! Please try later'));
  }

  // Create a budget item that have the same creator ID
  Future editItem(String uid, Map<String, dynamic> itemsData) async {
    final CollectionReference budget = FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .collection('budget');
    await budget.doc(uid).set(
        {"products": itemsData}, SetOptions(merge: true)).catchError((error) {
      return message('Somthing went wrong! Please try later');
    });
  }

  // Delete the 'age' field from the document with ID 'userId'
  void deleteBudgetItem(String uid, String productID) {
    final CollectionReference budget = FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .collection('budget');

    budget
        .doc(uid)
        .set({
          'products': {productID: FieldValue.delete()}
        }, SetOptions(merge: true))
        .then((value) => message('Product deleted'))
        .catchError(
            (error) => message('Somthing went wrong! Please try later'));
  }
}
