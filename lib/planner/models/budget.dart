import 'dart:typed_data';

class Budget {
  final List<BudgetItem> items;
  double get getAllTotal {
    double total = 0;
    for (var item in items) {
      if (item.price == 0 || item.price == null) {
        total += item.estimatedPrice;
      } else {
        total += item.price!;
      }
    }
    return total;
  }

  /* double get getCompletedTotal {
    double total = 0;
    for (var item in items.where((item) => item.completed)) {
      if (item.price == 0 || item.price == null) {
        total += item.estimatedPrice;
      } else {
        total += item.price!;
      }
    }
    return total;
  }

  double get getUncompletedTotal {
    double total = 0;
    for (var item in items.where((item) => !item.completed)) {
      if (item.price == 0 || item.price == null) {
        total += item.estimatedPrice;
      } else {
        total += item.price!;
      }
    }
    return total;
  }

  double get getFlagedTotal {
    double total = 0;
    for (var item in items.where((item) => item.flaged)) {
      if (item.price == 0 || item.price == null) {
        total += item.estimatedPrice;
      } else {
        total += item.price!;
      }
    }
    return total;
  }*/

  Budget(this.items);
}

class BudgetItem {
  final String id;
  final String title;
  final String? desc;
  double estimatedPrice;
  final double? price;
  final bool? certifiedBridella;
  // localy
  bool flaged;
  bool completed;

  BudgetItem({
    required this.id,
    required this.title,
    this.desc,
    this.certifiedBridella,
    required this.estimatedPrice,
    this.price,
    required this.flaged,
    required this.completed,
  });
}



/// User {
/// 
/// name
/// email
/// etc...
/// 
/// budget {
/// '1' : item1,
/// '2' : item2, 
/// etc...
///
/// }
/// 
/// 
/// 
/// }
/// maybe: the standards items are saved localy.
/// 
/// to update an estimated price to a the real price(of purshasing) we can 
/// do that from list of orders. (assign an order to a budget element ==> updating the price )