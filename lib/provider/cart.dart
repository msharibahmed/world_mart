
import 'package:flutter/material.dart';

class CartItem {
  final String id;
  final String title;
  final int quantity;
  final double price;
  final String imageUrl;
  CartItem(
      {@required this.id,
      @required this.price,
      @required this.quantity,
      @required this.title,
      @required this.imageUrl});
}

class Cart with ChangeNotifier {
  Map<String, CartItem> _items = {};
  Map<String, CartItem> get items {
    return {..._items};
  }

  int get itemCount {
    return _items.length;
  }

  // List<String> get itemNames {
  //   var list = [];
  //   _items.entries.forEach((element) {
  //     list.add(element.value.title);
  //   });
  //   return list;
  // }

  // List<int> get quantity {
  //    var list = [];
  //   // _items.entries.forEach((element) {
  //   //   list.add(element.value.quantity);
  //   // });
  //   return list=[2,3];
  // }

  double get totalAmount {
    var total = 0.0;

    for (var a = 0; a < (items.length); a++) {
      total = total +
          (items.values.toList()[a].price * items.values.toList()[a].quantity);
    }

    return total;
  }

  void increment(String productId) {
    _items.update(
        productId,
        (existingItem) => CartItem(
            imageUrl: existingItem.imageUrl,
            id: existingItem.id,
            price: existingItem.price,
            quantity: existingItem.quantity + 1,
            title: existingItem.title));
    notifyListeners();
  }

  void deleteCartItem(String productId) {
    _items.remove(productId);
    notifyListeners();
  }

  void decrement(String productId, int endex) {
    _items.update(
        productId,
        (existingItem) => CartItem(
            imageUrl: existingItem.imageUrl,
            id: existingItem.id,
            price: existingItem.price,
            quantity: existingItem.quantity - 1,
            title: existingItem.title));
    if (items.values.toList()[endex].quantity <= 0) {
      _items.remove(productId);
    }
    notifyListeners();
  }

  void clearCart() {
    _items.clear();
    notifyListeners();
  }

  SnackBar snackBar(String message) {
    final snackBar = SnackBar(
        duration: Duration(seconds: 1),
        backgroundColor: Colors.deepOrange[100],
        elevation: 10,
        content: Text(message,
            style:
                TextStyle(color: Colors.black, fontWeight: FontWeight.bold)));
    return snackBar;
  }

  Future<void> addItem(
      String productId, String title, double price, String imageUrl) async {
    // final url = 'https://world-cart-f1544.firebaseio.com/cart.json';

    // final response = await http.get(url);
    // final cartMap = jsonDecode(response.body) as Map<String, dynamic>;
    // print(cartMap);

  
    //   cartMap.update(
    //       productId,
    //       (existingItem) => CartItem(
    //           imageUrl: existingItem.imageUrl,
    //           id: existingItem.id,
    //           price: existingItem.price,
    //           quantity: existingItem.quantity + 1,
    //           title: existingItem.title));

    // final newCart = CartItem(
    //     id: jsonDecode(response.body),
    //     price: price,
    //     quantity: 1,
    //     title: title,
    //     imageUrl: imageUrl);
    //     _items.addEntries(newEntries)

    if (_items.containsKey(productId)) {
      _items.update(
          productId,
          (existingItem) => CartItem(
              imageUrl: existingItem.imageUrl,
              id: existingItem.id,
              price: existingItem.price,
              quantity: existingItem.quantity + 1,
              title: existingItem.title));
    } else {
      _items.putIfAbsent(
          productId,
          () => CartItem(
              imageUrl: imageUrl,
              id: DateTime.now().toIso8601String(),
              title: title,
              price: price,
              quantity: 1));
    }
    notifyListeners();
  }
}
