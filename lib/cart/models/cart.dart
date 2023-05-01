import 'dart:collection';

import 'package:bridella/business/models/market_place.dart';
import 'package:flutter/material.dart';

class OrderProduct {
  BridellaProduct item;
  int quantity;
  List? options;
  double subTotal;
  OrderProduct({
    required this.item,
    required this.quantity,
    this.options,
    required this.subTotal,
  });
}

class BridellaCart extends ChangeNotifier {
  final List<OrderProduct> _orderList = [
    /* OrderProduct(
      item: BridellaProduct(
          productId: '01',
          productAvailable: true,
          productImgs: {
            '0': "assets/testImages/shoes.png",
          },
          productName: 'product 1',
          productPrice: 10,
          promoPrice: 9,
          inPromo: false,
          shortDesc: 'description',
          longDesc:
              '''Lorem ipsum dolor sit amet, consectetur adipiscing elit. Etiam tempor porta elementum. Praesent tempor blandit enim eget ultricies. Integer dapibus hendrerit massa ac hendrerit. Nunc quis tellus eleifend, rhoncus velit posuere, volutpat felis. Fusce a diam ac magna lacinia fringilla. Mauris dui sem, ornare nec massa ac, dignissim eleifend magna. Etiam sed lorem eget ipsum eleifend maximus vel et purus. Ut dapibus lacus volutpat, maximus nisi ac, commodo erat.''',
          ratingScore: 4.9,
          options: {}),
      quantity: 2,
      options: [],
      subTotal: 35,
    ),*/
  ];
  UnmodifiableListView<OrderProduct> get cart =>
      UnmodifiableListView<OrderProduct>(_orderList);

  double get cartTotal {
    double tot = 0.0;
    for (var item in cart) {
      tot += item.subTotal * item.quantity;
    }
    return tot;
  }

  int get cartUniqueItems {
    return cart.length;
  }

  int get cartTotalItems {
    num count = 0;
    for (var item in cart) {
      count += item.quantity;
    }
    return count.toInt();
  }

  void addToCart(OrderProduct item) {
    int index = _orderList.indexWhere(((element) =>
        element.item.productName == item.item.productName &&
        element.options == item.options));
    if (index >= 0) {
      OrderProduct itemInCart = _orderList[index];
      OrderProduct itemUpdate = OrderProduct(
        item: item.item,
        quantity: itemInCart.quantity + item.quantity,
        options: item.options,
        subTotal: item.subTotal,
      );
      _orderList.insert(index, itemUpdate);
      _orderList.remove(itemInCart);
    } else {
      _orderList.add(item);
    }
    notifyListeners();
  }

  void removeItem(OrderProduct item) {
    _orderList.remove(item);
    notifyListeners();
  }

  void incrementItemQty(OrderProduct item) {
    int index = _orderList.indexOf(item);
    OrderProduct updatedItem = OrderProduct(
      item: item.item,
      quantity: item.quantity + 1,
      options: item.options,
      subTotal: item.subTotal,
    );
    OrderProduct itemInCart = _orderList[index];
    _orderList.remove(itemInCart);
    _orderList.insert(index, updatedItem);
    notifyListeners();
  }

  void decrementItemQty(OrderProduct item) {
    int index = _orderList.indexOf(item);
    int newQty = item.quantity - 1;
    if (newQty > 0) {
      OrderProduct updatedItem = OrderProduct(
        item: item.item,
        quantity: newQty,
        options: item.options,
        subTotal: item.subTotal,
      );
      OrderProduct itemInCart = _orderList[index];
      _orderList.insert(index, updatedItem);
      _orderList.remove(itemInCart);
    } else {
      _orderList.remove(item);
    }
    notifyListeners();
  }

  void emptyCart() {
    _orderList.clear();
    notifyListeners();
  }
}
