import 'package:flutter/cupertino.dart';

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

  void addItem(String productId, String title, double price, String imageUrl) {
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
